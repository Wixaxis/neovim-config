vim.o.guifont = "FiraCode Nerd Font Mono:h9"
vim.g.neovide_scale_factor = 0.7

vim.g.neovide_input_macos_alt_is_meta = false
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end

local system = vim.loop.os_uname().sysname

if system == 'Linux' then
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 1
elseif system == 'Darwin' then
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
end
