function setup_nvim_tree()
  -- Disable nvim-tree icons
  vim.g.nvim_tree_show_icons = {
    folders = 0,
    files = 0,
    git = 0,
    folder_arrows = 0,
  }
end
  
function config_nvim_tree()
  require('nvim-tree').setup {
  }
end