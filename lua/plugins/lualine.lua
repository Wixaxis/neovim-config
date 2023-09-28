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
    },
  },
}
