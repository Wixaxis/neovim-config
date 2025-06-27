-- Provides various UI enhancements like dashboard, file explorer, and input helpers
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = require 'configs.snacks.dashboard',
    bigfile   = { enabled = true },
    indent    = require 'configs.snacks.indent',
    input     = { enabled = true },
    notifier  = {
      enabled = true,
      style   = 'minimal',
    },
    lazygit   = { enabled = true },
    picker    = { enabled = true },
    explorer  = { enabled = true },
    dim       = { enabled = true },
    -- quickfile    = { enabled = true },
    -- scroll       = { enabled = true },
    -- statuscolumn = { enabled = true },
    words     = { enabled = true },
  },
  keys = require 'configs.mappings'.snacks,
}
