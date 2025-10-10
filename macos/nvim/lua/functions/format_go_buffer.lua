-- Reusable function to format Go buffer
function format_go_buffer(bufnr)
  bufnr = bufnr or 0 -- default to current buffer

  -- Find golangci-lint config in the project root
  local root = vim.fs.find({ ".golangci.yaml", ".golangci.yml" }, {
    upward = true,
    path = vim.fn.getcwd(),
  })[1]

  if root then
    -- golangci-lint config exists → use golangci-lint fmt
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local text = table.concat(lines, "\n")

    local cmd = { "golangci-lint", "fmt", "--stdin" }
    local new_lines = vim.fn.systemlist(cmd, text)

    if vim.v.shell_error ~= 0 then
      vim.notify("golangci-lint fmt failed:\n" .. table.concat(new_lines, "\n"), vim.log.levels.WARN)
      return
    end

    -- Replace buffer lines (undo-safe)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
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

