return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  commander = require 'configs.mappings'.todo_comments,
}
