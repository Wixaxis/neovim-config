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

return M
