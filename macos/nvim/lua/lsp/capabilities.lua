local M = {}

local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
M.capabilities = has_cmp and cmp.default_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

return M.capabilities
