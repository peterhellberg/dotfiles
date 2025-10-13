local M = {}

local build_tags = ""
local coverage_visible = {}       -- per-buffer highlights
local coverage_generated = {}     -- per-buffer generated file tracking
local coverage_file_for_buf = {}  -- track exact coverage file per buffer
local ns = vim.api.nvim_create_namespace("GoCoverage")

-- Setup highlight groups
local function setup_highlights()
  vim.api.nvim_set_hl(0, "GoCoverageCovered",   { fg="#f8f8f2", bg="#789d6a" })
  vim.api.nvim_set_hl(0, "GoCoverageUncovered", { fg="#f8f8f2", bg="#cf6a4c" })
end

-- Compute coverage file path in the buffer's package directory
local function get_coverage_file(buf)
  local bufname = vim.api.nvim_buf_get_name(buf)
  local dir = vim.fn.fnamemodify(bufname, ":h")
  return dir .. "/coverage.out"
end

-- Generate coverage file for a buffer (only for this package)
local function generate_coverage(buf, cb)
  local buf_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":h")
  local coverage_file = get_coverage_file(buf)
  coverage_file_for_buf[buf] = coverage_file

  -- Run tests for this package only, write coverage to exact path
  local cmd = string.format(
      "go test -coverprofile=%s -tags=%s %s",
      coverage_file,
      build_tags,
      buf_dir
  )

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, code)
      vim.notify(
        code == 0 and "Go coverage generated" or "Go coverage test failed",
        code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      )
      cb(code == 0)
    end
  })
end

-- Compare buffer path to coverage path (simple filename match)
local function path_matches(buf_path, cov_path)
  local buf_base = vim.fn.fnamemodify(buf_path, ":t")
  local cov_base = vim.fn.fnamemodify(cov_path, ":t")
  return buf_base == cov_base
end

-- Apply coverage highlights to a buffer
local function apply_coverage(buf)
  local coverage_file = coverage_file_for_buf[buf] or get_coverage_file(buf)
  local f = io.open(coverage_file, "r")
  if not f then
    vim.notify("No coverage.out found for this buffer", vim.log.levels.ERROR)
    return false
  end

  local bufname = vim.api.nvim_buf_get_name(buf)
  local line_count = vim.api.nvim_buf_line_count(buf)
  setup_highlights()
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  local highlighted = false

  for line in f:lines() do
    if not line:match("^mode:") then
      local cov_path, startl, endl, count = line:match("([^:]+):(%d+)%.%d+,(%d+)%.%d+ %d+ (%d+)")
      if cov_path and startl and endl and count and path_matches(bufname, cov_path) then
        for lnum = tonumber(startl), tonumber(endl) do
          if lnum <= line_count then
            vim.api.nvim_buf_add_highlight(buf, ns,
              tonumber(count) > 0 and "GoCoverageCovered" or "GoCoverageUncovered",
              lnum-1, 0, -1
            )
            highlighted = true
          end
        end
      end
    end
  end

  f:close()

  if highlighted then
    coverage_visible[buf] = true
  end

  return highlighted
end

-- Clear coverage highlights for a buffer
local function clear_coverage(buf)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  coverage_visible[buf] = false

  local coverage_file = coverage_file_for_buf[buf]
  if coverage_file and vim.fn.filereadable(coverage_file) == 1 then
    os.remove(coverage_file)
  end

  coverage_generated[buf] = nil
  coverage_file_for_buf[buf] = nil
end

-- Toggle coverage for a single buffer
function M.toggle(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(buf)

  -- Skip test files
  if bufname:match("_test%.go$") then
    vim.notify("GoCoverage cannot be run on _test.go files", vim.log.levels.WARN)
    return
  end

  if coverage_visible[buf] then
    clear_coverage(buf)
    vim.notify("Coverage cleared for buffer", vim.log.levels.INFO)
    return
  end

  generate_coverage(buf, function(success)
    if success then
      local highlighted = apply_coverage(buf)
      if highlighted then
        coverage_generated[buf] = true
        vim.notify("Coverage applied for buffer", vim.log.levels.INFO)
      else
        -- No coverage lines, remove empty coverage file immediately
        local coverage_file = coverage_file_for_buf[buf]
        if coverage_file and vim.fn.filereadable(coverage_file) == 1 then
          os.remove(coverage_file)
        end
      end
    end
  end)
end

-- Register buffer-local command for Go files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_create_user_command(buf, "GoCoverage", function() M.toggle(buf) end,
      { desc = "Toggle Go test coverage for this buffer" })
  end,
})

return M
