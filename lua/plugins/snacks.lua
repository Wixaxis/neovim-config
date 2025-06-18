return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = require 'configs.snacks.dashboard',
    bigfile = { enabled = true },
    indent = require 'configs.snacks.indent',
    input = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    -- quickfile = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
}
