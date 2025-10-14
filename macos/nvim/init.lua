require("functions")
require("commands")
require("core")
require("lsp")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
