local alternates = {
  ["%.go$"]           = function(name) return name:gsub("%.go$", "_test.go") end,
  ["_test%.go$"]      = function(name) return name:gsub("_test%.go$", ".go") end,
  ["%.c$"]            = function(name) return name:gsub("%.c$", ".h") end,
  ["%.h$"]            = function(name) return name:gsub("%.h$", ".c") end,
  ["build.zig$"]      = function(name) return "build.zig.zon" end,
  ["build.zig.zon$"]  = function(name) return "build.zig" end,
  ["fragment.glslx$"] = function(name) return "vertex.glslx" end,
  ["vertex.glslx$"]   = function(name) return "fragment.glslx" end,
}

local patterns = {
  "*.go",
  "*.c",
  "*.h",
  "build.zig",
  "build.zig.zon",
  "fragment.glslx",
  "vertex.glslx",
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
    return vim.notify("No alternate defined for this file", vim.log.levels.WARN)
  end

  if vim.fn.filereadable(alt) == 0 and not bang then
    return vim.notify("Alternate file not found: " .. alt, vim.log.levels.WARN)
  end

  vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(alt))
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = patterns,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.b[bufnr].alternate_commands then return end
    vim.b[bufnr].alternate_commands = true

    local function create_cmd(name, cmd)
      vim.api.nvim_buf_create_user_command(bufnr, name, function(opts)
        alternate_file(cmd, opts.bang)
      end, { bang = true })
    end

    create_cmd("A", "edit")
    create_cmd("AV", "vsplit")
    create_cmd("AS", "split")
  end
})
