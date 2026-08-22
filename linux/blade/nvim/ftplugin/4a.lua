-- Ftplugin for 4A, the 4A Assembly language,
-- used in the 4B Fantasy Console.

-- Shade columns 17–320 to match the 4A editor's layout.
vim.api.nvim_set_hl(0, "FourAColorColumn", { bg = "#1b1b1b" })
vim.wo.winhighlight = "ColorColumn:FourAColorColumn"
vim.wo.colorcolumn = table.concat(
  vim.tbl_map(tostring, vim.fn.range(17, 320)),
  ","
)

-- Use semicolons for comments in 4A Assembly.
vim.bo.commentstring = '; %s'
