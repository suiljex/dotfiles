local M = {}

M.setup = function()
  local cmp_status_ok, configs = pcall(require, "nvim-treesitter.configs")
  if not cmp_status_ok then
    return
  end

  configs.setup {
    ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
  }
end

return M