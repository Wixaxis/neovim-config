-- TODO(pack): safe to move to vim.pack now
-- Manages LSP servers and loads upstream server definitions
return {
  { 'mason-org/mason.nvim', lazy = false, config = true },
  'neovim/nvim-lspconfig',
}
