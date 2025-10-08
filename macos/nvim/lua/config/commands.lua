vim.api.nvim_create_user_command('Pt', function(opts)
  vim.cmd('Ack ' .. table.concat(opts.fargs, ' '))
end, { nargs = '*' })
