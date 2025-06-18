return {
  "gbprod/yanky.nvim",
  opts = true,
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>p",
      function()
          Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  }
}
