local set_theme = function(name)
  return function()
    if require 'configs.plugs'.theme == name then
      vim.cmd.colorscheme(name)
    end
  end
end

return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = set_theme('onedark'),
  },
  {
    'rmehri01/onenord.nvim',
    priority = 1000,
    config = set_theme('onenord'),
  },
}
