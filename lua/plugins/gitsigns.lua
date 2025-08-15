-- Shows Git changes in the gutter and provides Git blame information
return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text_pos = 'right_align',
      delay = 100,
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gp', function() require('gitsigns').nav_hunk 'prev' end, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
      vim.keymap.set('n', '<leader>hn', function() require('gitsigns').nav_hunk 'next' end, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },
  keys = require('configs.mappings').gitsigns,
}

-- TODO: fix the mappings and cleanup, why assign part on attach, and part globally?
