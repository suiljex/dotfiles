-- Keymaps configuration file: keymaps of neovim and plugins.
-- Keymaps for plugins are stored in the configuration files of these plugins

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- Add command to Nuke nvim
cmd [[ command! NukeNVIM execute '!rm -rf "$HOME/.local/share/nvim" "$HOME/.cache/nvim" "$HOME/.config/nvim/plugin/packer_compiled.lua"' ]]

-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- don't use arrow keys
keymap("", "<Up>", "<nop>", { noremap = true })
keymap("", "<Down>", "<nop>", { noremap = true })
keymap("", "<Left>", "<nop>", { noremap = true })
keymap("", "<Right>", "<nop>", { noremap = true })

-- Neovim shortcuts:
-- move around splits using Ctrl + {h,j,k,l}
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down in visual mode
keymap("v", "<A-j>", ":move .+1<CR>==", opts)
keymap("v", "<A-k>", ":move .-2<CR>==", opts)

-- move text up and down in visual block mode
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- preserve clipboard buffer when pasting in visual mode
keymap("v", "p", '"_dP', opts)

-- clear search highlighting
keymap("n", "<leader>c", ":nohl<CR>", opts)

-- fast saving with <leader> and s
--keymap("n", "<leader>s", ":w<CR>", opts)
--keymap("i", "<leader>s", "<C-c>:w<CR>", opts)

-- close all windows and exit from neovim
keymap("n", "<leader>q", ":qa!<CR>", opts)

-- Press jk fast to Esc
keymap("i", "jk", "<ESC>", opts)

-- Toggle Spellcheck
keymap("n", "<leader>ss", ":setlocal spell! spelllang=en_us,ru<CR>", opts)
