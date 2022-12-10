local keymap = vim.keymap

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Telescope keymaps
-- See after/plugin/telescope.rc.lua

-- Increment/decrement
-- keymap.set('n', '+', '<C-a>')
-- keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d');

-- Select all
-- keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })

-- Split window
keymap.set('n', '<Space>s', ':split<Return><C-w>w', { silent = true })
keymap.set('n', '<Space>v', ':vsplit<Return><C-w>w', { silent = true })

-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('n', '<Space>h', '<C-w>h')
keymap.set('n', '<Space>j', '<C-w>j')
keymap.set('n', '<Space>k', '<C-w>k')
keymap.set('n', '<Space>l', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Copy current file path to clipboard
keymap.set('n', '<Space>p', ':let @*=expand("%")<Return>')

-- Set "Y" to copy to end of line
keymap.set('n', 'Y', 'y$')

-- Diagnostics (ex. eslint messages, etc.)
keymap.set('n', '<Space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
