-- Format Go buffer with fallback to goimports and optional golangci-lint
function format_go_buffer(bufnr)
  bufnr = bufnr or 0
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return
  end

  local start_dir = vim.fs.dirname(fname)
  local has_golangci_yaml = vim.fs.find({ ".golangci.yaml", ".golangci.yml" }, {
    upward = true,
    path = start_dir,
  })[1]
  local has_golangci_bin = vim.fn.executable("golangci-lint") == 1
  local has_goimports = vim.fn.executable("goimports") == 1

  local function clean_output(lines)
    while #lines > 0 and lines[#lines]:match("^%s*$") do
      table.remove(lines)
    end
    return lines
  end

  local function populate_quickfix(errors)
    local qf_list = {}
    for _, line in ipairs(errors) do
      local lnum, col, msg = line:match("^<standard input>:(%d+):(%d+): (.+)$")
      if lnum then
        table.insert(qf_list, {
          filename = fname,
          lnum = tonumber(lnum),
          col = tonumber(col),
          text = msg,
        })
      end
    end
    if #qf_list > 0 then
      vim.fn.setqflist({}, " ", { title = "goimports errors", items = qf_list })
      vim.schedule(function() vim.cmd("copen") end)
    end
  end

  -- if goimports isn't available, fallback to LSP organizeImports
  if not has_goimports then
    vim.notify("goimports not found, using LSP organizeImports", vim.log.levels.INFO)
    local orig_notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match("position_encoding param is required") then return end
      orig_notify(msg, ...)
    end

    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    if results then
      for _, res in pairs(results) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
          elseif r.command then
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end

    vim.notify = orig_notify
    return
  end

  -- Run goimports first
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local text = table.concat(lines, "\n")
  local output_goimports, errors = {}, {}

  local job_goimports = vim.fn.jobstart({ "goimports" }, {
    stdin = "pipe",
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then vim.list_extend(output_goimports, data) end
    end,
    on_stderr = function(_, data)
      if data then vim.list_extend(errors, data) end
    end,
  })

  if job_goimports <= 0 then
    vim.notify("Failed to start goimports", vim.log.levels.ERROR)
    return
  end

  vim.fn.chansend(job_goimports, text)
  vim.fn.chanclose(job_goimports, "stdin")
  local status = vim.fn.jobwait({ job_goimports }, 3000)[1]

  if status ~= 0 then
    populate_quickfix(errors)
    vim.schedule(function()
      vim.notify("goimports failed, see quickfix list", vim.log.levels.WARN)
    end)
    return
  end

  -- If golangci-lint exists, optionally run it on the goimports output
  if has_golangci_yaml and has_golangci_bin then
    local output_fmt, errors_fmt = {}, {}

    local job_fmt = vim.fn.jobstart({ "golangci-lint", "run", "--out-format", "tab" }, {
      stdin = "pipe",
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then vim.list_extend(output_fmt, data) end
      end,
      on_stderr = function(_, data)
        if data then vim.list_extend(errors_fmt, data) end
      end,
    })

    if job_fmt > 0 then
      vim.fn.chansend(job_fmt, table.concat(output_goimports, "\n"))
      vim.fn.chanclose(job_fmt, "stdin")
      vim.fn.jobwait({ job_fmt }, 2000)
      if #errors_fmt > 0 then
        vim.schedule(function()
          vim.notify("golangci-lint found issues", vim.log.levels.WARN)
        end)
      end
    else
      vim.notify("Failed to start golangci-lint", vim.log.levels.WARN)
    end
  end

  -- Apply formatted output
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, clean_output(output_goimports))
end
