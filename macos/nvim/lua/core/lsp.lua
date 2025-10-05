vim.lsp.enable({
  'gopls',
  'zls',
  'clangd',
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP:", client.name)
  end
})

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'solid',
    source = true,
    focusable = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.HINT]  = '⚑',
      [vim.diagnostic.severity.INFO]  = '»',
    },
  }
})
