-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Dim Neovim when it loses focus (for tmux pane switching)
local focus_group = vim.api.nvim_create_augroup("FocusIndicator", { clear = true })
vim.api.nvim_create_autocmd("FocusLost", {
  group = focus_group,
  callback = function()
    vim.opt.cursorline = false
    vim.opt.colorcolumn = ""
    vim.cmd("hi Normal guibg=#1a1a1a")
  end,
})
vim.api.nvim_create_autocmd("FocusGained", {
  group = focus_group,
  callback = function()
    vim.opt.cursorline = true
    vim.cmd("hi Normal guibg=NONE")
  end,
})

-- Enable cursorline by default
vim.opt.cursorline = true
