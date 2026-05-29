-- TODO(pack): safe to move to vim.pack now
-- Creates a status line at the bottom of the window with file info, Git status, and time
local diagnostic_status = function() return vim.diagnostic.status() end
local progress_status = function() return vim.ui.progress_status() end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = 'archibate/lualine-time',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_z = { 'cdate', 'ctime' },
      lualine_x = {
        {
          diagnostic_status,
          cond = function() return diagnostic_status() ~= '' end,
        },
        {
          progress_status,
          cond = function() return progress_status() ~= '' end,
          color = { fg = '#ff9e64' },
        },
        { 'searchcount' },
      },
    },
  },
}
