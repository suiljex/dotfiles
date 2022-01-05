local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.cmd [[highlight Pmenu ctermbg=darkgrey guibg=darkgrey]]
  vim.cmd [[highlight PmenuSel ctermbg=grey guibg=grey]]
  vim.cmd [[highlight PmenuSbar ctermbg=gray guibg=gray]]
  vim.cmd [[highlight PmenuThumb ctermbg=gray guibg=gray]]
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end