-- git clone https://github.com/hrsh7th/cmp-nvim-lsp ~/.config/nvim/pack/nvim/start/cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        modernize = false,
      },
      gofumpt = true,
      staticcheck = true,
    },
  },
  capabilities = capabilities,
}
