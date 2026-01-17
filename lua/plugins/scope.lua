-- Manages buffer scopes for better window and tab management
-- Must load before resession.nvim for extension support
return {
  'tiagovla/scope.nvim',
  lazy = false, -- Load immediately so resession can use it
  opts = true,
}
