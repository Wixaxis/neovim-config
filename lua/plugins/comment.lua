return {
  'numToStr/Comment.nvim',
  opts = { mappings = false },
  lazy = true,
  commander = {
    {
      keys = { 'n', '<leader>/' },
      cmd = function()
        require 'Comment'
        require "Comment.api".toggle.linewise.current()
      end,
      desc = 'Toggle comment'
    },
    {
      keys = { 'v', '<leader>/' },
      cmd =  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = 'Toggle comment'
    },
  },
}
