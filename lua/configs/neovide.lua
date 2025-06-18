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

-- TODO: split into definitions here, and call actual creation somewhere else
M.create_commands = function()
  vim.api.nvim_create_user_command('NeovideScaleUp', function()
    neovide.scale_up()
    vim.notify('Neovide scale increased to ' .. vim.g.neovide_scale_factor)
  end, { desc = 'Increase Neovide scale' })

  vim.api.nvim_create_user_command('NeovideScaleDown', function()
    neovide.scale_down()
    vim.notify('Neovide scale decreased to ' .. vim.g.neovide_scale_factor)
  end, { desc = 'Decrease Neovide scale' })

  vim.api.nvim_create_user_command('NeovideResetSettings', function()
    M.set_defaults()
  end, { desc = 'Reset all Neovide settings to defaults' })

  vim.api.nvim_create_user_command('NeovideResetScale', function()
    local default_scale = sys_defaults.scale or defaults.scale or 1
    neovide.set_scale(default_scale)
    vim.notify('Neovide scale reset to ' .. default_scale)
  end, { desc = 'Reset Neovide scale to default' })
end

M.set_defaults()

neovide.set_colorscheme_autocmd()

return M
