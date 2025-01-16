return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = require 'configs.snacks.dashboard',
    bigfile = { enabled = true },
    indent = require 'configs.snacks.indent',
  },
}
