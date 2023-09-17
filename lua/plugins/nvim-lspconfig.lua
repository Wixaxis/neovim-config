return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
    { 'folke/neodev.nvim',       config = true },
    'williamboman/mason-lspconfig.nvim',
  },
  enabled = require 'configs.plugs'.nvim_lspconfig
}
