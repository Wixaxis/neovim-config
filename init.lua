require 'configs.core'
require 'utils.lazy_installer'.ensure_installed()
---@diagnostic disable-next-line: missing-fields
require 'lazy'.setup({ { import = 'plugins' } }, {
	checker = { enabled = true }
})
require 'utils.init'.set_default_colorscheme(nil)
require 'configs.mappings'.assign_base_mappings();
if vim.g.neovide then require 'configs.neovide' end
pcall(require 'telescope'.load_extension, 'fzf')
pcall(require 'telescope'.load_extension, 'ui-select')
require('telescope').load_extension('noice')
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
