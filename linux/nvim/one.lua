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
  'https://github.com/mileszs/ack.vim',
}

require('vim._core.ui2').enable({})

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
      statusline = {'nerdtree'},
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

vim.o.background = "dark"
vim.cmd([[colorscheme default]])

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noinsert"
vim.opt.smarttab = true

vim.opt.complete:append("k")

-- Use comma as the mapleader
vim.g.mapleader = ","

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Leader>n", function()
  oil.open_float(vim.fn.expand("%:p:h"))
end, opts)
keymap('n', '<Leader>s<Left>', ':leftabove vnew<CR>', opts)
keymap('n', '<Leader>s<Right>', ':rightbelow vnew<CR>', opts)
keymap('n', '<Leader>s<Up>', ':leftabove new<CR>', opts)
keymap('n', '<Leader>s<Down>', ':rightbelow new<CR>', opts)
keymap('n', '<Space>', ':', opts)
keymap('n', '<Tab>', '<c-w>w', opts)
keymap('n', '<S-Tab>', '<c-w>W', opts)
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)

if vim.fn.bufwinnr(1) > 0 then
  keymap('n', 'ö', '<C-W><<C-W><', opts)
  keymap('n', 'ä', '<C-W>><C-W>>', opts)
  keymap('n', 'Ä', '<C-W>-<C-W>-', opts)
  keymap('n', 'Ö', '<C-W>+<C-W>+', opts)
end

-- Manually configure ZLS for Zig files

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "zig" then
      vim.bo.omnifunc = "" -- disable default omnifunc
    end
  end,
})

local zls_cmd = { "zls" }
local zls_settings = {}

local function on_attach(_, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "§", ":lua vim.lsp.buf.hover({border = 'rounded', max_width = 80})<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "^", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "¨", ":lua vim.lsp.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", opts)
end

local function start_zls()
  vim.lsp.start({
    name = "zls",
    cmd = zls_cmd,
    root_dir = vim.loop.cwd(),
    settings = zls_settings,
    on_attach = on_attach,
    filetypes = { "zig" },
  })
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  --vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Format-on-save for this buffer only
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,           -- buffer-local
    callback = function()
      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
      for _, client in pairs(clients) do
        if client.name == "zls" and client.server_capabilities.documentFormattingProvider then
          vim.lsp.buf.format({ bufnr = bufnr })
          break
        end
      end
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zig",
  callback = start_zls,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- TAB completion

local term = function(key)
  return vim.api.nvim_replace_termcodes(key, true, false, true)
end

local function pum_map(when_visible, fallback)
  return function()
    if vim.fn.pumvisible() == 1 then
      return term(when_visible)
    else
      return fallback
    end
  end
end

vim.keymap.set("i", "<Tab>", pum_map("<C-n>", "<Tab>"), { expr = true })
vim.keymap.set("i", "<S-Tab>", pum_map("<C-p>", "<S-Tab>"), { expr = true })
vim.keymap.set("i", "<CR>", pum_map("<C-y>", "<CR>"), { expr = true })
vim.keymap.set("i", "<Esc>", pum_map("<C-e>", "<Esc>"), { expr = true })
vim.keymap.set("i", "j", pum_map("<C-n>", "j"), { expr = true })
vim.keymap.set("i", "k", pum_map("<C-p>", "k"), { expr = true })

vim.keymap.set("i", "<C-Space>", function()
  if vim.bo.omnifunc ~= "" and vim.bo.omnifunc ~= nil then
    return term("<C-x><C-o>")
  else
    return term("<C-x><C-n>")
  end
end, { expr = true })

-- Highlighting

local hi = vim.api.nvim_set_hl

hi(0, "Comment", { fg = "#888888" })
hi(0, "Conditional", { fg = "#8197BE" })
hi(0, "Constant", { fg = "#CF6A4C" })
hi(0, "Delimiter", { fg = "#799D6A" })
hi(0, "DiagnosticError", { fg = "#D35738" })
hi(0, "DiagnosticHint", { fg = "#8197BE" })
hi(0, "DiagnosticInfo", { fg = "#E8E8D3" })
hi(0, "DiagnosticUnderlineError", { sp = "#D35738", underline = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#8197BE", underline = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#E8E8D3", underline = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#FFB964", underline = true })
hi(0, "DiagnosticWarn", { fg = "#FFB964" })
hi(0, "Directory", { fg = "#FFB964" })
hi(0, "ErrorMsg", { fg = "#605958" })
hi(0, "FloatBorder", { fg = "#555555" })
hi(0, "Function", { fg = "#FAD07A" })
hi(0, "GitGutterAdd",    { fg = "#97a950", bg = "#2D3218" })
hi(0, "GitGutterChange", { fg = "#FFB964", bg = "#4c371e" })
hi(0, "GitGutterDelete", { fg = "#d35738", bg = "#3f1a10" })
hi(0, "Identifier", { fg = "#C6B6EE" })
hi(0, "Include", { fg = "#8FBFDC" })
hi(0, "Keyword", { fg = "#8197BE" })
hi(0, "Label", { fg = "#8197BF" })
hi(0, "LineNr", { fg = "#605958" })
hi(0, "Macro", { fg = "#8FBFDC" })
hi(0, "ModeMsg", { fg = "#FFFFFF", bg = "#0087AF" })
hi(0, "MoreMsg", { fg = "#605958" })
hi(0, "Normal", { fg = "#E8E8D3", bg = "#151515" })
hi(0, "NormalFloat", { bg = "#151515" })
hi(0, "Number", { fg = "#CF6A4C" })
hi(0, "OkMsg", { fg = "#99AD6A" })
hi(0, "Pmenu", { fg = "#E8E8D3", bg = "#1a1a1a" })
hi(0, "PmenuSbar", { bg = "#222222" })
hi(0, "PmenuSel", { fg = "#E8E8D3", bg = "#2a2a2a", bold = true })
hi(0, "PmenuThumb", { bg = "#605958" })
hi(0, "PreProc", { fg = "#8FBFDC" })
hi(0, "Question", { fg = "#E6E6CD" })
hi(0, "Repeat", { fg = "#8197BF" })
hi(0, "Search", { standout = true, reverse = true })
hi(0, "SignColumn", { link = "LineNr" })
hi(0, "Special", { fg = "#799D6A" })
hi(0, "SpecialChar", { fg = "#C6B6EE" })
hi(0, "Statement", { fg = "#8197BE" })
hi(0, "StatusLine", { fg = "#9E9E9E", bg = "none" })
hi(0, "StorageClass", { fg = "#C59F6F" })
hi(0, "String", { fg = "#99AD6A" })
hi(0, "Structure", { fg = "#8FBFDC" })
hi(0, "Type", { fg = "#FFB964" })
hi(0, "Visual", { bg = "#303030" })
hi(0, "WinSeparator", { fg = "#333333" })

-- Markdown highlights
hi(0, "markdownH1", { fg = "#fad17a" })
hi(0, "markdownH2", { fg = "#ffb372" })
hi(0, "markdownH3", { fg = "#ffb372" })
hi(0, "markdownH4", { fg = "#ffb372" })
hi(0, "markdownH5", { fg = "#ffb372" })
hi(0, "markdownH1Delimiter", { fg = "#fad17a" })
hi(0, "markdownH2Delimiter", { fg = "#ffb372" })
hi(0, "markdownH3Delimiter", { fg = "#ffb372" })
hi(0, "markdownH4Delimiter", { fg = "#ffb372" })
hi(0, "markdownH5Delimiter", { fg = "#ffb372" })
hi(0, "markdownCode", { fg = "#8fbfdc" })
hi(0, "markdownCodeBlock", { fg = "#8fbfdc" })
hi(0, "markdownCodeDelimiter", { fg = "#4d636f" })
hi(0, "markdownAutomaticLink", { fg = "#cf6a4c" })
hi(0, "markdownUrlDelimiter", { fg = "#874937" })

-- Link Vimwiki headers to Markdown highlights
hi(0, "VimwikiHeader1", { link = "markdownH1" })
hi(0, "VimwikiHeader2", { link = "markdownH2" })
hi(0, "VimwikiHeader3", { link = "markdownH3" })
hi(0, "VimwikiHeader4", { link = "markdownH4" })
hi(0, "VimwikiHeader5", { link = "markdownH5" })
hi(0, "VimwikiHeaderChar", { fg = "#fad17a" })
hi(0, "VimwikiListTodo", { fg = "#8197be" })

-- Vimwiki
vim.g.vimwiki_use_calendar = 1
vim.g.vimwiki_url_maxsave = 0
vim.g.vimwiki_global_ext = 0

vim.g.vimwiki_list = {
  {
    path = '~/Documents/Wiki/',
    syntax = 'markdown',
    ext = '.md',
    auto_tags = 1,
    auto_diary_index = 1,
    automatic_nested_syntaxes = 1,
    nested_syntaxes = {
      csv = 'csv',
      go = 'go',
      json = 'json',
      make = 'make',
      sh = 'sh',
      sql = 'sql',
      yaml = 'yaml',
      xml = 'xml',
      zig = 'zig',
    },
  }
}

-- Key mappings
vim.api.nvim_set_keymap('n', '<Leader>vn', '<Plug>VimwikiNextLink', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>vp', '<Plug>VimwikiPrevLink', { noremap = false, silent = true })

-- LeaderF
local hl = vim.api.nvim_set_hl

hl(0, "Lf_hl_popup_prompt",      { bg = "#585858", fg = "#FFFFFF" })
hl(0, "Lf_hl_popup_cursor",      { bg = "#FFB371" })
hl(0, "Lf_hl_popup_inputText",   { bg = "#303030", fg = "#FFFFFF" })
hl(0, "Lf_hl_popup_inputMode",   { bg = "#0087AF", fg = "#FFFFFF" })
hl(0, "Lf_hl_popup_lineInfo",    { bg = "#585858", fg = "#FFFFFF" })
hl(0, "Lf_hl_popup_total",       { bg = "#D0D0D0", fg = "#6D6D6D" })
hl(0, "Lf_hl_cursorline",        { fg = "#FFFFFF" })
hl(0, "Lf_hl_match",             { fg = "#0087AF" })
hl(0, "Lf_hl_popup_normalMode",  { bg = "#AFDF00", fg = "#005F00" })
hl(0, "Lf_hl_popup_category",    { bg = "#005F87", fg = "#87DFFF" })
hl(0, "Lf_hl_popup_fullPathMode",{ bg = "#0087AF", fg = "#87DFFF" })
hl(0, "Lf_hl_popup_nameOnlyMode",{ bg = "#303030", fg = "#9E9E9E" })
hl(0, "Lf_hl_popup_cwd",         { bg = "#005F87", fg = "#87DFFF" })

-- LeaderF globals
vim.g.Lf_WindowPosition = "popup"
vim.g.Lf_ShortcutF = "<silent> t"
vim.g.Lf_HideHelp = 1
vim.g.Lf_ShowDevIcons = 0
vim.g.Lf_PreviewInPopup = 1

vim.g.Lf_StlSeparator = {
  left = "\u{e0b0}",
  right = "\u{e0b2}",
}

vim.g.Lf_CommandMap = {
  ["<C-K>"] = { "<Up>" },
  ["<C-J>"] = { "<Down>" },
}

vim.g.Lf_WorkingDirectoryMode = "a"
vim.g.Lf_UseMemoryCache = 0
vim.g.Lf_StlColorscheme = "powerline"
vim.g.Lf_PopupColorscheme = "gruvbox_default"

vim.g.Lf_WildIgnore = {
  dir = { ".git", "zig-cache" },
  file = { "*.sw?", "~$*", "*.bak", "*.exe", "*.o", "*.so", "*.wasm" },
}

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'tinymist',
  'zls',
})

-- CMP
local luasnip = require'luasnip'
local cmp = require'cmp'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
  },
  window = {
    completion = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:None,CursorLine:PmenuSel,Search:None',
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:None,CursorLine:PmenuSel,Search:None',
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif luasnip.expandable() then
        luasnip.expand()
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 250, keyword_length = 1 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'path', keyword_length = 2 },
    { name = 'buffer', keyword_length = 3 },
  }),
  formatting = {
	  expandable_indicator = true,
		fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = ' ',
        luasnip = '⋗',
        path = '🖫',
        buffer = 'Ω',
      }

      item.menu = menu_icon[entry.source.name]

      return item
    end,
	},
})

require("luasnip.loaders.from_snipmate").lazy_load()
