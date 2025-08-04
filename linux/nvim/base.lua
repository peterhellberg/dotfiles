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
  sorting = {
    priority_weight = 2,
    comparators = {
        cmp.config.compare.exact,
        cmp.config.compare.offset,
        cmp.config.compare.recently_used,
    },
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

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
-- git clone https://github.com/hrsh7th/cmp-nvim-lsp ~/.config/nvim/pack/nvim/start/cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.gopls.setup{ capabilities = capabilities }

-- git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
require'lspconfig'.zls.setup{ capabilities = capabilities }

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "§", "<cmd>lua vim.lsp.buf.hover({border = 'solid', max_width = 80})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "¨", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
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

local function handle_action_sync(action, buf, timeout_ms, attempts)
  if attempts > 3 then
    return
  end

  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
  elseif action.command then
    vim.lsp.buf.execute_command(action.command)
  else
    local resolve_result = vim.lsp.buf_request_sync(buf, "codeAction/resolve", action, timeout_ms)
    if resolve_result then
      for _, resolved_action in pairs(resolve_result) do
        handle_action_sync(resolved_action.result, buf, timeout_ms, attempts + 1)
      end
    end
  end
end

local function handle_write_pre(kinds, buf, timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = {} }

  local results = vim.lsp.buf_request_sync(buf, "textDocument/codeAction", params, timeout_ms)
  if not results then
    return
  end

  for _, result in pairs(results) do
    for _, action in pairs(result.result or {}) do
      for _, kind in pairs(kinds) do
        if action.kind == kind then
          handle_action_sync(action, buf, timeout_ms, 0)
        end
      end
    end
  end
end

function register_code_actions(pattern, kinds, timeout_ms)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = pattern,
    callback = function(args)
      handle_write_pre(kinds, args.buf, timeout_ms or 100)
      vim.lsp.buf.format()
    end,
  })
end

register_code_actions({ "*.go" }, { "source.organizeImports" }, 100)

require("luasnip.loaders.from_snipmate").lazy_load()

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'solid',
    source = 'always',
    focusable = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.HINT]  = '⚑',
      [vim.diagnostic.severity.INFO]  = '»',
    },
  }
})
