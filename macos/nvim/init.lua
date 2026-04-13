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
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/Yggdroot/LeaderF',
  'https://github.com/honza/vim-snippets',
  'https://github.com/kungfusheep/mfd.nvim',
}

require("functions")
require("commands")
require("core")
require("lsp")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.o.smoothscroll = true
vim.o.laststatus = 3
vim.o.pumblend = 0
vim.o.winblend = 0
vim.o.winborder = "rounded"

vim.opt.shortmess:append("filnxtToOFcC")

require('vim._core.ui2').enable({
  enable = true,
  msg = {
    targets = {
      [''] = 'msg',
      empty = 'cmd',
      bufwrite = 'msg',
      confirm = 'cmd',
      emsg = 'pager',
      echo = 'msg',
      echomsg = 'msg',
      echoerr = 'pager',
      completion = 'cmd',
      list_cmd = 'pager',
      lua_error = 'pager',
      lua_print = 'msg',
      progress = 'pager',
      rpc_error = 'pager',
      quickfix = 'msg',
      search_cmd = 'cmd',
      search_count = 'cmd',
      shell_cmd = 'pager',
      shell_err = 'pager',
      shell_out = 'pager',
      shell_ret = 'msg',
      undo = 'msg',
      verbose = 'pager',
      wildlist = 'cmd',
      wmsg = 'msg',
      typed_cmd = 'cmd',
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 2000,
    },
    pager = {
      height = 0.5,
    },
  },
})

local oil = require("oil")

oil.setup({
 use_default_keymaps = false,
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
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
    max_width = 0.5,
    max_height = 0.6,
    win_options = {
      winblend = 0
    },
    override = function(conf)
      conf.row = 1
      conf.col = math.floor((vim.o.columns - conf.width) / 2)
      return conf
    end,
  },
})

local function is_oil_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:sub(1, 6) == "oil://" then
      return win
    end
  end
end

local function toggle_oil()
  local win = is_oil_open()
  if win then
    vim.api.nvim_win_close(win, true)
  else
    oil.open_float()
  end
end

vim.keymap.set("n", "<leader>n", toggle_oil, { desc = "Toggle Oil" })

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
