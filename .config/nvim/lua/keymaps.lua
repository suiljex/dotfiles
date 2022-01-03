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
--keymap('i', '<leader>s', '<C-c>:w<CR>', opts)

-- close all windows and exit from neovim
keymap('n', '<leader>q', ':qa!<CR>', opts)

-- Press jk fast to Esc
keymap("i", "jk", "<ESC>", opts)


-- Applications & Plugins shortcuts:
-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>t", "<cmd>lua require'telescope.builtin'.live_grep()<cr>", opts)

-- open/close Trouble
keymap("n", "gt", "<cmd>:TroubleToggle<cr>", opts)

-- Tabs (barbar)
-- Move to previous/next
keymap('n', '<A-,>', ':BufferPrevious<CR>', opts)
keymap('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
keymap('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', ':BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keymap('n', '<A-1>', ':BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', ':BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', ':BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', ':BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', ':BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', ':BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', ':BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', ':BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', ':BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
keymap('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
keymap('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
keymap('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', opts)
keymap('n', '<leader>bd', ':BufferOrderByDirectory<CR>', opts)
keymap('n', '<leader>bl', ':BufferOrderByLanguage<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Debugger keymaps
keymap('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap('n', '<A-k>',      ':lua require"dap".step_out()<CR>', opts)
keymap('n', '<A-l>',      ':lua require"dap".step_into()<CR>', opts)
keymap('n', '<A-j>',      ':lua require"dap".step_over()<CR>', opts)
keymap('n', '<A-h>',      ':lua require"dap".continue()<CR>', opts)
keymap('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>', opts)
keymap('n', '<leader>dk', ':lua require"dap".up()<CR>', opts)
keymap('n', '<leader>dj', ':lua require"dap".down()<CR>', opts)
keymap('n', '<leader>dc', ':lua require"dap".terminate()<CR>', opts)
keymap('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', opts)
keymap('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>', opts)
keymap('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>', opts)
keymap('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>', opts)
keymap('n', '<leader>db', ':lua require"dapui".toggle()<CR>', opts)