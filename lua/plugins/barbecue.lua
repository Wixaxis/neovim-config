return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {},
  event = 'BufEnter *.*',
  commander = {
    {
      cmd = function()
        require 'barbecue.ui'.toggle()
        vim.notify('barbecue.nvim toggled')
      end,
      desc = 'barbecue - toggle (winbar)'
    },
  },
}
