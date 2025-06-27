require 'configs.core'
require('utils.lazy_installer').ensure_installed()
--- @diagnostic disable-next-line: missing-fields
require('lazy').setup({ { import = 'plugins' } }, {
  checker = { enabled = true },
})
require('utils.init').set_default_colorscheme(nil)
require('configs.mappings').assign_base_mappings()
if vim.g.neovide then require 'configs.neovide' end
require 'configs.nvim-treesitter'

require('utils.autocmds').setup()
