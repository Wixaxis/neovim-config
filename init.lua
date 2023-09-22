require 'configs.core'
require 'scripts.ensure-lazy'
require('lazy').setup({ { import = 'plugins' } }, {})
if vim.g.neovide then require 'configs.neovide' end
require 'configs.mappings'
pcall(require 'telescope'.load_extension, 'fzf')
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
require 'configs.cmp'
