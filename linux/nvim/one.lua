vim.o.background = "dark"
vim.cmd([[colorscheme default]])

vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "noinsert,menuone,noselect"
vim.opt.smarttab = true

-- Use comma as the mapleader
vim.g.mapleader = ","

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('i', 'jj', '<ESC>', opts)

keymap("n", "<Leader>n", "<cmd>Lexplore %:p:h<CR>")
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
local zls_cmd = { "zls" }
local zls_settings = {}

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "§", ":lua vim.lsp.buf.hover({border = 'rounded', max_width = 80})<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "^", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "¨", ":lua vim.lsp.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
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
      return term(fallback)
    end
  end
end

vim.keymap.set("i", "<Tab>", pum_map("<C-n>", "<C-x><C-o>"), { expr = true })
vim.keymap.set("i", "<S-Tab>", pum_map("<C-p>", "<S-Tab>"), { expr = true })
vim.keymap.set("i", "<CR>", pum_map("<C-y>", "<CR>"), { expr = true })
vim.keymap.set("i", "<Esc>", pum_map("<C-e>", "<Esc>"), { expr = true })

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
hi(0, "PreProc", { fg = "#8FBFDC" })
hi(0, "Question", { fg = "#E6E6CD" })
hi(0, "Repeat", { fg = "#8197BF" })
hi(0, "Search", { fg = "#404040", bg = "#EFEFEF" })
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
