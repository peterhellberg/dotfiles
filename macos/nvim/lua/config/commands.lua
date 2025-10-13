require("config.commands.GoCoverage")

-- Pt
vim.api.nvim_create_user_command('Pt', function(opts)
  vim.cmd('Ack ' .. table.concat(opts.fargs, ' '))
end, { nargs = '*' })

-- Path
vim.api.nvim_create_user_command('File', function(opts)
  print(vim.fn.expand('%:p'))
end, { nargs = '*' })

-- Diary
vim.api.nvim_create_user_command('DiaryIndex', function()
  vim.cmd('silent VimwikiDiaryIndex')
  vim.cmd('VimwikiDiaryGenerateLinks')
end, { nargs = '*' })

vim.api.nvim_create_user_command('DiaryToday', function(opts)
  vim.cmd('VimwikiMakeDiaryNote' .. table.concat(opts.fargs, ' '))
end, { nargs = '*' })

-- Wiki
vim.api.nvim_create_user_command('Wiki', function(opts)
  vim.cmd('VimwikiGoto ' .. table.concat(opts.fargs, ' '))
end, { nargs = '*' })
