local system = vim.loop.os_uname().sysname

-- TODO: Make it re-runnable function, to be called as reset live changes
local M = {}

M.set_font = function(font_str) vim.o.guifont = font_str end

M.set_scale = function(scale) vim.g.neovide_scale_factor = scale end

M.set_defaults = function()
  vim.g.neovide_cursor_vfx_mode = "railgun"
  if system == 'Linux' then
    M.set_font "FiraCode Nerd Font Mono:h9"
    vim.g.neovide_scale_factor = 0.7
    vim.g.neovide_transparency = 0.9
    vim.g.transparency = 1
    vim.notify 'Loaded Linux Neovide config'
  elseif system == 'Darwin' then
    M.set_font "FiraCode Nerd Font Mono:h14"
    vim.g.neovide_scale_factor = 0.9
    vim.g.neovide_input_macos_alt_is_meta = true
    vim.g.neovide_transparency = 0
    vim.g.transparency = 0.9
    local bg_color = string.sub(vim.api.nvim_cmd({ cmd = 'hi', args = { 'normal' } }, { output = true }), -7, -1)
    vim.g.neovide_background_color = bg_color .. string.format("%x", math.floor((255 * (vim.g.transparency or 0.8))))
    vim.notify 'Loaded MacOS Neovide config'
  end
end

return M

-- TODO: make keymaps for changing scale, font-size, transparency, reload_color_from_theme
