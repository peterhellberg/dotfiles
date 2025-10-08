return {
  on_init = function(client)
    client.notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end,
  on_attach = function(client, bufnr)
    local orig_notify = vim.notify

    vim.notify = function(msg, ...)
      if msg:match("position_encoding param is required") then return end
      orig_notify(msg, ...)
    end

    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end

    vim.notify = orig_notify
  end,
  settings = {
    gopls = {
      analyses = {
        unusedvariable = false,
        deprecated = false,
      },
      staticcheck = true,
    },
  },
  capabilities = require("core.lsp.capabilities"),
}
