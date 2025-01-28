local utils = require 'utils.init'
local M = {}

M.base_mappings = {
  -- NAVIGATION
  -- windows
  { keys = { 'n', '<C-h>' },                      cmd = '<C-w>h',                    desc = 'go to window left' },
  { keys = { 'n', '<C-l>' },                      cmd = '<C-w>l',                    desc = 'go to window right' },
  { keys = { 'n', '<C-j>' },                      cmd = '<C-w>j',                    desc = 'go to window below (down)' },
  { keys = { 'n', '<C-k>' },                      cmd = '<C-w>k',                    desc = 'go to window above (up)' },
  -- buffers
  { keys = { 'n', '<Tab>', { silent = true } },   cmd = ':BufferLineCycleNext\n',    desc = 'go to next buffer' },
  { keys = { 'n', '<S-Tab>', { silent = true } }, cmd = ':BufferLineCyclePrev\n',    desc = 'go to prev buffer' },
  { keys = { 'n', '<leader>x' },                  cmd = utils.base.delete_buffer,    desc = 'close current buffer' },
  -- tabs
  { keys = { 'n', '<leader><Tab>' },              cmd = ':tabnext\n',                desc = 'go to next tab' },
  { keys = { 'n', '<leader><S-Tab>' },            cmd = ':tabprev\n',                desc = 'go to prev tab' },
  { keys = { 'n', '<leader>n<Tab>' },             cmd = ':tabnew\n',                 desc = 'open new tab' },
  { keys = { 'n', '<leader>c<Tab>' },             cmd = ':tabclose\n',               desc = 'close current tab' },
  -- quickfix
  { keys = { 'n', '<leader>qn' },                 cmd = ':cnext\n',                  desc = 'quickfix - next result' },
  { keys = { 'n', '<leader>qp' },                 cmd = ':cprev\n',                  desc = 'quickfix - previous result' },
  { keys = { 'n', '<leader>qo' },                 cmd = ':copen\n',                  desc = 'quickfix - open' },
  { keys = { 'n', '<leader>qc' },                 cmd = ':cclose\n',                 desc = 'quickfix - close' },
  -- git
  { keys = { 'n', '<leader>gt' },                 cmd = ':Telescope git_status\n',   desc = 'open telescope -> git_status' },
  { keys = { 'n', '<leader>lg' },                 cmd = utils.base.open_lazygit,     desc = 'open lazygit' },
  { keys = { 'n', '<leader>lh' },                 cmd = utils.base.git_file_history, desc = 'open lazygit - current file history' },
  -- other
  { keys = { 'n', '<leader>ll' },                 cmd = ':Lazy\n',                   desc = 'open Lazy.nvim package manager' },
  { keys = { 'n', '<leader>th' },                 cmd = ':Telescope colorscheme\n',  desc = 'change theme | pick colorscheme | telescope -> colorscheme' }
}

M.assign_base_mappings = function() require 'commander'.add(M.base_mappings, {}) end

M.harpoon = function(harpoon)
  return {
    { keys = { 'n', '<leader>hh' }, cmd = function() harpoon:list():add() end,                         desc = 'harpoon add file' },
    { keys = { 'n', '<leader>H' },  cmd = function() harpoon:list():remove() end,                      desc = 'harpoon remove file' },
    { keys = { 'n', '<leader>ho' }, cmd = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'harpoon toggle quick menu' },
    { keys = { 'n', '<leader>hn' }, cmd = function() harpoon:list():next() end,                        desc = 'harpoon next file' },
    { keys = { 'n', '<leader>hp' }, cmd = function() harpoon:list():prev() end,                        desc = 'harpoon prev file' },
    { keys = { 'n', '<leader>h1' }, cmd = function() harpoon:list():select(1) end,                     desc = 'harpoon file 1' },
    { keys = { 'n', '<leader>h2' }, cmd = function() harpoon:list():select(2) end,                     desc = 'harpoon file 2' },
    { keys = { 'n', '<leader>h3' }, cmd = function() harpoon:list():select(3) end,                     desc = 'harpoon file 3' },
    { keys = { 'n', '<leader>h4' }, cmd = function() harpoon:list():select(4) end,                     desc = 'harpoon file 4' },
    { keys = { 'n', '<leader>h5' }, cmd = function() harpoon:list():select(5) end,                     desc = 'harpoon file 5' },
    { keys = { 'n', '<leader>h6' }, cmd = function() harpoon:list():select(6) end,                     desc = 'harpoon file 6' },
    { keys = { 'n', '<leader>h7' }, cmd = function() harpoon:list():select(7) end,                     desc = 'harpoon file 7' },
    { keys = { 'n', '<leader>h8' }, cmd = function() harpoon:list():select(8) end,                     desc = 'harpoon file 8' },
    { keys = { 'n', '<leader>h9' }, cmd = function() harpoon:list():select(9) end,                     desc = 'harpoon file 9' },
  }
end

M.bufferline = {
  { keys = { 'n', '<leader>bp' },  cmd = ':BufferLineTogglePin\n',    desc = 'bufferline - pin current buffer' },
  { keys = { 'n', '<leader>btr' }, cmd = utils.bufferline.rename_tab, desc = 'bufferline - rename current tab' },
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
  { keys = {}, cmd = utils.auto_dark_mode.disable, desc = 'disable automatic dark mode' },
}

M.autopairs = {
  { cmd = utils.autopairs.disable, desc = 'autopairs - disable' },
  { cmd = utils.autopairs.enable,  desc = 'autopairs - enable' },
}

M.barbecue = {
  { keys = {}, cmd = utils.barbecue.toggle, desc = 'barbecue - toggle (winbar)' },
}

M.commander = {
  { keys = { { 'n', 'v' }, '<leader><leader>' }, cmd = utils.commander.show, desc = 'open commander' },
}

M.comment = {
  { keys = { 'n', '<leader>/' }, cmd = utils.comment.one_line,   desc = 'comment / uncomment current line' },
  { keys = { 'v', '<leader>/' }, cmd = utils.comment.many_lines, desc = 'comment / uncomment selected lines' },
}

-- TODO: expand terminals support (create, search/select, remove, notify, send, move)
M.fterm = {
  { keys = { { 'n', 't' }, '<A-t>' }, cmd = utils.fterm.toggle, desc = 'open / close floating terminal' },
}

M.gitsigns = {
  { keys = {}, cmd = utils.gitsigns.toggle_line_blame, desc = 'gitsigns - current line blame toggle' },
}

M.neotest = {
  { keys = { 'n', '<leader>tec' }, cmd = utils.neotest.closest, desc = 'NeoTest - TEst Closest' },
  { keys = { 'n', '<leader>tes' }, cmd = utils.neotest.summary, desc = 'NeoTest - open [te]sts [s]ummary panel' },
  { keys = { 'n', '<leader>tea' }, cmd = utils.neotest.all,     desc = 'NeoTest - [Te]st [a]ll' },
  { keys = { 'n', '<leader>tef' }, cmd = utils.neotest.file,    desc = 'NeoTest - [Te]st [f]ile' },
}

M.nvim_tree = {
  { keys = { 'n', '<leader>e' },  cmd = utils.nvim_tree.open,        desc = 'open file tree & focus on current file' },
  { keys = { 'n', '<leader>rf' }, cmd = utils.nvim_tree.rename_file, desc = 'rename current file' },
}

M.nvim_ufo = {
  { keys = { 'n', 'zR' }, cmd = utils.nvim_ufo.open_all_folds,    desc = 'open all folds in buffer' },
  { keys = { 'n', 'zM' }, cmd = utils.nvim_ufo.close_all_folds,   desc = 'ufo -> close all folds in buffer' },
  { keys = {},            cmd = utils.nvim_ufo.foldcolumn_1,      desc = 'ufo -> show (narrow + ugly) foldcolumn' },
  { keys = nil,           cmd = utils.nvim_ufo.foldcolumn_auto_9, desc = 'ufo -> show (wide + pretty) foldcolumn' },
  { keys = {},            cmd = utils.nvim_ufo.foldcolumn_0,      desc = 'ufo -> hide foldcolumn' },
}

M.possession = {
  { keys = { 'n', '<leader>sl' }, cmd = utils.possession.list_sessions, desc = 'open saved sessions & load picked' },
  { keys = { 'n', '<leader>ss' }, cmd = utils.possession.save_session,  desc = 'save current session' },
  { keys = { 'n', '<leader>sp' }, cmd = utils.possession.print_current, desc = 'print name of current session' },
}

M.telescope = {
  { keys = { 'n', '<leader>fo' },  cmd = utils.telescope.oldfiles,      desc = 'telescope -> oldfiles | find previously opened files' },
  { keys = { 'n', '<leader>fb' },  cmd = utils.telescope.buffers,       desc = 'telescope -> buffers | find opened buffer' },
  { keys = { 'n', '<leader>fcf' }, cmd = utils.telescope.infile_search, desc = 'telescope -> infile_search | find words in current file' },
  { keys = { 'n', '<leader>fg' },  cmd = utils.telescope.git_files,     desc = 'telescope -> git_files | find files tracked by git' },
  { keys = { 'n', '<leader>ff' },  cmd = utils.telescope.find_files,    desc = 'telescope -> find_files | find file' },
  { keys = { 'n', '<leader>fa' },  cmd = utils.telescope.find_all,      desc = 'telescope -> find_all | find all possible files' },
  { keys = { 'n', '<leader>fh' },  cmd = utils.telescope.help_tags,     desc = 'telescope -> help_tags | find help in manual' },
  { keys = { 'n', '<leader>ft' },  cmd = utils.telescope.telescope,     desc = 'telescope -> telescope | find telescope functions' },
  { keys = { 'n', '<leader>fw' },  cmd = utils.telescope.live_grep,     desc = 'telescope -> live_grep | find word in project' },
  { keys = { 'n', '<leader>fd' },  cmd = utils.telescope.diagnostics,   desc = 'telescope -> disgnostics | find problems in diagnostics' },
  { keys = { 'n', '<leader>fcw' }, cmd = utils.telescope.grep_string,   desc = 'telescope -> grep_string | find current word in project' }
}

M.todo_comments = {
  { keys = { 'n', '<leader>td' }, cmd = utils.todo_comments.open_list, desc = 'open list of todos in project' },
}

-- TODO: these cammands are badly generated by AI - fix, make sensible and make work
M.trouble = {
  { keys = { 'n', '<leader>trt' }, cmd = utils.trouble.toggle,      desc = 'trouble -> toggle' },
  { keys = { 'n', '<leader>trd' }, cmd = utils.trouble.diagnostics, desc = 'trouble -> diagnostics' },
}

M.which_key = {
  { keys = { 'n', '<leader>?' }, cmd = utils.which_key.show_local, desc = 'which-key - show local bufer keymaps' },
}

M.yanky = {
  { keys = { 'n', '<leader>p' }, cmd = utils.yanky.show_and_paste, desc = 'open yank history & paste here' },
}

return M
