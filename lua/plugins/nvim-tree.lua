-- TODO: Consider replacing with telescope file browser? (not find_file telescope builtin)
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

  },
}
