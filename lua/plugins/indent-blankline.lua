return {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    char = '|',
    show_trailing_blankline_indent = false,
  },
  enabled = require 'configs.plugs'.indent_blankline
}
