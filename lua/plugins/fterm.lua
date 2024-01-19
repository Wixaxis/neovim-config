return {
  "numToStr/FTerm.nvim",
  opts = { border = 'rounded' },
  lazy = true,
  commander = { { -- TODO: expand terminals support (create, search/select, remove, notify, send, move)
    keys = { { 'n', 't' }, '<A-t>', { desc = 'Toggle floating terminal' } },
    cmd = function() require 'FTerm'.toggle() end,
    desc = 'open / close floating terminal'
  } },
}
