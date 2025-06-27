-- Saves and restores your Neovim session state between restarts
return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = true,
  lazy = false,
  keys = require('configs.mappings').possession,
}
