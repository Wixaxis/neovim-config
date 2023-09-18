return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  enabled = require 'configs.plugs'.bufferline,
  opts = {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "Nvim Tree",
          separator = true,
          text_align = "left"
        }
      },
    }
  },
}
