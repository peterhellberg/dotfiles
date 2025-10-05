return {
  on_init = function(client)
    client.notify("workspace/didChangeConfiguration", {
      settings = client.config.settings,
    })
  end,
  settings = {
    gopls = {
      analyses = {
        unusedvariable = false,
        deprecated = false,
      },
      staticcheck = true,
    },
  },
  capabilities = require("core.lsp.capabilities"),
}
