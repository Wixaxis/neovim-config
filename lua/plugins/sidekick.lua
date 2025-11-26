return {
  'folke/sidekick.nvim',
  lazy = false,
  opts = {
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
    },
  },
  keys = require('configs.mappings').sidekick,
}
