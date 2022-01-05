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

-- Use a protected call so we don"t error out on first use
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
    working_sym = "%", -- The symbol for a plugin being installed/updated
    error_sym = "x", -- The symbol for a plugin with an error in installation/updating
    done_sym = "v", -- The symbol for a plugin which has completed installation/updating
    removed_sym = "-", -- The symbol for an unused plugin which was removed
    moved_sym = ">", -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = "=", -- The symbol for the header line in packer"s display
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins

  -- Status bar
  use {
    "nvim-lualine/lualine.nvim",
    config = function() require "plugins.lualine" end,
  }

  -- Highlight color values
  use {
    "norcalli/nvim-colorizer.lua",
    config = function() require "plugins.nvim_colorizer" end,
  }

  -- Colorschemes
  use "lunarvim/darkplus.nvim"

  -- Tab bar
  use {
    "romgrk/barbar.nvim",
    config = function() require "plugins.barbar" end,
  }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",             -- The completion plugin
    requires = {
      "hrsh7th/cmp-buffer",         -- buffer completions
      "hrsh7th/cmp-path",           -- path completions
      "hrsh7th/cmp-cmdline",        -- cmdline completions
      "saadparwaiz1/cmp_luasnip",   -- snippet completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      {
        "L3MON4D3/LuaSnip",         -- snippet engine
        requires = "rafamadriz/friendly-snippets", -- a bunch of snippets to use
      },
    },
    config = function() require "plugins.cmp" end,
  }

  -- LSP
  use {
    "williamboman/nvim-lsp-installer",  -- simple to use language server installer
    requires = "neovim/nvim-lspconfig", -- enable LSP
    config = function() require "plugins.lsp" end,
  }

  use {
    "folke/trouble.nvim",  -- Enable TroubleToggle command
    config = function() require "plugins.trouble_toggle" end,
  }

  -- NULL-LS
  use {
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    requires = "neovim/nvim-lspconfig", -- enable LSP
    config = function() require "plugins.null_ls" end,
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function() require "plugins.treesitter" end,
    run = ":TSUpdate",
  }

  -- Debugger
  use {
    "mfussenegger/nvim-dap",
    config = function() require "plugins.nvim_dap" end,
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = "mfussenegger/nvim-dap",
    config = function() require "plugins.nvim_dap_ui" end,
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require "plugins.telescope" end,
  }

  -- Autopairs, integrates with both cmp and treesitter
  use {
    "windwp/nvim-autopairs",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    config = function() require "plugins.auto_pairs" end,
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function() require "plugins.gitsigns" end,
  }

  -- Comments plugin
  use {
    "numToStr/Comment.nvim", -- Easily comment stuff
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function() require "plugins.comment" end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require "plugins.indent_blankline" end,
  }

  -- NVIM Tree file explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function() require "plugins.nvim_tree" end,
  }

  -- StartupTime analyzer
  use {
    "dstein64/vim-startuptime",
    opt = true,
    cmd = {"StartupTime"},
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)