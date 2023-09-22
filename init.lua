require 'configs.core'
require 'scripts.ensure-lazy'
require('lazy').setup({ { import = 'plugins' } }, {})
require 'configs.mappings'
if vim.g.neovide then require 'configs.neovide'.set_defaults() end
pcall(require 'telescope'.load_extension, 'fzf')
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
require 'configs.cmp'
