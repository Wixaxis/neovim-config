-- Manages and installs language servers for code intelligence
return {
  { 'mason-org/mason.nvim', lazy = false, config = true },
  { 'mason-org/mason-lspconfig.nvim', lazy = false, config = true },
  'neovim/nvim-lspconfig',
}
