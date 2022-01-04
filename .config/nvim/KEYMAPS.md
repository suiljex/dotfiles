# Keymaps cheatsheet

Keymaps configuration of neovim is in the `lua/keymaps.lua`

Keymaps for plugins are stored in the configuration files of these plugins.

## Keymaps

- Leader key: `space`
- Arrow keys are disabled

### Nvim

Keymaps file: `lua/keymaps.lua`

#### Nvim Commands

Delete all plugins, history:

- `:NukeNVIM`

#### Disable arrow keys

| Mode | Key       | Action  | Comment             |
|------|-----------|---------|---------------------|
| all  | `<Up>`    | `<nop>` | disable arrow Up    |
| all  | `<Down>`  | `<nop>` | disable arrow Down  |
| all  | `<Left>`  | `<nop>` | disable arrow Left  |
| all  | `<Right>` | `<nop>` | disable arrow Right |

#### Move around splits using `Ctrl + {h,j,k,l}`

| Mode   | Key     | Action   | Comment             |
|--------|---------|----------|---------------------|
| normal | `<C-h>` | `<C-w>h` | Move to left split  |
| normal | `<C-j>` | `<C-w>j` | Move to down split  |
| normal | `<C-k>` | `<C-w>k` | Move to up split    |
| normal | `<C-l>` | `<C-w>l` | Move to right split |

#### Resize splits with arrows

| Mode   | Key         | Action                    | Comment             |
|--------|-------------|---------------------------|---------------------|
| normal | `<C-Up>`    | `:resize +2<CR>`          | Increase split size |
| normal | `<C-Down>`  | `:resize -2<CR>`          | Decrease split size |
| normal | `<C-Left>`  | `:vertical resize -2<CR>` | Decrease split size |
| normal | `<C-Right>` | `:vertical resize +2<CR>` | Increase split size |

#### Navigate buffers

| Mode   | Key     | Action           | Comment                   |
|--------|---------|------------------|---------------------------|
| normal | `<S-l>` | `:bnext<CR>`     | Go to the next buffer     |
| normal | `<S-l>` | `:bprevious<CR>` | Go to the previous buffer |

#### Stay in visual mode while editing indentation

| Mode   | Key | Action | Comment                |
|--------|-----|--------|------------------------|
| visual | `<` | `<gv`  | Decrease indentation   |
| visual | `>` | `>gv`  | Increase   indentation |

#### Move text up and down in visual mode

| Mode         | Key     | Action                | Comment        |
|--------------|---------|-----------------------|----------------|
| visual       | `<A-j>` | `:move .+1<CR>==`     | Move text up   |
| visual       | `<A-k>` | `:move .-2<CR>==`     | Move text down |
| visual_block | `<A-j>` | `:move '>+1<CR>gv-gv` | Move text up   |
| visual_block | `<A-k>` | `:move '>-2<CR>gv-gv` | Move text down |

#### Better terminal navigation

| Mode | Key     | Action              | Comment |
|------|---------|---------------------|---------|
| term | `<C-h>` | `<C-\\><C-N><C-w>h` |         |
| term | `<C-j>` | `<C-\\><C-N><C-w>j` |         |
| term | `<C-k>` | `<C-\\><C-N><C-w>k` |         |
| term | `<C-l>` | `<C-\\><C-N><C-w>l` |         |

#### Misc

| Mode   | Key         | Action      | Comment                                               |
|--------|-------------|-------------|-------------------------------------------------------|
| visual | `p`         | `_dP`       | Preserve clipboard buffer when pasting in visual mode |
| normal | `<leader>c` | `:nohl<CR>` | Clear search highlighting                             |
| normal | `<leader>q` | `:qa!<CR>`  | Close all windows and exit from neovim                |
| insert | `jk`        | `<ESC>`     | Press jk fast to Esc                                  |

### Debugger (dap + dapui)

Keymaps files:

- `lua/plugins/nvim_dap.lua`
- `lua/plugins/nvim_dap_ui.lua`

#### Breakpoints

| Mode   | Key          | Action                                                                         | Comment                       |
|--------|--------------|--------------------------------------------------------------------------------|-------------------------------|
| normal | `<leader>dh` | `:lua require"dap".toggle_breakpoint()<CR>`                                    | Toggle breakpoint             |
| normal | `<leader>dH` | `:lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>` | Set breakpoint with condition |
| normal | `<leader>de` | `:lua require"dap".set_exception_breakpoints({"all"})<CR>`                     |                               |

#### Debugging actions

| Mode   | Key          | Action                                                                                  | Comment                 |
|--------|--------------|-----------------------------------------------------------------------------------------|-------------------------|
| normal | `<A-k>`      | `:lua require"dap".step_out()<CR>`                                                      | Step out                |
| normal | `<A-l>`      | `:lua require"dap".step_into()<CR>`                                                     | Step into               |
| normal | `<A-j>`      | `:lua require"dap".step_over()<CR>`                                                     | Step over               |
| normal | `<A-h>`      | `:lua require"dap".continue()<CR>`                                                      | Continue or Start       |
| normal | `<leader>dn` | `:lua require"dap".run_to_cursor()<CR>`                                                 | Run to Cursor           |
| normal | `<leader>dc` | `:lua require"dap".terminate()<CR>`                                                     | Terminate program       |
| normal | `<leader>dk` | `:lua require"dap".up()<CR>`                                                            |                         |
| normal | `<leader>dj` | `:lua require"dap".down()<CR>`                                                          |                         |
| normal | `<leader>dr` | `:lua require"dap".repl.toggle({}| "vsplit")<CR><C-w>l`                                 |                         |
| normal | `<leader>di` | `:lua require"dap.ui.widgets".hover()<CR>`                                              |                         |
| normal | `<leader>d?` | `:lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>` |                         |
| normal | `<leader>db` | `:lua require"dapui".toggle()<CR>`                                                      | Open/Close debugging UI |

### Tabs (barbar)

Keymaps file: `lua/plugins/barbar.lua`

#### barbar Commands

Wipeout buffer:

- `:BufferWipeout<CR>`

Close commands:

- `:BufferCloseAllButCurrent<CR>`
- `:BufferCloseBuffersLeft<CR>`
- `:BufferCloseBuffersRight<CR>`

Other:

- `:BarbarEnable` - enables barbar (enabled by default)
- `:BarbarDisable` - very bad command, should never be used

#### Move to previous/next tab

| Mode   | Key     | Action                | Comment              |
|--------|---------|-----------------------|----------------------|
| normal | `<A-,>` | `:BufferPrevious<CR>` | Move to previous tab |
| normal | `<A-.>` | `:BufferNext<CR>`     | Move to next tab     |

#### Re-order to previous/next tab

| Mode   | Key     | Action                    | Comment                  |
|--------|---------|---------------------------|--------------------------|
| normal | `<A-<>` | `:BufferMovePrevious<CR>` | Re-order to previous tab |
| normal | `<A->>` | `:BufferMoveNext<CR>`     | Re-order to next tab     |

#### Goto buffer in position

| Mode   | Key     | Action              | Comment |
|--------|---------|---------------------|---------|
| normal | `<A-1>` | `:BufferGoto 1<CR>` |         |
| normal | `<A-2>` | `:BufferGoto 2<CR>` |         |
| normal | `<A-3>` | `:BufferGoto 3<CR>` |         |
| normal | `<A-4>` | `:BufferGoto 4<CR>` |         |
| normal | `<A-5>` | `:BufferGoto 5<CR>` |         |
| normal | `<A-6>` | `:BufferGoto 6<CR>` |         |
| normal | `<A-7>` | `:BufferGoto 7<CR>` |         |
| normal | `<A-8>` | `:BufferGoto 8<CR>` |         |
| normal | `<A-9>` | `:BufferGoto 9<CR>` |         |
| normal | `<A-0>` | `:BufferLast<CR>`   |         |

#### Manage buffers

| Mode   | Key     | Action             | Comment                   |
|--------|---------|--------------------|---------------------------|
| normal | `<A-c>` | `:BufferClose<CR>` | Close buffer              |
| normal | `<C-p>` | `:BufferPick<CR>`  | Magic buffer-picking mode |

#### Sort buffers automatically by

| Mode   | Key          | Action                           | Comment                   |
|--------|--------------|----------------------------------|---------------------------|
| normal | `<leader>bb` | `:BufferOrderByBufferNumber<CR>` | Sort buffers by Number    |
| normal | `<leader>bd` | `:BufferOrderByDirectory<CR>`    | Sort buffers by Directory |
| normal | `<leader>bl` | `:BufferOrderByLanguage<CR>`     | Sort buffers by Language  |

### Trouble

Keymaps file: `lua/plugins/trouble_toggle.lua`

#### Trouble keymaps

| Mode   | Key  | Action                    | Comment            |
|--------|------|---------------------------|--------------------|
| normal | `gt` | `<cmd>:TroubleToggle<cr>` | Open/Close Trouble |

### Nvimtree

Keymaps file: `lua/plugins/nvim_tree.lua`

#### Nvimtree keymaps

| Mode   | Key         | Action                | Comment             |
|--------|-------------|-----------------------|---------------------|
| normal | `<leader>e` | `:NvimTreeToggle<cr>` | Open/Close Nvimtree |

### Telescope

Keymaps file: `lua/plugins/telescope.lua`

#### Telescope Keymaps

| Mode   | Key         | Action                                                                                                                | Comment             |
|--------|-------------|-----------------------------------------------------------------------------------------------------------------------|---------------------|
| normal | `<leader>f` | `<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>` | Fuzzy search files  |
| normal | `<leader>t` | `<cmd>lua require'telescope.builtin'.live_grep()<cr>`                                                                 | Fuzzy text in files |

### LSP

Keymaps file: `lua/plugins/lsp/handlers.lua`

#### LSP Commands

Refactoring:

- `:Format` - format code

#### Navigation and information display

| Mode   | Key  | Action                                      | Comment             |
|--------|------|---------------------------------------------|---------------------|
| normal | `K`  | `<cmd>lua vim.lsp.buf.hover()<CR>`          | Show quick info     |
| normal | `gd` | `<cmd>lua vim.lsp.buf.definition()<CR>`     | Goto definition     |
| normal | `gD` | `<cmd>lua vim.lsp.buf.declaration()<CR>`    | Goto declaration    |
| normal | `gi` | `<cmd>lua vim.lsp.buf.implementation()<CR>` | Goto implementation |
| normal | `gr` | `<cmd>lua vim.lsp.buf.references()<CR>`     | Show references     |
| normal | `gs` | `<cmd>lua vim.lsp.buf.signature_help()<CR>` | Show signature help |

#### Diagnostic

| Mode   | Key  | Action                                                          | Comment                         |
|--------|------|-----------------------------------------------------------------|---------------------------------|
| normal | `gl` | `<cmd>lua vim.diagnostic.open_float(0| { scope = 'line'})<CR>`  | Show line diagnostic            |
| normal | `[d` | `<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>` | Goto previous point of interest |
| normal | `]d` | `<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>` | Goto next point of interest     |

#### Refactoring

| Mode   | Key          | Action                                   | Comment       |
|--------|--------------|------------------------------------------|---------------|
| normal | `<leader>rn` | `<cmd>lua vim.lsp.buf.rename()<CR>`      | Rename symbol |
| normal | `<leader>ca` | `<cmd>lua vim.lsp.buf.code_action()<CR>` | Code action   |
| normal | `<leader>l`  | `<cmd>lua vim.lsp.buf.formatting()<CR>`  | Reformat code |
