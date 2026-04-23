---@type vim.lsp.Config
return {
  cmd = { 'php-lsp' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  workspace_required = true,
  init_options = {
    phpVersion = '8.5',
    excludePaths = {},
  },
}
