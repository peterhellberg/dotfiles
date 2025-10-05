local alternates = {
  ["%.go$"]          = function(name) return name:gsub("%.go$", "_test.go") end,
  ["_test%.go$"]     = function(name) return name:gsub("_test%.go$", ".go") end,
  ["%.c$"]           = function(name) return name:gsub("%.c$", ".h") end,
  ["%.h$"]           = function(name) return name:gsub("%.h$", ".c") end,
  ["build.zig$"]     = function(name) return name:gsub("%.zig$", ".zig.zon") end,
  ["build.zig.zon$"] = function(name) return name:gsub("%.zig.zon$", ".zig") end,
}

local patterns = {
  "build.zig*",
  "*.go",
  "*.c",
  "*.h",
}

local function alternate_file(split_cmd, bang)
  local bufname = vim.api.nvim_buf_get_name(0)
  local alt

  for pattern, func in pairs(alternates) do
    if bufname:match(pattern) then
      alt = func(bufname)
      break
    end
  end

  if not alt then
    print("No alternate defined for this file")
    return
  end

  if vim.fn.filereadable(alt) == 0 and not bang then
    print("Alternate file not found: " .. alt)
    return
  end

  vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(alt))
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = patterns,
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "A", function(opts)
      alternate_file("edit", opts.bang)
    end, {bang = true})

    vim.api.nvim_buf_create_user_command(0, "AV", function(opts)
      alternate_file("vsplit", opts.bang)
    end, {bang = true})

    vim.api.nvim_buf_create_user_command(0, "AS", function(opts)
      alternate_file("split", opts.bang)
    end, {bang = true})
  end
})
