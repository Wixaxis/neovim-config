return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  commander = { {
    keys = { 'n', '<leader>td', { desc = 'List [t]o[d]o tags in project' } },
    cmd = ':TodoTelescope\n',
    desc = 'open list of todos in project'
  } },
}
