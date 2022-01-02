local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local fn = vim.fn               -- call Vim functions
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

-- General
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile
opt.backup = false            -- don't use backup
opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.encoding = 'utf-8'        -- use utf-8 encoding
opt.fileencoding = "utf-8"    -- the encoding written to a file
opt.compatible = false        -- disable vi compatibility
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.timeoutlen = 1000         -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 300          -- faster completion (4000ms default)
opt.ignorecase = true         -- ignore case in search patterns

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
opt.splitbelow = true
opt.splitright = true

-- Autocompletion
opt.completeopt = 'menuone,noselect' -- insert mode completion options

-- Tabs, indent
opt.expandtab = true      -- convert tabs to spaces
opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
opt.tabstop = 2           -- insert 2 spaces for a tab
opt.smartindent = true    -- autoindent new lines

-- Memory, CPU
opt.hidden = true         -- enable background buffers
opt.history = 128         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 256       -- max column for syntax highlight

-- Neovim UI
opt.showmatch = true          -- highlight matching parenthesis
opt.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
--opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.linebreak = true          -- wrap on word boundary
opt.cmdheight = 2             -- more space in the neovim command line for displaying messages
opt.conceallevel = 0          -- so that `` is visible in markdown files
opt.pumheight = 10            -- pop up menu height
opt.showtabline = 2           -- always show tabs
opt.termguicolors = true      -- set term gui colors (most terminals support this)
opt.title = true              -- show title in terminal
opt.cursorline = true         -- highlight the current line
opt.number = true             -- set numbered lines
opt.relativenumber = true     -- set relative numbered lines
opt.numberwidth = 4           -- number column width {default 4}
opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false              -- display lines as one long line
opt.showmode = true           -- if in Insert, Replace or Visual mode put a message on the last line.
opt.showcmd = true            -- show (partial) command in the last line of the screen.
opt.hlsearch = true            -- highlight all matches on previous search pattern
opt.ruler = true              -- show the line and column number of the cursor position, separated by a comma.
opt.scrolloff = 8             -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8         -- minimal number of screen columns to keep to the left and to the right of the cursor
--opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

opt.shortmess:append "c"

-- Colorscheme
cmd [[colorscheme gruvbox]]

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- don't auto commenting new lines
--cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

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

