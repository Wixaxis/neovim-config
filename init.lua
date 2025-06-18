require 'configs.core'
require 'utils.lazy_installer'.ensure_installed()
--- @diagnostic disable-next-line: missing-fields
require 'lazy'.setup({ { import = 'plugins' } }, {
	checker = { enabled = true }
})
require 'utils'.set_default_colorscheme(nil)
require 'configs.mappings'.assign_base_mappings()
if vim.g.neovide then require 'configs.neovide' end
require 'configs.nvim-treesitter'

-- TODO: Move all below to some config file
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then return end

		-- Apply LSP mappings from configs.mappings
		local lsp_mappings = require('configs.mappings').lsp_mappings
		require 'utils'.set_keymaps(lsp_mappings, { buffer = bufnr })
	end
})
