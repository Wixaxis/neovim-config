-- Renders Markdown files with syntax highlighting and formatting
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    enabled = true,
  },
  ft = { 'markdown' },
  init = function()
    -- Associate .mdc files with markdown filetype
    vim.filetype.add {
      extension = {
        mdc = 'markdown',
      },
    }
  end,
}
