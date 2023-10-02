local M = {}

M.ensure_lazy_installed = function()
	local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
	local install_script = { 'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
	if not vim.loop.fs_stat(lazypath) then vim.fn.system(install_script) end
	vim.opt.rtp:prepend(lazypath)
end

M.cmp = {}

M.cmp.confirm_mapping = function(cmp)
	return cmp.mapping.confirm {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	}
end

M.cmp.next_item = function(cmp, luasnip)
	return cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { 'i', 's' })
end

M.cmp.prev_item = function(cmp, luasnip)
	return cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.locally_jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { 'i', 's' })
end

M.infile_search = function()
	require 'telescope.builtin'.current_buffer_fuzzy_find(require 'telescope.themes'.get_dropdown {
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
		vim.keymap.set(v[1], v[2], v[3], v[4])
	end
end

M.str_split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
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
	vim.notify('Setting theme to ' .. default_theme)
	vim.cmd.colorscheme(default_theme)
end

M.sys_name = vim.loop.os_uname().sysname

M.neovide = {}

M.neovide.set_font = function(font_str) vim.o.guifont = font_str end -- TODO: write font selector from available fonts

M.neovide.set_scale = function(scale) vim.g.neovide_scale_factor = scale end

M.neovide.scale_up = function() M.set_scale(vim.g.neovide_scale_factor + 0.1) end   -- TODO: set keybinding

M.neovide.scale_down = function() M.set_scale(vim.g.neovide_scale_factor - 0.1) end -- TODO: set keybinding

M.neovide.set_cursor = function(cursor) vim.g.neovide_cursor_vfx_mode = cursor end

M.neovide.set_transparency = function(opacity)
	if M.sys_name == 'Darwin' then
		vim.g.neovide_transparency = 0
		vim.g.transparency = opacity
		local bg_color = string.sub(vim.api.nvim_cmd(
			{ cmd = 'hi', args = { 'normal' } },
			{ output = true }), -7, -1)
		vim.g.neovide_background_color = bg_color .. string.format("%x", math.floor(255 * opacity))
	elseif M.sys_name == 'Linux' then
		vim.g.neovide_transparency = opacity
		vim.g.transparency = 1
	end
end

return M
