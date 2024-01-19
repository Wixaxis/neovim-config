return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end,
  lazy = true,
  cmd = 'LazyGit',
  commander = { {
    keys = { 'n', '<leader>lg', { desc = 'Open [L]azy [G]it' } },
    cmd = function()
      require 'lazygit'
      vim.cmd ':LazyGit\n'
    end,
    desc = 'open lazygit'
  } },
}
