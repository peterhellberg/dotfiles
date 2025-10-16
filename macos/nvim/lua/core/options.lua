-- increase synmaxcol limit from 3000 to 6000
vim.o.synmaxcol = 6000

-- disable netrw since I'm using NERDTree
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0

-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0

-- Use "stack" jumpoptions instead of new default "clean"
vim.o.jumpoptions = "stack"

-- Set your listchars
vim.opt.listchars = {
    tab = "→\\ ",
    space = "·",
    nbsp = "␣",
    trail = "•",
    eol = "¶",
    precedes = "«",
    extends = "»"
}
