-- Format Go buffer with goimports and optional golangci-lint check
function format_go_buffer(bufnr)
  bufnr = bufnr or 0
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return vim.notify("No file name for current buffer", vim.log.levels.WARN)
  end

  local start_dir = vim.fs.dirname(fname)
  local has_goimports = vim.fn.executable("goimports") == 1
  local has_linter = vim.fn.executable("golangci-lint") == 1
    and vim.fs.find({ ".golangci.yaml", ".golangci.yml" }, { upward = true, path = start_dir })[1]

  local function clean(lines)
    while #lines > 0 and lines[#lines]:match("^%s*$") do table.remove(lines) end
    return lines
  end

  local function run_job(cmd, input)
    local out, err = {}, {}
    local job = vim.fn.jobstart(cmd, {
      stdin = "pipe", stdout_buffered = true, stderr_buffered = true,
      on_stdout = function(_, data) if data then vim.list_extend(out, data) end end,
      on_stderr = function(_, data) if data then vim.list_extend(err, data) end end,
    })
    if job <= 0 then return nil, { "failed to start " .. cmd[1] } end
    vim.fn.chansend(job, input); vim.fn.chanclose(job, "stdin")
    vim.fn.jobwait({ job }, 3000)
    return clean(out), clean(err)
  end

  -- Fallback to LSP organizeImports if goimports missing
  if not has_goimports then
    vim.notify("goimports not found, using LSP organizeImports", vim.log.levels.INFO)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
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
    return
  end

  -- Run goimports
  local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local formatted, goerr = run_job({ "goimports" }, text)
  if not formatted or #goerr > 0 then
    vim.notify("goimports failed", vim.log.levels.WARN)
    return
  end

  -- Optionally run golangci-lint
  if has_linter then
    local lint_out = run_job({ "golangci-lint", "run", "--out-format", "tab" }, table.concat(formatted, "\n"))
    local found = false
    for _, line in ipairs(lint_out or {}) do
      if line:match("%.go:%d+:%d+:") then found = true break end
    end
    if found then
      vim.notify("golangci-lint found issues", vim.log.levels.WARN)
    end
  end

  -- Apply formatted output
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
end
