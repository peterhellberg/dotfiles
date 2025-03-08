local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- git clone https://github.com/hrsh7th/nvim-cmp ~/.config/nvim/pack/nvim/start/nvim-cmp
local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback) 
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
  	end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback) 
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
  	end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' }
  },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- git clone https://github.com/hrsh7th/cmp-nvim-lsp ~/.config/nvim/pack/nvim/start/cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
require'lspconfig'.zls.setup{
  capabilities = capabilities,
}

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "§", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
