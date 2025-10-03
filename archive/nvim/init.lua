local base = vim.fn.stdpath("config") .. "/base.lua"
vim.cmd.source(base)

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
