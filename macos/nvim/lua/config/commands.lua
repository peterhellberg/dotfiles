-- Pt
vim.api.nvim_create_user_command('Pt', function(opts)
  vim.cmd('Ack ' .. table.concat(opts.fargs, ' '))
end, { nargs = '*' })

-- Path
vim.api.nvim_create_user_command('File', function(opts)
  print(vim.fn.expand('%:p'))
end, { nargs = '*' })
