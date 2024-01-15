return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  commander = { {
    keys = { 'n', '<leader>td' },
    cmd = ':TodoTelescope\n',
    desc = 'List [t]o[d]o tags in project'
  } },
}
