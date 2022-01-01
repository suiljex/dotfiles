-- Automatically bootstrap packer.nvim
local exec = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  exec 'packadd packer.nvim'
end

require 'plugins.config'

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim'    -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim'  -- Useful lua functions used ny lots of plugins

  use 'vim-airline/vim-airline'
  use {
    'kyazdani42/nvim-tree.lua',
    setup = setup_nvim_tree,
    config = config_nvim_tree,
  }
  use 'ap/vim-css-color'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = config_telescope,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
