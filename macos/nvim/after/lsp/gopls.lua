return {
  on_init = function(client)
    client.notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end,
  settings = {
    gopls = {
      analyses = {
        fillreturns  = true,
        ineffassign  = true,
        nilness      = true,
        shadow       = true,
        structtag    = true,
        typeparams   = true,
        unreachable  = true,
        unusedparams = true,
        unusedwrite  = true,
      },
      buildFlags = {"-tags=integration,webtest,local"},
      staticcheck = false,
      linksInHover = false,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
  capabilities = require("core.lsp.capabilities"),
}
