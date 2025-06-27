-- Provides a better yank history and paste functionality
return {
  'gbprod/yanky.nvim',
  opts = true,
  dependencies = { 'folke/snacks.nvim' },
  keys = require('configs.mappings').yanky,
}
