function config_telescope()
  require('telescope').setup {
    pickers = {
      find_files = {
        hidden = true
      }
    }
  }
end