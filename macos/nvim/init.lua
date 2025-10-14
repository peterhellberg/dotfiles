require("core")
require("lsp")
require("commands")
require("functions")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
