local system = vim.loop.os_uname().sysname

local M = {}

M.set_font = function(font_str) vim.o.guifont = font_str end

M.set_scale = function(scale) vim.g.neovide_scale_factor = scale end

M.set_transparency = function(opacity)
  if system == 'Darwin' then
    vim.g.neovide_transparency = 0
    vim.g.transparency = opacity
    local bg_color = string.sub(vim.api.nvim_cmd({ cmd = 'hi', args = { 'normal' } }, { output = true }), -7, -1)
    vim.g.neovide_background_color = bg_color .. string.format("%x", math.floor(255 * opacity))
  elseif system == 'Linux' then
    vim.g.neovide_transparency = opacity
    vim.g.transparency = 1
  end
end

M.set_defaults = function()
  vim.g.neovide_cursor_vfx_mode = "railgun"
  if system == 'Linux' then
    M.set_font "FiraCode Nerd Font Mono:h9"
    M.set_scale(1)
    M.set_transparency(0.9)
    vim.notify 'Loaded Linux Neovide config'
  elseif system == 'Darwin' then
    M.set_font "FiraCode Nerd Font Mono:h14"
    M.set_scale(0.9)
    M.set_transparency(0.9)
    vim.g.neovide_input_macos_alt_is_meta = true
    vim.notify 'Loaded MacOS Neovide config'
  end
end

return M
