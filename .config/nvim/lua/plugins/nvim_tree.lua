vim.g.nvim_tree_show_icons = {
  folders = 0,
  files = 0,
  git = 0,
  folder_arrows = 0,
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
}