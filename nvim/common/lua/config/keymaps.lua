-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function git_root()
  local dir = vim.fn.expand("%:p:h")
  local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
  if vim.v.shell_error ~= 0 or not root then
    return nil
  end
  return root
end

local function copy_path(absolute)
  local path = vim.fn.expand("%:p")
  if not absolute then
    local root = git_root()
    if root then
      path = path:sub(#root + 2)
    else
      path = vim.fn.fnamemodify(path, ":.")
    end
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end

vim.keymap.set("n", "<leader>jp", function() copy_path(false) end, { desc = "Copy path (relative to repo root)" })
vim.keymap.set("n", "<leader>jP", function() copy_path(true) end, { desc = "Copy path (absolute)" })

local ok, which_key = pcall(require, "which-key")
if ok then
  which_key.add({ { "<leader>j", group = "path" } })
end
