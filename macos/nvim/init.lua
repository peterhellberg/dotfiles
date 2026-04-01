vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/vim-vsnip',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/vimwiki/vimwiki',
  'https://github.com/preservim/nerdtree',
  'https://github.com/itchyny/lightline.vim',
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/Yggdroot/LeaderF',
  'https://github.com/honza/vim-snippets',
  'https://github.com/mileszs/ack.vim',
}

require('nvim-treesitter').setup()

local oil = require("oil")

oil.setup({
  use_default_keymaps = false,
  keymaps = {
    ["h"] = "actions.parent",
    ["l"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["s"] = { "actions.select", opts = { vertical = true } },
    ["t"] = { "actions.select", opts = { tab = true } },
    ["q"] = "actions.close",
    ["g?"] = "actions.show_help",
    ["g."] = "actions.toggle_hidden",
  },
  float = {
    border = "rounded",
    max_width = 0.4,
    max_height = 0.8,
    win_options = {
      winblend = 0
    },
  },
})

require("functions")
require("commands")
require("core")
require("lsp")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
