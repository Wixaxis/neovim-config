-- Shows a breadcrumb navigation bar at the top of the window
return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {"SmiteshP/nvim-navic","nvim-tree/nvim-web-devicons"  },
  opts = {},
  event = 'BufEnter *.*',
  keys = require 'configs.mappings'.barbecue,
}
