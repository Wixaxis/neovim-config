require 'configs.core'
require 'utils'.ensure_lazy_installed()
require 'lazy'.setup({ { import = 'plugins' } }, {})
require 'utils'.set_default_colorscheme()
require 'configs.mappings'
if vim.g.neovide then require 'configs.neovide'.set_defaults() end
pcall(require 'telescope'.load_extension, 'fzf')
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
require 'configs.cmp'
