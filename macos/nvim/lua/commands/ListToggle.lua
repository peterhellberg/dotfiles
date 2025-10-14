vim.api.nvim_create_user_command("ListToggle", function(opts)
  vim.opt.list = not vim.opt.list:get()
end, { nargs = '*' })

