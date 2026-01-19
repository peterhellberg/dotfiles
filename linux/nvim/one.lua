vim.o.background = "dark"
vim.cmd([[colorscheme default]])

vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true

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
