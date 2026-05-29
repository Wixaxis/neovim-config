-- TODO(pack): safe to move to vim.pack now
-- Shows available keybindings when you press the leader key
return {
  'folke/which-key.nvim',
  lazy = false,
  opts = { preset = 'helix' },
  keys = require('configs.mappings').which_key,
}
