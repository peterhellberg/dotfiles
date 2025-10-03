-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0

-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0

-- Use "stack" jumpoptions instead of new default "clean"
vim.o.jumpoptions = "stack"
