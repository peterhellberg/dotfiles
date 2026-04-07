vim.pack.add {
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/vim-vsnip',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/vimwiki/vimwiki',
  'https://github.com/preservim/nerdtree',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/Yggdroot/LeaderF',
  'https://github.com/honza/vim-snippets',
  'https://github.com/mileszs/ack.vim',
  'https://github.com/kungfusheep/mfd.nvim',
}

require("functions")
require("commands")
require("core")
require("lsp")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

local oil = require("oil")

oil.setup({
  use_default_keymaps = false,
  keymaps = {
    ["h"] = "actions.parent",
    ["l"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["s"] = { "actions.select", opts = { vertical = true } },
    ["q"] = "actions.close",
    ["g?"] = "actions.show_help",
    ["<S-i>"] = "actions.toggle_hidden",
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

local sections = {
  lualine_a = {
    {'mode', fmt = function(str) return str:sub(1,1) end },
  },
  lualine_b = {'filename'},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {'filetype', 'branch', 'location'},
  lualine_z = {},
}

require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = {
      statusline = {'markdown'},
    },
  },
  sections = sections,
  inactive_sections = sections,
  theme = require('lualine.themes.auto'),
}

-- function to clear lualine_c background for all modes
local function clear_lualine_c_bg()
  local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
  for _, mode in ipairs(modes) do
    vim.cmd(string.format("hi lualine_c_%s guibg=NONE", mode))
  end
end

vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
  callback = clear_lualine_c_bg
})
