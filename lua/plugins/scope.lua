return {
  "tiagovla/scope.nvim",
  enabled = require 'configs.plugs'.scope,
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require 'scope'.setup {}
    require 'telescope'.load_extension 'scope'
  end,
}
