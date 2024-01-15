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
    { keys = { 'n', '<leader>fo' },  cmd = tel_bltn.oldfiles,    desc = '[F]ind [o]ldfiles' },
    { keys = { 'n', '<leader>fb' },  cmd = tel_bltn.buffers,     desc = '[F]ind [b]uffer' },
    { keys = { 'n', '<leader>fcf' }, cmd = infile_search,        desc = '[F]ind in [c]urrent [f]ile' },
    { keys = { 'n', '<leader>fg' },  cmd = tel_bltn.git_files,   desc = '[F]ind [g]it files' },
    { keys = { 'n', '<leader>ff' },  cmd = tel_bltn.find_files,  desc = '[F]ind [f]ile' },
    { keys = { 'n', '<leader>fa' },  cmd = find_all,             desc = '[F]ind [a]ll' },
    { keys = { 'n', '<leader>fh' },  cmd = tel_bltn.help_tags,   desc = '[F]ind [h]elp' },
    { keys = { 'n', '<leader>ft' },  cmd = ':Telescope\n',       desc = '[F]ind in [t]elescope' },
    { keys = { 'n', '<leader>fw' },  cmd = tel_bltn.live_grep,   desc = '[F]ind [w]ord grep' },
    { keys = { 'n', '<leader>fd' },  cmd = tel_bltn.diagnostics, desc = '[F]ind in [d]iagnostics' },
    { keys = { 'n', '<leader>fcw' }, cmd = tel_bltn.grep_string, desc = '[F]ind [c]urrently hovered [w]ord by grep' },
  },
}
