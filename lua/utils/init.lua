local M = {}

M.neovide = require 'utils.neovide'

M.ensure_lazy_installed = function()
	local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
	local install_script = { 'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
	if not vim.loop.fs_stat(lazypath) then vim.fn.system(install_script) end
	vim.opt.rtp:prepend(lazypath)
end

M.wksp_list_folders = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end

M.format_current_buffer = function() vim.lsp.buf.format { async = true } end

M.commander = function()
	vim.g.last_current_bufnr = vim.api.nvim_get_current_buf()
	require 'commander'.show({})
end

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

return M
