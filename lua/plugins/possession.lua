return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require 'possession'.setup {}
    require 'telescope'.load_extension('possession')
  end,
  commander = {
    {
      keys = { 'n', '<leader>sl', { desc = '[S]essions - [l]ist' } },
      cmd = ':Telescope possession list\n',
      desc = 'open saved sessions & load picked'
    }, -- TODO: expand session management (delete, rename)
    {
      keys = { 'n', '<leader>ss', { desc = '[S]essions - [s]ave current' } },
      cmd = function()
        local curr_session_name = require 'possession.session'.session_name
        if curr_session_name then
          require 'possession'.save(curr_session_name);
        else
          vim.ui.input({ prompt = 'Enter name for new session: ' }, function(input)
            require 'possession'.save(input)
          end)
        end
      end,
      desc = 'save current session'
    },
    {
      keys = { 'n', '<leader>sp', { desc = '[S]essions - [p]rint current session name' } },
      cmd = function()
        local curr_session_name = require 'possession.session'.session_name
        if curr_session_name then
          vim.notify('Current session: ' .. curr_session_name)
        else
          vim.notify('Currently not in a session', vim.log.levels.WARN)
        end
      end,
      desc = 'print name of current session'
    },
  },
}
