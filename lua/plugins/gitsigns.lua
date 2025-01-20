return {
  'lewis6991/gitsigns.nvim',
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
      vim.keymap.set('n', '<leader>gp', function() require('gitsigns').nav_hunk('prev') end,
        { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
      vim.keymap.set('n', '<leader>hn', function() require('gitsigns').nav_hunk('next') end,
        { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },
  commander = {
    {
      cmd = function()
        if vim.api.nvim_buf_is_valid(vim.g.last_current_bufnr) then
          vim.api.nvim_set_current_buf(vim.g.last_current_bufnr)
        end
        package.loaded.gitsigns.toggle_current_line_blame()
        vim.g.last_current_bufnr = nil
      end,
      desc = 'gitsigns - current line blame toggle'
    },
  },
}

-- TODO: Consider getting rid of this plugin with Snacks.nvim
