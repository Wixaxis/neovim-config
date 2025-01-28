return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
  },
  opts = {
    defaults = {
      wrap_results = true,
      -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false } },
    },
    extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown() } },
  },
  commander = require 'configs.mappings'.telescope,
}
