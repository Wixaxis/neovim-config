return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = { ui = { border = 'rounded' } },
    },
    { 'j-hui/fidget.nvim',    opts = {} },
    'williamboman/mason-lspconfig.nvim',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = { library = { "luvit-meta/library" } },
    },
    { "Bilal2453/luvit-meta", lazy = true },
  },
}
