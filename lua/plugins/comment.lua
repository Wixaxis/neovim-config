return {
  'numToStr/Comment.nvim',
  config = function()
    --- @diagnostic disable-next-line: missing-fields
    require 'Comment'.setup { mappings = false }
    require 'Comment.ft'.set('hyprlang', '#%s')
  end,
  lazy = true,
  commander = require 'configs.mappings'.comment,
}
