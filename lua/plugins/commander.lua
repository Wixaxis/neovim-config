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
  commander = require 'configs.mappings'.commander,
}
