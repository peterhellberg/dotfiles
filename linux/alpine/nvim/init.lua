vim.g.mapleader = ","

local o = vim.o
local opt = vim.opt

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

o.background = "dark"
o.completeopt = "menuone,noselect,fuzzy"
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep --smart-case --hidden"
o.pumheight = 10
o.updatetime = 100
o.winborder = "rounded"

opt.termguicolors = true
opt.backup = false
opt.expandtab = true
opt.lazyredraw = true
opt.list = true
opt.listchars = { tab = "» " }
opt.more = false
opt.number = true
opt.ruler = false
opt.wrap = false
opt.shiftwidth = 2
opt.showcmd = false
opt.swapfile = false
opt.tabstop = 2
opt.ttyfast = true
opt.undofile = false
opt.wrap = false
opt.writebackup = false
opt.sidescroll = 1
opt.sidescrolloff = 8
opt.pumblend = 0
opt.winblend = 0

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
hi(0, "Identifier", { fg = "#DDDDC5" })
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
hi(0, "QuickFixLine", { fg = "#97a950", underline = true })
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
hi(0, "healthSectionDelim", { fg = "#888888" })

-- Keymaps

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<Leader><Leader>', '<C-^>', opts)
keymap('n', '<Leader>s<Left>', ':leftabove vnew<CR>', opts)
keymap('n', '<Leader>s<Right>', ':rightbelow vnew<CR>', opts)
keymap('n', '<Leader>s<Up>', ':leftabove new<CR>', opts)
keymap('n', '<Leader>s<Down>', ':rightbelow new<CR>', opts)
keymap('n', '<Space>', ':', opts)
keymap('n', '<Tab>', '<c-w>w', opts)
keymap('n', '<S-Tab>', '<c-w>W', opts)
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)

keymap('n', "<Leader>n", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bd")
  else
    vim.cmd("Lexplore " .. vim.fn.expand("%:p:h"))
  end
end, { silent = true })

if vim.fn.bufwinnr(1) > 0 then
  keymap('n', 'ö', '<C-W><<C-W><', opts)
  keymap('n', 'ä', '<C-W>><C-W>>', opts)
  keymap('n', 'Ä', '<C-W>-<C-W>-', opts)
  keymap('n', 'Ö', '<C-W>+<C-W>+', opts)
end

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "§", "<cmd>lua vim.lsp.buf.hover({border = 'rounded', max_width = 80})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "^", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "¨", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-x><C-o>"
end, { expr = true, silent = true })

vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, silent = true })

local function fuzzy_files()
  local query = vim.fn.input("Files > ")
  if query == "" then return end

  local files = vim.fn.systemlist("rg --files")

  -- fuzzy filter + score
  local matches = vim.fn.matchfuzzy(files, query)

  if vim.tbl_isempty(matches) then
    vim.notify("No matches", vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist({}, " ", {
    title = "Fuzzy Files: " .. query,
    lines = matches,
  })

  vim.cmd("copen")
end

vim.keymap.set("n", "t", fuzzy_files, { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      local line = vim.fn.getline(".")
      if line == "" then return end

      -- strip any junk just in case
      local file = line:gsub("^%s*|?%|?%s*", ""):gsub("%|.*$", "")

      vim.cmd("cclose")
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end, { buffer = true, silent = true })
  end,
})

-- LSP

vim.filetype.add({ extension = { zon = "zig" } })

local lsp = vim.lsp.config

lsp.clangd = {
  cmd = { "clangd" },
  filetypes = { "c", "h" },
  root_markers = { },
}

lsp.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { },
}

lsp.gopls = {
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = { "go.mod", ".git" },
}

lsp.zls = {
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { "build.zig", "build.zig.zon", ".git" },
}

vim.lsp.enable({ "gopls", "zls", "lua_ls", "clangd" })

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon", "*.c", "*.h", "*.go"},
  callback = function()
    vim.lsp.buf.format()
  end
})

-- Create an autocmd group for LSP commands
vim.api.nvim_create_augroup("LSPCommands", { clear = true })

-- Table of LSP commands
local lsp_commands = {
  Def  = { func = vim.lsp.buf.definition, desc = "Go to definition of current symbol", capability = "definitionProvider" },
  Impl = { func = vim.lsp.buf.implementation, desc = "Go to implementation of current symbol", capability = "implementationProvider" },
  Ref  = { func = vim.lsp.buf.references, desc = "Show LSP references for current symbol", capability = "referencesProvider" },
  Type = { func = vim.lsp.buf.type_definition, desc = "Go to type definition of current symbol", capability = "typeDefinitionProvider" },
  Doc  = { func = function() vim.lsp.buf.hover({border = 'rounded'}) end, desc = "Show documentation for current symbol", capability = "hoverProvider" },
  Fmt  = { func = function() vim.lsp.buf.format({ async = true }) end, desc = "Format current buffer using LSP", capability = "documentFormattingProvider" },
  Ren  = { func = function(opts)
      if opts.args ~= ""
        then vim.lsp.buf.rename(opts.args)
        else vim.lsp.buf.rename()
      end
    end,
    desc = "Rename symbol under cursor",
    capability = "renameProvider",
    nargs = "?",
  },
}

-- Autocmd triggered for Go, Zig, C, Proto files
vim.api.nvim_create_autocmd("FileType", {
  group = "LSPCommands",
  pattern = "go,zig,c",
  callback = function()
    for name, cmd in pairs(lsp_commands) do
      vim.api.nvim_buf_create_user_command(0, name, function(opts)
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local supported = false

        for _, client in ipairs(clients) do
          if client.server_capabilities[cmd.capability] then
            supported = true
            break
          end
        end

        if supported then
          if name == "Ref" then
            cmd.func()
          else
            cmd.func(opts)
          end
        else
          vim.notify(name .. " not supported by attached LSP server", vim.log.levels.WARN)
        end
      end, { desc = cmd.desc, nargs = cmd.nargs })
    end
  end,
})

-- Diagnostics

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    focusable = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.HINT]  = '⚑',
      [vim.diagnostic.severity.INFO]  = '',
    },
  }
})

-- Alternate

local alternates = {
  { pattern = "_test%.go$",     fn = function(name) return name:gsub("_test%.go$", ".go") end },
  { pattern = "%.go$",          fn = function(name) return name:gsub("%.go$", "_test.go") end },
  { pattern = "%.c$",           fn = function(name) return name:gsub("%.c$", ".h") end },
  { pattern = "%.h$",           fn = function(name) return name:gsub("%.h$", ".c") end },
  { pattern = "build.zig$",     fn = function(_) return "build.zig.zon" end },
  { pattern = "build.zig.zon$", fn = function(_) return "build.zig" end },
}

local function alternate_file(split_cmd, bang)
  local bufname = vim.api.nvim_buf_get_name(0)
  local alt

  for _, entry in ipairs(alternates) do
    if bufname:match(entry.pattern) then
      alt = entry.fn(bufname)
      break
    end
  end

  if not alt then
    return vim.notify("No alternate defined for this file", vim.log.levels.WARN)
  end

  if vim.fn.filereadable(alt) == 0 and not bang then
    return vim.notify("Alternate file not found: " .. alt, vim.log.levels.WARN)
  end

  vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(alt))
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = patterns,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.b[bufnr].alternate_commands then return end
    vim.b[bufnr].alternate_commands = true

    local function create_cmd(name, cmd)
      vim.api.nvim_buf_create_user_command(bufnr, name, function(opts)
        alternate_file(cmd, opts.bang)
      end, { bang = true })
    end

    create_cmd("A", "edit")
    create_cmd("AV", "vsplit")
    create_cmd("AS", "split")
  end
})

-- OSC52

local function osc52_copy(lines)
  local text = table.concat(lines, '\n')
  local b64 = vim.base64.encode(text)

  io.write('\027]52;c;', b64, '\a')
  io.flush()
end

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' then
      osc52_copy(vim.v.event.regcontents)
    end
  end,
})
