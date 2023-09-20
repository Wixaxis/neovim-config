-- TODO: If this function is even necessary, move to utils
local set_theme = function(name)
  return function()
    -- TODO: rethink how themes are set on startup, maybe the .env file idea?
    if require 'configs.plugs'.theme == name then
      vim.cmd.colorscheme(name)
    end
  end
end

-- TODO: expand themes list, maybe some compiled collection of themes?
return {
  {
    'navarasu/onedark.nvim',
    config = set_theme('onedark'),
  },
  {
    'rmehri01/onenord.nvim',
    config = set_theme('onenord'),
  },
}
