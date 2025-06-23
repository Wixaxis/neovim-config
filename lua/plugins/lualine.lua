-- Creates a status line at the bottom of the window with file info, Git status, and time
return {
  'nvim-lualine/lualine.nvim',
  dependencies = 'archibate/lualine-time',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_z = { 'cdate', 'ctime' },
      lualine_x = {
        {
          require("noice").api.status.message.get_hl,
          cond = require("noice").api.status.message.has,
        },
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
      },
    },
  },
}
