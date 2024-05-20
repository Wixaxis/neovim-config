local M = {}

local sys_name = vim.loop.os_uname().sysname

M.set_font = function(font_str) vim.o.guifont = font_str end

M.set_scale = function(scale) vim.g.neovide_scale_factor = scale end

M.scale_up = function() M.set_scale(vim.g.neovide_scale_factor + 0.1) end

M.scale_down = function() M.set_scale(vim.g.neovide_scale_factor - 0.1) end

M.set_cursor = function(cursor) vim.g.neovide_cursor_vfx_mode = cursor end

M.set_transparency = function(opacity)
	vim.g.neovide_transparency = opacity
	vim.g.transparency = 0.5
end

M.get_transparency = function()
	return vim.g.neovide_transparency
end

M.set_macos_option_key_is_meta = function(mode)
	if sys_name ~= 'Darwin' or mode == nil then return; end

	if mode == 'auto' then
		vim.api.nvim_create_autocmd('InsertEnter', {
			callback = function()
				vim.g.neovide_input_macos_option_key_is_meta = 'none'
			end,
			pattern = '*',
		})
		vim.api.nvim_create_autocmd('InsertLeave', {
			callback = function()
				vim.g.neovide_input_macos_option_key_is_meta = 'both'
			end,
			pattern = '*',
		})
		vim.g.neovide_input_macos_option_key_is_meta = 'both'
	else
		vim.g.neovide_input_macos_option_key_is_meta = mode
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
	vim.g.neovide_window_blurred = blur_amount ~= 0.0
	vim.g.neovide_floating_blur_amount_x = blur_amount
	vim.g.neovide_floating_blur_amount_y = blur_amount
end

return M
