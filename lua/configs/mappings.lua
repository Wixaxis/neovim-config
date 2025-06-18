local utils = require 'utils.init'
local M = {}

M.base_mappings = {
  -- NAVIGATION
  -- windows
  { keys = { 'n', '<C-h>' },                      cmd = '<C-w>h',                       desc = 'go to window left' },
  { keys = { 'n', '<C-l>' },                      cmd = '<C-w>l',                       desc = 'go to window right' },
  { keys = { 'n', '<C-j>' },                      cmd = '<C-w>j',                       desc = 'go to window below (down)' },
  { keys = { 'n', '<C-k>' },                      cmd = '<C-w>k',                       desc = 'go to window above (up)' },
  -- base
  { keys = { 'i', '<C-h>' },                      cmd = '<Left>',                       desc = 'go left' },
  { keys = { 'i', '<C-j>' },                      cmd = '<Down>',                       desc = 'go down' },
  { keys = { 'i', '<C-k>' },                      cmd = '<Up>',                         desc = 'go up' },
  { keys = { 'i', '<C-l>' },                      cmd = '<Right>',                      desc = 'go right' },
  -- buffers
  { keys = { 'n', '<Tab>', { silent = true } },   cmd = ':BufferLineCycleNext\n',       desc = 'go to next buffer' },
  { keys = { 'n', '<S-Tab>', { silent = true } }, cmd = ':BufferLineCyclePrev\n',       desc = 'go to prev buffer' },
  { keys = { 'n', '<leader>x' },                  cmd = utils.base.delete_buffer,       desc = 'close current buffer' },
  -- tabs
  { keys = { 'n', '<leader><Tab>' },              cmd = ':tabnext\n',                   desc = 'go to next tab' },
  { keys = { 'n', '<leader><S-Tab>' },            cmd = ':tabprev\n',                   desc = 'go to prev tab' },
  { keys = { 'n', '<leader>n<Tab>' },             cmd = utils.bufferline.new_named_tab, desc = 'open new tab' },
  { keys = { 'n', '<leader>c<Tab>' },             cmd = ':tabclose\n',                  desc = 'close current tab' },
  -- quickfix
  { keys = { 'n', '<leader>qn' },                 cmd = ':cnext\n',                     desc = 'quickfix - next result' },
  { keys = { 'n', '<leader>qp' },                 cmd = ':cprev\n',                     desc = 'quickfix - previous result' },
  { keys = { 'n', '<leader>qo' },                 cmd = ':copen\n',                     desc = 'quickfix - open' },
  { keys = { 'n', '<leader>qc' },                 cmd = ':cclose\n',                    desc = 'quickfix - close' },
  -- git
  { keys = { 'n', '<leader>gt' },                 cmd = ':Telescope git_status\n',      desc = 'open telescope -> git_status' },
  { keys = { 'n', '<leader>lg' },                 cmd = utils.base.open_lazygit,        desc = 'open lazygit' },
  { keys = { 'n', '<leader>lh' },                 cmd = utils.base.git_file_history,    desc = 'open lazygit - current file history' },
  -- other
  { keys = { 'n', '<leader>ll' },                 cmd = ':Lazy\n',                      desc = 'open Lazy.nvim package manager' },
  { keys = { 'n', '<leader>th' },                 cmd = ':Telescope colorscheme\n',     desc = 'change theme | pick colorscheme | telescope -> colorscheme' },
  { keys = {},                                    cmd = utils.base.toggle_relative,     desc = 'toggle relative line numbering' },
}

M.assign_base_mappings = function() require 'commander'.add(M.base_mappings, {}) end

end

M.bufferline = {
  { '<leader>bp',  ':BufferLineTogglePin\n',    desc = 'bufferline - pin current buffer' },
  { '<leader>btr', utils.bufferline.rename_tab, desc = 'bufferline - rename current tab' },
}

M.lsp_mappings = {
  { '<leader>rs', utils.lsp.rename_symbol,         '[R]ename [s]ymbol' },
  { '<leader>ca', utils.lsp.code_action,           '[C]ode [a]ction' },
  { 'gd',         utils.lsp.go_to_definition,      '[G]o to [d]efinition' },
  { 'gD',         utils.lsp.go_to_declaration,     '[G]o to [D]eclaration' },
  { 'gr',         utils.lsp.find_references,       '[G]o to [r]eference' },
  { 'gI',         utils.lsp.go_to_implementation,  '[G]o to [i]mplementation' },
  { 'gtd',        utils.lsp.go_to_type_definition, '[G]o to [t]ype [d]efinition' },
  { 'K',          utils.lsp.hover,                 'Hover' },
  { '<C-g>',      utils.lsp.function_signature,    'Signature' },
  { '<leader>fm', utils.lsp.format,                'Format' }
}

M.auto_dark_mode = {
  { '<leader>000', cmd = utils.auto_dark_mode.disable, desc = 'disable automatic dark mode' },
}

M.autopairs = {
  { '<leader>apd', utils.autopairs.disable, desc = 'autopairs - disable' },
  { '<leader>ape', utils.autopairs.enable,  desc = 'autopairs - enable' },
}

M.barbecue = {
  { '<leader>bct', utils.barbecue.toggle, desc = 'barbecue - toggle (winbar)' },
}

M.comment = {
  { '<leader>/', utils.comment.one_line,   desc = 'comment / uncomment current line' },
  { '<leader>/', utils.comment.many_lines, desc = 'comment / uncomment selected lines', mode = 'v' },
}

M.fterm = {
  { '<A-t>', utils.fterm.toggle, desc = 'open / close floating terminal', mode = { 'n', 't' } },
}

M.gitsigns = {
  { '<leader>gbt', utils.gitsigns.toggle_line_blame, desc = 'gitsigns - current line blame toggle' },
}

M.neotest = {
  { '<leader>tec', utils.neotest.closest, desc = 'NeoTest - TEst Closest' },
  { '<leader>tes', utils.neotest.summary, desc = 'NeoTest - open [te]sts [s]ummary panel' },
  { '<leader>tea', utils.neotest.all,     desc = 'NeoTest - [Te]st [a]ll' },
  { '<leader>tef', utils.neotest.file,    desc = 'NeoTest - [Te]st [f]ile' },
}

M.nvim_tree = {
  { '<leader>e',  utils.nvim_tree.open,        desc = 'open file tree & focus on current file' },
  { '<leader>rf', utils.nvim_tree.rename_file, desc = 'rename current file' },
}

M.nvim_ufo = {
  { 'zR',         utils.nvim_ufo.open_all_folds,    desc = 'open all folds in buffer' },
  { 'zM',         utils.nvim_ufo.close_all_folds,   desc = 'ufo -> close all folds in buffer' },
  { '<leader>zu', utils.nvim_ufo.foldcolumn_1,      desc = 'ufo -> show (narrow + ugly) foldcolumn' },
  { '<leader>zp', utils.nvim_ufo.foldcolumn_auto_9, desc = 'ufo -> show (wide + pretty) foldcolumn' },
  { '<leader>zh', utils.nvim_ufo.foldcolumn_0,      desc = 'ufo -> hide foldcolumn' },
}

M.possession = {
  { '<leader>sl', utils.snacks_picker.sessions,   desc = 'open saved sessions & load picked' },
  { '<leader>ss', utils.possession.save_session,  desc = 'save current session' },
  { '<leader>sp', utils.possession.print_current, desc = 'print name of current session' },
}

M.which_key = {
  { '<leader>?', utils.which_key.show_local, desc = 'which-key - show local bufer keymaps' },
}

M.yanky = {
  { keys = { 'n', '<leader>p' }, cmd = utils.yanky.show_and_paste, desc = 'open yank history & paste here' },
}

return M
