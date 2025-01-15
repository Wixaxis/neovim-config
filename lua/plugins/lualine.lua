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
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9966" }
        }
      },
    },
  },
}
