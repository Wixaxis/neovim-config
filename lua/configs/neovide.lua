local M = {}

local neovide = require 'utils'.neovide
local sys_name = require 'utils'.sys_name
local defaults = require 'defaults'.neovide

local sys_defaults = {}
if sys_name == 'Linux' then
  sys_defaults = defaults.linux
elseif sys_name == 'Darwin' then
  sys_defaults = defaults.mac
else
  sys_defaults = defaults.windows
end

M.set_defaults = function()
  neovide.set_cursor(sys_defaults.cursor or defaults.cursor or 'railgun')
  local def_font = sys_defaults.font or defaults.font or 'FiraCode Nerd Font Mono'
  local def_font_size = sys_defaults.font_size or defaults.font_size or '12'
  neovide.set_font(def_font .. ':h' .. def_font_size)
  neovide.set_scale(sys_defaults.scale or defaults.scale or 1)
  neovide.set_transparency(sys_defaults.transparency or defaults.transparency or 1)
  neovide.set_macos_option_key_is_meta(sys_defaults.option_key_is_meta)
  neovide.set_float_win_blur(sys_defaults.float_win_blur or defaults.float_win_blur or 2.0)
  vim.notify('Loaded neovide config for ' .. sys_name)
end

M.commands = {
  { cmd = neovide.scale_up,   desc = 'neovide -> scale up' },
  { cmd = neovide.scale_down, desc = 'neovide -> scale down' },
  { cmd = M.set_defaults,     desc = 'neovide -> reset all settings' },
  {
    cmd = function()
      neovide.set_scale(sys_defaults.scale or defaults.scale or 1)
    end,
    desc = 'neovide -> scale reset'
  },
}

M.set_defaults()

require 'commander'.add(M.commands, {})

neovide.set_colorscheme_autocmd()

return M
