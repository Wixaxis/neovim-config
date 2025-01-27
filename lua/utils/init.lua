local M = {}
M.neovide = require 'utils.neovide'
M.lsp = require 'utils.lsp'
-- M.lazy = require 'utils.lazy_installer'
M.telescope = require 'utils.telescope'

M.str_split = function(inputstr, sep)
	if sep == nil then sep = "%s"; end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

M.set_default_colorscheme = function(theme_mode)
	theme_mode = theme_mode or 'dark'
	local default_theme = theme_mode == 'dark' and require 'defaults'.dark_theme or require 'defaults'.light_theme
	local current_theme = vim.cmd.colorscheme()
	if current_theme == default_theme then
		vim.notify('Theme [' .. current_theme .. '] already set, omitting...')
		return
	end
	vim.notify('Set theme to ' .. default_theme)
	vim.cmd.colorscheme(default_theme)
end

M.sys_name = vim.loop.os_uname().sysname

M.base = {
	delete_buffer = function() require('snacks').bufdelete.delete() end,
	open_lazygit = function() require('snacks').lazygit.open() end,
	git_file_history = function() require('snacks').lazygit.log_file() end,
}

M.auto_dark_mode = { disable = function() require 'auto-dark-mode'.disable() end }

M.autopairs = {
	enable  = function() require 'nvim-autopairs'.enable() end,
	disable = function() require 'nvim-autopairs'.disable() end,
}

M.barbecue = { toggle = function() require 'barbecue.ui'.toggle() end }

M.commander = {
	show = function()
		vim.g.last_current_bufnr = vim.api.nvim_get_current_buf()
		require 'commander'.show({})
	end
}

M.comment = {
	one_line   = function()
		require 'Comment'
		require "Comment.api".toggle.linewise.current()
	end,
	many_lines = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
}

M.fterm = { toggle = function() require 'FTerm'.toggle() end }

M.gitsigns = {
	toggle_line_blame = function()
		if vim.api.nvim_buf_is_valid(vim.g.last_current_bufnr) then
			vim.api.nvim_set_current_buf(vim.g.last_current_bufnr)
		end
		package.loaded.gitsigns.toggle_current_line_blame()
		vim.g.last_current_bufnr = nil
	end
}

M.neotest = {
	summary = function() require('neotest').summary.toggle() end,
	closest = function()
		require('neotest').run.run()
		require('neotest').summary.open()
	end,
	all     = function()
		require('neotest').run.run(vim.fn.getcwd())
		require('neotest').summary.open()
	end,
	file    = function()
		require('neotest').run.run(vim.fn.expand("%"))
		require('neotest').summary.open()
	end,
}

M.nvim_tree = {
	open = function()
		require 'nvim-tree'
		vim.cmd ':NvimTreeFindFile\n'
	end,
	rename_file = function() require('snacks').rename.rename_file() end

}

M.nvim_ufo = {
	open_all_folds    = function() require('ufo').openAllFolds() end,
	close_all_folds   = function() require('ufo').closeAllFolds() end,
	foldcolumn_1      = ':bufdo set foldcolumn=1\n',
	foldcolumn_auto_9 = ':bufdo set foldcolumn=auto:9\n',
	foldcolumn_0      = ':bufdo set foldcolumn=0\n',
}

M.possession = {
	list_sessions = ':Telescope possession list\n',
	save_session  = function()
		local curr_session_name = require 'possession.session'.get_session_name()
		if curr_session_name then
			require 'possession'.save(curr_session_name);
		else
			vim.ui.input({ prompt = 'Enter name for new session: ' }, function(input)
				require 'possession'.save(input)
			end)
		end
	end,
	print_current = function()
		local curr_session_name = require 'possession.session'.get_session_name()
		if curr_session_name then
			vim.notify('Current session: ' .. curr_session_name)
		else
			vim.notify('Currently not in a session', vim.log.levels.WARN)
		end
	end,
}

M.todo_comments = { open_list = ':TodoTelescope\n' }

M.trouble = { toggle = ':Trouble\n', diagnostics = ':Trouble diagnostics\n' }

M.which_key = { show_local = function() require 'which-key'.show({ global = false }) end }

M.yanky = { show_and_paste = ':Telescope yank_history\n' }

return M
