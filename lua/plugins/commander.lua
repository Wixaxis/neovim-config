return {
  "FeiyouG/commander.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    components = { 'KEYS', 'DESC', 'CAT' },
    integration = {
      telescope = { enable = true },
      lazy = { enable = true }
    }
  },
  commander = { {
    keys = { { 'n', 'v' }, '<leader><leader>', { desc = 'Commander' } },
    cmd = require 'utils'.commander,
    desc = 'open commander'
  } },
}
