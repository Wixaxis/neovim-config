require 'configs.core'
require 'utils'.ensure_lazy_installed()
require 'lazy'.setup({ { import = 'plugins' } }, {
	checker = { enabled = true }
})
require 'utils'.set_default_colorscheme(nil)
require 'configs.mappings'
if vim.g.neovide then require 'configs.neovide' end
pcall(require 'telescope'.load_extension, 'fzf')
pcall(require 'telescope'.load_extension, 'ui-select')
require('telescope').load_extension('noice')
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
require 'configs.cmp'
