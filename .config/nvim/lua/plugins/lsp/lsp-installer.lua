local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "v",
      server_pending = ">",
      server_uninstalled = "x"
    }
  }
})

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require("plugins.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

-- Install LSP servers
local status_ok, lsp_installer_servers = pcall(require, "nvim-lsp-installer.servers")
if not status_ok then
  return
end

lsp_servers = {"clangd", "pyright", "sumneko_lua"}

for _, lsp_server in ipairs(lsp_servers) do
  local server_available, requested_server = lsp_installer_servers.get_server(lsp_server)
  if server_available and not requested_server:is_installed() then
    -- Queue the server to be installed
    requested_server:install()
  end
end
