-- Reusable function to format Go buffer with non-blocking quickfix
function format_go_buffer(bufnr)
  bufnr = bufnr or 0
  local root = vim.fs.find({ ".golangci.yaml", ".golangci.yml" }, {
    upward = true,
    path = vim.fn.getcwd(),
  })[1]

  local function clean_output(lines)
    while #lines > 0 and lines[#lines]:match("^%s*$") do
      table.remove(lines)
    end
    return lines
  end

  local function populate_quickfix(errors)
    local qf_list = {}
    local fname = vim.api.nvim_buf_get_name(bufnr)

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
      vim.schedule(function()
        vim.cmd("copen")
      end)
    end
  end

  if root then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local text = table.concat(lines, "\n")
    local output_goimports = {}
    local errors = {}

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
      vim.schedule(function()
        vim.notify("Failed to start goimports", vim.log.levels.ERROR)
      end)
      return
    end

    vim.fn.chansend(job_goimports, text)
    vim.fn.chanclose(job_goimports, "stdin")

    local status = vim.fn.jobwait({ job_goimports }, 2000)[1]

    if status ~= 0 then
      -- Populate quickfix and open it
      populate_quickfix(errors)
      -- Optional non-blocking notification
      vim.schedule(function()
        vim.notify("goimports failed, see quickfix list", vim.log.levels.WARN)
      end)
      return
    end

    local output_fmt = {}
    errors = {}

    local job_fmt = vim.fn.jobstart({ "golangci-lint", "fmt", "--stdin" }, {
      stdin = "pipe",
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then vim.list_extend(output_fmt, data) end
      end,
      on_stderr = function(_, data)
        if data then vim.list_extend(errors, data) end
      end,
    })

    if job_fmt <= 0 then
      vim.schedule(function()
        vim.notify("Failed to start golangci-lint fmt", vim.log.levels.ERROR)
      end)
      return
    end

    vim.fn.chansend(job_fmt, table.concat(output_goimports, "\n"))
    vim.fn.chanclose(job_fmt, "stdin")

    status = vim.fn.jobwait({ job_fmt }, 2000)[1]

    if status ~= 0 then
      vim.schedule(function()
        vim.notify("golangci-lint fmt failed", vim.log.levels.WARN)
      end)
      return
    end

    if #output_fmt > 0 then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, clean_output(output_fmt))
    end
  else
    -- fallback: use LSP organizeImports
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
  end
end
