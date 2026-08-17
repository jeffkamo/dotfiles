-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local del = vim.keymap.del
local set = vim.keymap.set

del("n", "<A-k>", { silent = true })
del("n", "<A-j>", { silent = true })
del("i", "<A-k>", { silent = true })
del("i", "<A-j>", { silent = true })
del("v", "<A-k>", { silent = true })
del("v", "<A-j>", { silent = true })

set("n", "<leader>jp", function()
  local rel = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  vim.fn.setreg("*", rel)
end, { desc = "Copy current file path (relative)" })

set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = vim.fn.getcwd() })
end, { desc = "Lazygit (cwd)" })
