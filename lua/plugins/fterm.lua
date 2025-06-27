-- Provides a floating terminal window inside Neovim
return {
  'numToStr/FTerm.nvim',
  opts = { border = 'rounded' },
  lazy = true,
  keys = require('configs.mappings').fterm,
}
