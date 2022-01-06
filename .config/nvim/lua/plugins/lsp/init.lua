local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Unable to load: " .. "lspconfig")
  return
end

require("plugins.lsp.lsp-installer")
require("plugins.lsp.handlers").setup()