return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {"SmiteshP/nvim-navic","nvim-tree/nvim-web-devicons"  },
  opts = {},
  event = 'BufEnter *.*',
  commander = require 'configs.mappings'.barbecue,
}
