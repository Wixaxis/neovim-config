local tel_bltn = require 'telescope.builtin'

local infile_search = function()
  require 'telescope.builtin'.current_buffer_fuzzy_find(
    require 'telescope.themes'.get_dropdown {
      winblend = 10,
      previewer = false,
    })
end

local find_all = ':Telescope find_files follow=true no_ignore=true hidden=true\n'

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = {
    defaults = {
      wrap_results = true,
      -- border = false,
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  },
  commander = {
    { keys = { 'n', '<leader>fo', { desc = '[F]ind [o]ldfiles' } },           cmd = tel_bltn.oldfiles,    desc = 'telescope -> oldfiles | find previously opened files' },
    { keys = { 'n', '<leader>fb', { desc = '[F]ind [b]uffer' } },             cmd = tel_bltn.buffers,     desc = 'telescope -> buffers | find opened buffer' },
    { keys = { 'n', '<leader>fcf', { desc = '[F]ind in [c]urrent [f]ile' } }, cmd = infile_search,        desc = 'telescope -> infile_search | find words in current file' },
    { keys = { 'n', '<leader>fg', { desc = '[F]ind [g]it files' } },          cmd = tel_bltn.git_files,   desc = 'telescope -> git_files | find files tracked by git' },
    { keys = { 'n', '<leader>ff', { desc = '[F]ind [f]ile' } },               cmd = tel_bltn.find_files,  desc = 'telescope -> find_files | find file' },
    { keys = { 'n', '<leader>fa', { desc = '[F]ind [a]ll' } },                cmd = find_all,             desc = 'telescope -> find_all | find all possible files' },
    { keys = { 'n', '<leader>fh', { desc = '[F]ind [h]elp' } },               cmd = tel_bltn.help_tags,   desc = 'telescope -> help_tags | find help in manual' },
    { keys = { 'n', '<leader>ft', { desc = '[F]ind in [t]elescope' } },       cmd = ':Telescope\n',       desc = 'telescope -> telescope | find telescope functions' },
    { keys = { 'n', '<leader>fw', { desc = '[F]ind [w]ord grep' } },          cmd = tel_bltn.live_grep,   desc = 'telescope -> live_grep | find word in project' },
    { keys = { 'n', '<leader>fd', { desc = '[F]ind in [d]iagnostics' } },     cmd = tel_bltn.diagnostics, desc = 'telescope -> disgnostics | find problems in diagnostics' },
    { keys = { 'n', '<leader>fcw', { desc = '[F]ind [c]urrent [w]ord' } },    cmd = tel_bltn.grep_string, desc = 'telescope -> grep_string | find current word in project' },
  },
}
