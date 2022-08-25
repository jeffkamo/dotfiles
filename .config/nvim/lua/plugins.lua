-- install packer.nvim and plugins
-- https://github.com/wbthomason/packer.nvim
--
-- :PackerCompile                    - Regenerate compiled loader file
-- :PackerClean                      - Remove any disabled or unused plugins
-- :PackerInstall                    - Clean, then install missing plugins
-- :PackerUpdate                     - Clean, then update and install plugins
-- :PackerSync                       - Perform `PackerUpdate` and then `PackerCompile`
-- :PackerLoad completion-nvim ale   - Loads opt plugin immediately

local execute = vim.api.nvim_command
local fn = vim.fn
local CURDIR = (...):match "(.-)[^%.]+$"

local packer_init = false
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_init = true
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  execute("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer = require "packer"

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- reload if this buffer changes
vim.cmd [[
  augroup packer_refresh
  autocmd!
  autocmd BufWritePost plugins.lua PackerClean
  autocmd BufWritePost plugins.lua PackerInstall
  autocmd BufWritePost plugins.lua PackerCompile
  augroup END
]]

-- vimscript commands can be run using vim.cmd
vim.cmd [[packadd packer.nvim]]

-- Lua plugins are installed with packer
packer.startup(function(user)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'hoob3rt/lualine.nvim' -- Statusline
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'L3MON4D3/LuaSnip' -- Snippet
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnoistics, code actions, and more
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'kylechui/nvim-surround'
  use 'ojroques/nvim-osc52' -- Yank from anywhere (even SSH) to and from the clipboard
end)
