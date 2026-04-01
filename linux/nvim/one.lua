vim.pack.add {
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/vim-vsnip',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/vimwiki/vimwiki',
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/Yggdroot/LeaderF',
  'https://github.com/honza/vim-snippets',
  'https://github.com/mileszs/ack.vim',
}

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

vim.o.background = "dark"
vim.cmd([[colorscheme default]])

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
hi(0, "Normal", { fg = "#E8E8D3", bg = "#151515" })
hi(0, "NormalFloat", { bg = "#151515" })
hi(0, "Number", { fg = "#CF6A4C" })
hi(0, "Pmenu", { fg = "#E8E8D3", bg = "#1a1a1a" })
hi(0, "PmenuSbar", { bg = "#222222" })
hi(0, "PmenuSel", { fg = "#E8E8D3", bg = "#2a2a2a", bold = true })
hi(0, "PmenuThumb", { bg = "#605958" })
hi(0, "PreProc", { fg = "#8FBFDC" })
hi(0, "Question", { fg = "#E6E6CD" })
hi(0, "Repeat", { fg = "#8197BF" })
hi(0, "Search", { fg = "#404040", bg = "#EFEFEF" })
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
