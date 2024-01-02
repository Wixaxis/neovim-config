local M = {}

local sys_name = vim.loop.os_uname().sysname

M.set_font = function(font_str) vim.o.guifont = font_str end -- TODO: write font selector from available fonts

M.set_scale = function(scale) vim.g.neovide_scale_factor = scale end

M.scale_up = function() M.set_scale(vim.g.neovide_scale_factor + 0.1) end   -- TODO: set keybinding

M.scale_down = function() M.set_scale(vim.g.neovide_scale_factor - 0.1) end -- TODO: set keybinding

M.set_cursor = function(cursor) vim.g.neovide_cursor_vfx_mode = cursor end

M.set_transparency = function(opacity)
	if sys_name == 'Darwin' then
		vim.g.neovide_transparency = 0
		vim.g.transparency = opacity
		local bg_color = string.sub(vim.api.nvim_cmd(
			{ cmd = 'hi', args = { 'normal' } },
			{ output = true }), -7, -1)
		vim.g.neovide_background_color = bg_color .. string.format("%x", math.floor(255 * opacity))
	elseif sys_name == 'Linux' then
		vim.g.neovide_transparency = opacity
		vim.g.transparency = 1
	end
end

M.get_transparency = function()
	if sys_name == 'Darwin' then return vim.g.transparency; end
	if sys_name == 'Linux' then return vim.g.neovide_transparency; end
	return 1
end

M.set_macos_alt_is_meta = function(mode)
	if sys_name ~= 'Darwin' or mode == nil then return; end

	if mode == 'auto' then
		vim.api.nvim_create_autocmd('InsertEnter', {
			callback = function()
				vim.g.neovide_input_macos_alt_is_meta = false
			end,
			pattern = '*',
		})
		vim.api.nvim_create_autocmd('InsertLeave', {
			callback = function()
				vim.g.neovide_input_macos_alt_is_meta = true
			end,
			pattern = '*',
		})
		vim.g.neovide_input_macos_alt_is_meta = true
	else
		vim.g.neovide_input_macos_alt_is_meta = mode
	end
end

M.set_colorscheme_autocmd = function()
	if sys_name ~= 'Darwin' then return; end
	vim.api.nvim_create_autocmd('Colorscheme', {
		callback = function()
			M.set_transparency(M.get_transparency())
		end,
	})
end

M.set_float_win_blur = function(blur_amount)
	vim.g.neovide_floating_blur_amount_x = blur_amount
	vim.g.neovide_floating_blur_amount_y = blur_amount
end

return M
