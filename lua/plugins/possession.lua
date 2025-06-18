return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = true,
  lazy = false,
  keys = require 'configs.mappings'.possession,
}
