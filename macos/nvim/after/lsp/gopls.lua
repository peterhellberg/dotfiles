return {
  on_init = function(client)
    client.notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end,
  settings = {
    gopls = {
      analyses = {
        deprecated = false,
        shadow = true,
        unusedparams = true,
        unusedvariable = false,
      },
      buildFlags = {"-tags=integration,webtest,local"},
      linksInHover = false,
      completeUnimported = true,
      staticcheck = false,
      usePlaceholders = true,
    },
  },
  capabilities = require("core.lsp.capabilities"),
}
