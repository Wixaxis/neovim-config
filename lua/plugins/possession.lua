return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require 'possession'.setup {}
    require 'telescope'.load_extension('possession')
  end,
}
