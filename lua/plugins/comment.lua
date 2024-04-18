return {
  'numToStr/Comment.nvim',
  config = function()
    require 'Comment'.setup { mappings = false }
    require 'Comment.ft'.set('hyprlang', '#%s')
  end,
  lazy = true,
  commander = {
    {
      keys = { 'n', '<leader>/', { desc = 'Toggle comment' } },
      cmd = function()
        require 'Comment'
        require "Comment.api".toggle.linewise.current()
      end,
      desc = 'comment / uncomment current line'
    },
    {
      keys = { 'v', '<leader>/', { desc = 'Toggle comment' } },
      cmd = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = 'comment / uncomment selected lines'
    },
  },
}
