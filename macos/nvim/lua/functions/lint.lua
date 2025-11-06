-- Run golangci-lint with --fix and populate quickfix list
function GolangCILintFix()
  local root = vim.fs.root(0, { ".golangci.yaml", ".golangci.yml", "go.mod", ".git" })
  if not root then
    vim.notify("Could not find project root", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("golangci-lint") ~= 1 then
    vim.notify("golangci-lint not found in PATH", vim.log.levels.ERROR)
    return
  end

  local cmd = { "golangci-lint", "run", "--fix" }
  local output, errors = {}, {}

  local job = vim.fn.jobstart(cmd, {
    cwd = root,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then vim.list_extend(output, data) end
    end,
    on_stderr = function(_, data)
      if data then vim.list_extend(errors, data) end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        local qf = {}
        for _, line in ipairs(output) do
          -- Matches: file.go:21:1: message (linter)
          local file, lnum, col, msg = line:match("^(.-):(%d+):(%d+):%s*(.+)$")
          if file and msg then
            table.insert(qf, {
              filename = vim.fs.joinpath(root, file),
              lnum = tonumber(lnum),
              col = tonumber(col),
              text = msg,
            })
          end
        end

        if #qf > 0 then
          vim.fn.setqflist({}, " ", {
            title = "golangci-lint",
            items = qf,
          })
          vim.cmd("copen")
          vim.notify(("golangci-lint found %d issue(s)"):format(#qf), vim.log.levels.WARN)
        else
          vim.notify("golangci-lint: no issues found 🎉", vim.log.levels.INFO)
          vim.fn.setqflist({}, "r") -- clear old list
        end
      end)
    end,
  })

  if job <= 0 then
    vim.notify("Failed to start golangci-lint", vim.log.levels.ERROR)
  end
end

-- Create a Neovim command
vim.api.nvim_create_user_command("Lint", GolangCILintFix, {})
