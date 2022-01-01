local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local fn = vim.fn               -- call Vim functions
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

-- General
g.mapleader = ','             -- change leader to a comma
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile
opt.backup = false            -- don't use backup
opt.encoding = 'utf-8'        -- use utf-8 encoding
opt.compatible = false        -- disable vi compatibility
-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
opt.splitbelow = true
opt.splitright = true

-- Neovim UI
opt.number = true             -- show line number
opt.showmatch = true          -- highlight matching parenthesis
opt.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
--opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- orizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.linebreak = true          -- wrap on word boundary

opt.title = true     -- show title in terminal
opt.hlsearch = true  -- highlight search
opt.showmode = true  -- if in Insert, Replace or Visual mode put a message on the last line.
opt.showcmd = true   -- show (partial) command in the last line of the screen.
opt.ruler = true     -- show the line and column number of the cursor position, separated by a comma.

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Memory, CPU
opt.hidden = true         -- enable background buffers
opt.history = 128         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 256       -- max column for syntax highlight

-- Tabs, indent
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 2        -- shift 4 spaces when tab
opt.tabstop = 2           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
--cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Autocompletion
opt.completeopt = 'menuone,noselect' -- insert mode completion options

-- Make an undo directory if it does not exist. Enable undo
local undo_dir = fn.expand('~/.cache/nvim/undo')
if fn.isdirectory(undo_dir) == 0 then
  fn.mkdir(undo_dir, 'p')
end
opt.undodir = undo_dir  -- Set the undo directory
opt.undofile = true     -- Turn on persistent undo

-- Enable Russian keymap
opt.keymap = 'russian-jcukenwin'
opt.iminsert = 0 -- Use EN on start (start > i)
opt.imsearch = 0 -- Use EN on search (start > /)

-- airline fix for urxvt
g.airline_powerline_fonts = 0
g.airline_symbols_ascii = 1

