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
  Org  = { func = function() format_go_buffer(0) end, desc = "Organize imports in the current buffer", capability = "codeActionProvider", },
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
  pattern = "go,zig,c,proto",
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
          cmd.func(opts)
        else
          vim.notify(name .. " not supported by attached LSP server", vim.log.levels.WARN)
        end
      end, { desc = cmd.desc, nargs = cmd.nargs })
    end
  end,
})

-- Trim trailing whitespace
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
  desc = 'Trim trailing white spaces',
  pattern = 'bash,c,cpp,lua,javascript,make,python,rust,perl,sql',
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
  pattern = {"*.zig", "*.zon", "*.c", "*.h", "*.proto"},
  callback = function()
    vim.lsp.buf.format()
  end
})

-- Format and organize imports for Go
require("functions.format_go_buffer")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    format_go_buffer(args.buf)
  end,
})

-- Toggle between alternate files
require("functions.alternate_file")

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

vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
  callback = function(args)
    local bufnr = args.buf

    vim.fn.clearmatches()

    if vim.bo[bufnr].filetype == "go" then
      vim.api.nvim_set_hl(0, "OverLength", { fg="#ff8566", bg="#944b37", sp="#944b37", underline=true })
      vim.fn.matchadd("OverLength", "\\%>120c.")
    end
  end,
})
