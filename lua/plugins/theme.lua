local set_theme_if_default = function(name)
  return function()
    if require 'defaults'.theme ~= name then return; end
    vim.cmd.colorscheme(name)
  end
end

-- TODO: expand themes list, maybe some compiled collection of themes?
return {
  {
    'navarasu/onedark.nvim',
    config = set_theme_if_default('onedark'),
  },
  {
    'rmehri01/onenord.nvim',
    config = set_theme_if_default('onenord'),
  },
}
