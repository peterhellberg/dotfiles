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

-- Autocmd triggered for Go, Zig, C files
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
  pattern = {"*.zig", "*.zon", "*.c", "*.h"},
  callback = function()
    vim.lsp.buf.format()
  end
})

-- Format and organize imports for Go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    local bufnr = args.buf

    pcall(vim.lsp.buf.format, {
      bufnr = bufnr,
      async = false,
    })

    local params = vim.lsp.util.make_range_params()

    params.context = {
      only = { "source.organizeImports" }
    }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
        end
      end
    end
  end,
})
