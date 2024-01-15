-- NOTE: Consider replacing with telescope file browser? (not find_file telescope builtin)
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    disable_netrw = true,
    filters = { git_ignored = false },
    select_prompts = true,
    view = {
      width = {},
      float = {
        enable = true,
        open_win_config = {
          height = 40,
        }
      }
    },
  },
  commander = { {
    keys = { 'n', '<leader>e' },
    cmd = function()
      require 'nvim-tree'
      vim.cmd ':NvimTreeFindFile\n'
    end,
    desc = 'Fil[e] tree'
  } },
}
