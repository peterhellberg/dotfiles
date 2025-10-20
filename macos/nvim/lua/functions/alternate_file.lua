local alternates = {
  { pattern = "_test%.go$",     fn = function(name) return name:gsub("_test%.go$", ".go") end },
  { pattern = "%.go$",          fn = function(name) return name:gsub("%.go$", "_test.go") end },
  { pattern = "%.c$",           fn = function(name) return name:gsub("%.c$", ".h") end },
  { pattern = "%.h$",           fn = function(name) return name:gsub("%.h$", ".c") end },
  { pattern = "build.zig$",     fn = function(_) return "build.zig.zon" end },
  { pattern = "build.zig.zon$", fn = function(_) return "build.zig" end },
  { pattern = "fragment.glslx$",fn = function(_) return "vertex.glslx" end },
  { pattern = "vertex.glslx$",  fn = function(_) return "fragment.glslx" end },
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

function alternate_file(split_cmd, bang)
  local bufname = vim.api.nvim_buf_get_name(0)
  local alt

  for _, entry in ipairs(alternates) do
    if bufname:match(entry.pattern) then
      alt = entry.fn(bufname)
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
