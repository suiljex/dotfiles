-- Keymaps configuration file: keymaps of neovim and plugins.
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
keymap('', '<up>', '<nop>', { noremap = true })
keymap('', '<down>', '<nop>', { noremap = true })
keymap('', '<left>', '<nop>', { noremap = true })
keymap('', '<right>', '<nop>', { noremap = true })

-- Neovim shortcuts:
-- move around splits using Ctrl + {h,j,k,l}
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

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

-- move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- clear search highlighting
keymap('n', '<leader>c', ':nohl<CR>', opts)

-- fast saving with <leader> and s
keymap('n', '<leader>s', ':w<CR>', opts)
keymap('i', '<leader>s', '<C-c>:w<CR>', opts)

-- close all windows and exit from neovim
keymap('n', '<leader>q', ':qa!<CR>', opts)

-- Press jk fast to Esc
keymap("i", "jk", "<ESC>", opts)


-- Applications & Plugins shortcuts:
-- open Lexplorer
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- -- nvim-tree
-- keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)       -- open/close
-- keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)  -- refresh
-- keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', opts) -- search file

-- Telescope
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", opts)