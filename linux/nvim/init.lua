local base = vim.fn.stdpath("config") .. "/base.lua"
dofile(base)

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
