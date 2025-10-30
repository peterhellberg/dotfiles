-- Use buffer-local options so it only applies to markdown
vim.opt_local.expandtab = true       -- Use spaces instead of tabs
vim.opt_local.shiftwidth = 2         -- Indentation width for auto-indent
vim.opt_local.tabstop = 2            -- Width of a tab character
vim.opt_local.softtabstop = 2        -- Number of spaces a Tab inserts
vim.opt_local.autoindent = true      -- Preserve indent from previous line
vim.opt_local.smartindent = true     -- Optional: smart auto-indenting

-- Optional: force the settings again after all plugins load
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
