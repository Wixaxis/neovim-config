local system = vim.loop.os_uname().sysname

-- TODO: Make it re-runnable function, to be called as reset live changes
if system == 'Linux' then
  vim.o.guifont = "FiraCode Nerd Font Mono:h9"
  vim.g.neovide_scale_factor = 0.7
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 1
  vim.notify 'Loaded Linux Neovide config'
elseif system == 'Darwin' then
  vim.o.guifont = "FiraCode Nerd Font Mono:h14"
  vim.g.neovide_scale_factor = 0.9
  vim.g.neovide_input_macos_alt_is_meta = true -- TODO: doesn't work :/
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.9
  -- vim.g.neovide_background_color = "#000000" .. string.format("%x", math.floor((255 * (vim.g.transparency or 0.8))))
  -- TODO: read current background color from current theme
  vim.g.neovide_background_color = "#000000" .. string.format("%x", math.floor(255 * 0.1))
  vim.notify 'Loaded MacOS Neovide config'
end

-- TODO: make keymaps for changing scale, font-size, transparency, reload_color_from_theme
