local M = {}

M.cmp = require 'utils.cmp'

M.neovide = require 'utils.neovide'

M.ensure_lazy_installed = function()
	local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
	local install_script = { 'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
	if not vim.loop.fs_stat(lazypath) then vim.fn.system(install_script) end
	vim.opt.rtp:prepend(lazypath)
end

M.infile_search = function()
	require 'telescope.builtin'.current_buffer_fuzzy_find(
		require 'telescope.themes'.get_dropdown {
			winblend = 10,
			previewer = false,
		})
end

M.wksp_list_folders = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end

M.toggle_comment_normal = function()
	require 'Comment'
	require "Comment.api".toggle.linewise.current()
end

M.toggle_comment_visual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"

M.find_all = ':Telescope find_files follow=true no_ignore=true hidden=true\n'

M.format_current_buffer = function() vim.lsp.buf.format { async = true } end

M.floating_terminal = function() require 'FTerm'.toggle() end

M.commander = function() require 'commander'.show() end

M.lazygit = function()
	require 'lazygit'
	vim.cmd ':LazyGit\n'
end

M.focus_tree = function()
	require 'nvim-tree'
	vim.cmd ':NvimTreeFindFile\n'
end

M.save_session = function()
	local curr_session_name = require 'possession.session'.session_name
	if curr_session_name then
		require 'possession'.save(curr_session_name);
	else
		vim.ui.input({ prompt = 'Enter name for new session: ' }, function(input)
			require 'possession'.save(input)
		end)
	end
end

M.print_session = function()
	local curr_session_name = require 'possession.session'.session_name
	if curr_session_name then
		vim.notify('Current session: ' .. curr_session_name)
	else
		vim.notify('Currently not in a session', vim.log.levels.WARN)
	end
end

M.set_keymaps_table = function(keymaps_table)
	for _, v in ipairs(keymaps_table) do
		require('commander').add({ {
			desc = v[4].desc,
			cmd = v[3],
			keys = { v[1], v[2] }
		} }, {})
		-- old way of setting before commander
		-- vim.keymap.set(v[1], v[2], v[3], v[4])
	end
end

M.str_split = function(inputstr, sep)
	if sep == nil then sep = "%s"; end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

M.set_default_colorscheme = function()
	local default_theme = require 'defaults'.theme
	local current_theme = vim.cmd.colorscheme()
	if current_theme == default_theme then
		vim.notify('Theme [' .. current_theme .. '] already set, omitting...')
		return
	end
	vim.notify('Set theme to ' .. default_theme)
	vim.cmd.colorscheme(default_theme)
end

M.sys_name = vim.loop.os_uname().sysname

return M
