require 'configs.core'
require 'scripts.ensure-lazy'
require('lazy').setup({ { import = 'plugins' } }, {})
require 'configs.mappings'
pcall(require('telescope').load_extension, 'fzf')
if require 'configs.plugs'.scope then
	require 'telescope'.load_extension 'scope'
end
require 'configs.nvim-treesitter'
require 'configs.mason-lspconfig'
require 'configs.cmp'
if vim.g.neovide then
	require 'configs.neovide'
end
