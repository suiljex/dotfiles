local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  vim.notify("Unable to load: " .. "trouble")
  return
end

trouble.setup {
  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "E",
    warning = "W",
    hint = "H",
    information = "I"
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- Trouble Toggle keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>g", "<cmd>:TroubleToggle<cr>", opts)