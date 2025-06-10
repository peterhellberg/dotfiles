-- git clone https://github.com/L3MON4D3/LuaSnip.git ~/.config/nvim/pack/nvim/start/LuaSnip
local luasnip = require'luasnip'

-- git clone https://github.com/hrsh7th/nvim-cmp ~/.config/nvim/pack/nvim/start/nvim-cmp
local cmp = require'cmp'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
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
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp', max_item_count = 10},
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
	  expandable_indicator = true,
		fields = { "abbr", "kind", "menu" },
	},
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- git clone https://github.com/hrsh7th/cmp-nvim-lsp ~/.config/nvim/pack/nvim/start/cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.gopls.setup{
  capabilities = capabilities,
}

-- git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
require'lspconfig'.zls.setup{
  capabilities = capabilities,
}

require'lspconfig'.lua_ls.setup{
  capabilities = capabilities,
  cmd = {
    "/home/peter/.local/bin/lua-language-server",
  },
}

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "§", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- git clone https://github.com/ibhagwan/fzf-lua.git ~/.config/nvim/pack/nvim/start/fzf-lua
vim.api.nvim_set_keymap("n", "<F3>", "<cmd>FzfLua builtin<CR>", { noremap = true, silent = true })

-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0

-- https://github.com/ziglang/zig/wiki/FAQ
vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon"},
  callback = function()
    vim.lsp.buf.format()
  end
})

require("luasnip.loaders.from_snipmate").lazy_load()
