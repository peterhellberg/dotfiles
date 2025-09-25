local local_config = vim.fn.expand("~/.config/nvim/local.lua")

if vim.fn.filereadable(local_config) == 1 then
    dofile(local_config)
end

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

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.config('gopls', {
  cmd = { "gopls" },
  filetypes = { "go" },
  capabilities = capabilities,
  settings = {
	  gopls = {
      analyses = {
        modernize = false,
      },
    },
  },
})
vim.lsp.enable('gopls')

-- git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
vim.lsp.config('zls', {
  cmd = { "zls" },
  filetypes = { "zig" },
  capabilities = capabilities
})
vim.lsp.enable('zls')

-- sudo apt install clangd
vim.lsp.config('clangd', {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "h" },
  capabilities = capabilities
})
vim.lsp.enable('clangd')

-- https://luals.github.io/#neovim-install
vim.lsp.config('lua_ls', {
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend('force',
      client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable('lua_ls')

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "§", "<cmd>lua vim.lsp.buf.hover({border = 'rounded', max_width = 80})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "¨", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F3>", "<cmd>FzfLua builtin<CR>", { noremap = true, silent = true })

-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0

-- Use "stack" jumpoptions instead of new default "clean"
vim.o.jumpoptions = "stack"

-- Trim trailing whitespace
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
  desc = 'Trim trailing white spaces',
  pattern = 'bash,c,cpp,lua,javascript,make,python,rust,perl,sql,markdown',
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '<buffer>',
      callback = function()
        local curpos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)
      end,
    })
  end,
})

-- https://github.com/ziglang/zig/wiki/FAQ
vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon", "*.c", "*.h", "*.ino"},
  callback = function()
    vim.lsp.buf.format()
  end
})

vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.go"},
  callback = function()
    vim.lsp.buf.code_action({
      context = {
        diagnostics = {},
        only = { 'source.organizeImports' }
      },
      apply = true
    })
  end
})

require("luasnip.loaders.from_snipmate").lazy_load()

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'solid',
    source = true,
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

local after_config = vim.fn.expand("~/.config/nvim/after.lua")

if vim.fn.filereadable(after_config) == 1 then
    dofile(after_config)
end
