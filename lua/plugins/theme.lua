-- require 'utils'.set_default_colorscheme()
vim.g.neon_style = "dark" -- default | doom | dark | light

require 'commander'.add({ {
  keys = { 'n', '<leader>th', { desc = 'Change [t][h]eme' } },
  cmd = ':Telescope colorscheme\n',
  desc = 'change theme | pick colorscheme | telescope -> colorscheme'
} }, {})

return {
  'navarasu/onedark.nvim',
  'rmehri01/onenord.nvim',
  'AlexvZyl/nordic.nvim',
  'shaunsingh/nord.nvim',
  'rafamadriz/neon',
  'folke/tokyonight.nvim',
  'bluz71/vim-nightfly-colors',
  'catppuccin/nvim',
  'rebelot/kanagawa.nvim',
  'ellisonleao/gruvbox.nvim',
  'rose-pine/neovim',
  'nyoom-engineering/oxocarbon.nvim',
  'olimorris/onedarkpro.nvim',
  'tiagovla/tokyodark.nvim',
}
