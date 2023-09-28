return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = { ui = { border = 'rounded' } },
    },
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    { 'folke/neodev.nvim', config = true, ft = 'lua' },
    'williamboman/mason-lspconfig.nvim',
  },
}
