local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  vim.notify("Unable to load: " .. "colorizer")
  return
end

colorizer.setup()