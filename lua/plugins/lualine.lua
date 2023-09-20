-- TODO: Maybe add a clock bottom-right instead of curr position in document?
return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = require 'configs.plugs'.theme,
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
  },
  enabled = require 'configs.plugs'.lualine
}
