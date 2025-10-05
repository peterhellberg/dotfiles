local local_config = vim.fn.expand("~/.config/nvim/local.lua")

if vim.fn.filereadable(local_config) == 1 then
    dofile(local_config)
end

require("core.cmp")
require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.alternates")

local after_config = vim.fn.expand("~/.config/nvim/after.lua")

if vim.fn.filereadable(after_config) == 1 then
    dofile(after_config)
end
