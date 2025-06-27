-- Shows open files as tabs at the top of the window
return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        groups = {
          items = {
            require('bufferline').groups.builtin.pinned:with { icon = '󰐃' },
          },
        },
        offsets = { {
          filetype = 'NvimTree',
          text = 'Nvim Tree',
          separator = true,
          text_align = 'left',
        } },
        indicator = { style = 'underline' },
        diagnostics = 'nvim_lsp',
        separator_style = 'slope',
        close_command = function(bufnr) require('snacks').bufdelete.delete(bufnr) end,
        right_mouse_command = function(bufnr) require('snacks').bufdelete.delete(bufnr) end,
      },
    }
  end,
  event = 'BufEnter *.*',
  keys = require('configs.mappings').bufferline,
}
