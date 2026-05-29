-- TODO(pack): safe to move to vim.pack now
-- Highlights and searches for TODO, FIXME, and other comment keywords
return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = true,
}
