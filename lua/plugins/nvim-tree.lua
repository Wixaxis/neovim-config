local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    disable_netrw = true,
    filters = { git_ignored = false },
    select_prompts = true,
    view = {
      width = {},
      float = {
        -- enable = true,
        enable = false,
        open_win_config = {
          height = 40,
        }
      }
    },
  },
  commander = { {
    keys = { 'n', '<leader>e', { desc = 'Fil[e] tree' } },
    cmd = function()
      require 'nvim-tree'
      vim.cmd ':NvimTreeFindFile\n'
    end,
    desc = 'open file tree & focus on current file'
  } },
}
