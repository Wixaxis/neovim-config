-- TODO(pack): safe to move to vim.pack now
-- Provides better syntax highlighting and code parsing
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
}
