CURR_HOUR = tonumber(os.date("%H"))
IS_BRIGHT = (CURR_HOUR < 19) and (CURR_HOUR > 7)
LIGHT_THEME = 'onenord-light'
DARK_THEME = 'onenord'
return {
	theme = IS_BRIGHT and LIGHT_THEME or DARK_THEME,
	neovide = {
		-- every setting can be put both on system specific and general levels
		-- system specific settings take precedence over general
		font = 'FiraCode Nerd Font Mono',
		font_size = '12',
		scale = 1,
		transparency = 1,
		cursor = 'railgun',
		float_win_blur = 10.0, -- amount of blur for floating windows inside neovim
		linux = {
			font_size = '12',
			scale = 1,
			transparency = 0.9,
		},
		mac = {
			font_size = '14',
			scale = 0.9,
			transparency = 0.9,
			alt_is_meta = 'auto' -- only mac specific
		},
		windows = {},
	},
}
