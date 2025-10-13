-- Reusable function to format Go buffer
function format_go_buffer(bufnr)
  bufnr = bufnr or 0
  local root = vim.fs.find({ ".golangci.yaml", ".golangci.yml" }, {
    upward = true,
    path = vim.fn.getcwd(),
  })[1]

  if root then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local text = table.concat(lines, "\n")

    local output = {}
    local errors = {}

    local job_id = vim.fn.jobstart({ "golangci-lint", "fmt", "--stdin" }, {
      stdin = "pipe",
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.list_extend(output, data)
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.list_extend(errors, data)
        end
      end,
    })

    if job_id <= 0 then
      vim.notify("Failed to start golangci-lint fmt", vim.log.levels.ERROR)
      return
    end

    vim.fn.chansend(job_id, text)
    vim.fn.chanclose(job_id, "stdin")

    -- Wait up to 2s and capture exit code
    local status = vim.fn.jobwait({ job_id }, 2000)[1]

    -- Only treat as error if nonzero exit
    if status ~= 0 then
      local msg = #errors > 0 and table.concat(errors, "\n") or "unknown error"
      vim.notify("golangci-lint fmt failed:\n" .. msg, vim.log.levels.WARN)
      return
    end

    -- If exit code == 0, safely replace buffer
    if #output > 0 then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
    end
  else
    local orig_notify = vim.notify

    vim.notify = function(msg, ...)
      if msg:match("position_encoding param is required") then return end
      orig_notify(msg, ...)
    end

    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    if not results then return end

    for _, res in pairs(results) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        elseif r.command then
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end

    vim.notify = orig_notify
  end
end
