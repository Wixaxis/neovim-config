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
      vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
        { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
      vim.keymap.set('n', '<leader>hn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },
  commander = {
    {
      cmd = function()
        -- TODO: Doesnt work, toggle current line blame needs a bufnr to be passed :(
        package.loaded.gitsigns.toggle_current_line_blame()
      end,
      desc = 'gitsigns - current line blame toggle'
    },
  },
}
