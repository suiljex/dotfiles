-- Automatically bootstrap packer.nvim
local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local fn = vim.fn               -- call Vim functions
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window and ASCII symbols
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    working_sym = '%', -- The symbol for a plugin being installed/updated
    error_sym = 'x', -- The symbol for a plugin with an error in installation/updating
    done_sym = 'v', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '-', -- The symbol for an unused plugin which was removed
    moved_sym = '>', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '=', -- The symbol for the header line in packer's display
  },
}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim'    -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim'  -- Useful lua functions used ny lots of plugins

  use 'vim-airline/vim-airline'
  --use 'kyazdani42/nvim-tree.lua'

  use 'ap/vim-css-color'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'

  -- Colorschemes
  use 'lunarvim/darkplus.nvim'

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
