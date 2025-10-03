vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.enable({
  'gopls',
  'zls',
  --'clangd',
})

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = false,
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
