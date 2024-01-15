return {
  "FeiyouG/commander.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    components = { 'KEYS', 'DESC', 'CAT', 'CMD' },
    integration = {
      telescope = { enable = true },
      lazy = { enable = true }
    }
  },
  commander = { {
    keys = { 'n', '<leader><leader>' },
    cmd = require 'utils'.commander,
    desc = 'Commander'
  } },
}
