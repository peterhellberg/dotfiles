local base = vim.fn.stdpath("config") .. "/base.lua"
vim.cmd.source(base)

local vimrc = vim.fn.stdpath("config") .. "/init.vim"
vim.cmd.source(vimrc)
