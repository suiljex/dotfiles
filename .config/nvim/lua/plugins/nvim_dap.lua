local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  vim.notify("Unable to load: " .. "dap")
  return
end

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Debugger keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>dh", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dH", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<A-k>",      ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<A-l>",      ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<A-j>",      ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<A-h>",      ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>dn", ":lua require'dap'.run_to_cursor()<CR>", opts)
keymap("n", "<leader>dk", ":lua require'dap'.up()<CR>", opts)
keymap("n", "<leader>dj", ":lua require'dap'.down()<CR>", opts)
keymap("n", "<leader>dc", ":lua require'dap'.terminate()<CR>", opts)
keymap("n", "<leader>dr", ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l", opts)
keymap("n", "<leader>de", ":lua require'dap'.set_exception_breakpoints({'all'})<CR>", opts)
keymap("n", "<leader>di", ":lua require'dap.ui.widgets'.hover()<CR>", opts)
keymap("n", "<leader>d?", ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", opts)