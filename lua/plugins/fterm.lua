return {
  "numToStr/FTerm.nvim",
  opts = { border = 'rounded' },
  lazy = true,
  commander = { { -- TODO: expand terminals support (create, search/select, remove, notify, send, move)
    keys = { { 'n', 't' }, '<A-t>' },
    cmd = function() require 'FTerm'.toggle() end,
    desc = 'Toggle floating terminal'
  } },
}
