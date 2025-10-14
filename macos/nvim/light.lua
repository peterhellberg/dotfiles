local init = vim.fn.stdpath("config") .. "/init.lua"
vim.cmd.source(init)

vim.o.background = "light"
vim.cmd.colorscheme "default"
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

-- Light theme
local highlights_light = {
  Comment                  = { fg = "#555555" },
  Conditional              = { fg = "#3455A4" },
  Constant                 = { fg = "#A84136" },
  Delimiter                = { fg = "#4F7942" },
  DiagnosticError          = { fg = "#D2222D" },
  DiagnosticHint           = { fg = "#3455A4" },
  DiagnosticInfo           = { fg = "#505050" },
  DiagnosticWarn           = { fg = "#D27B2D" },
  DiagnosticUnderlineError = { sp = "#D2222D", undercurl = true },
  DiagnosticUnderlineHint  = { sp = "#3455A4", undercurl = true },
  DiagnosticUnderlineInfo  = { sp = "#505050", undercurl = true },
  DiagnosticUnderlineWarn  = { sp = "#D27B2D", undercurl = true },
  Directory                = { fg = "#D27B2D" },
  ErrorMsg                 = { fg = "#A00000" },
  Function                 = { fg = "#CFA844" },
  Identifier               = { fg = "#755BA4" },
  Include                  = { fg = "#3B80C3" },
  Keyword                  = { fg = "#3455A4" },
  Label                    = { fg = "#3455BF" },
  LineNr                   = { fg = "#808080" },
  Macro                    = { fg = "#3B80C3" },
  ModeMsg                  = { fg = "#FFFFFF", bg = "#00A0D0" },
  Normal                   = { fg = "#303030", bg = "#F8F8F8" },
  Number                   = { fg = "#A84136" },
  PreProc                  = { fg = "#3B80C3" },
  Question                 = { fg = "#505050" },
  Repeat                   = { fg = "#3455BF" },
  Search                   = { fg = "#404040", bg = "#FFFF99" },
  Special                  = { fg = "#4F7942" },
  SpecialChar              = { fg = "#755BA4" },
  Statement                = { fg = "#3455A4" },
  StatusLine               = { fg = "#303030", bg = "NONE" },
  StorageClass             = { fg = "#7A5B3C" },
  String                   = { fg = "#4F7942" },
  Structure                = { fg = "#3B80C3" },
  Type                     = { fg = "#D27B2D" },
  Visual                   = { fg = "NONE", bg = "#C0C0C0" },
  WinSeparator             = { fg = "#A0A0A0" },
  QuickFixLine             = { fg = "NONE", bg = "#C0C0C0", bold = true },
}

for group, opts in pairs(highlights_light) do
  vim.api.nvim_set_hl(0, group, opts)
end
