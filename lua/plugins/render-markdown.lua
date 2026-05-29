-- TODO(pack): maybe later
-- Renders Markdown files with syntax highlighting and formatting
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  config = function()
    local view = require 'render-markdown.request.view'

    -- Neovim 0.12 is currently unhappy in markdown injection parsing paths.
    -- render-markdown only needs the markdown tree for its own rendering, so
    -- we intentionally avoid injected-language parsing here.
    function view:parse(parser, callback)
      parser:parse(false)
      callback()
    end

    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    require('render-markdown').setup {
      enabled = true,
    }
  end,
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
