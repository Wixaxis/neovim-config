local utils = require 'utils.init'
local M = {}

M.base_mappings = {
  -- windows
  { '<C-h>',       '<C-w>h',                   desc = 'go to window left' },
  { '<C-l>',       '<C-w>l',                   desc = 'go to window right' },
  { '<C-j>',       '<C-w>j',                   desc = 'go to window below (down)' },
  { '<C-k>',       '<C-w>k',                   desc = 'go to window above (up)' },
  -- base
  { '<C-h>',       '<Left>',                   desc = 'go left',                       mode = 'i' },
  { '<C-j>',       '<Down>',                   desc = 'go down',                       mode = 'i' },
  { '<C-k>',       '<Up>',                     desc = 'go up',                         mode = 'i' },
  { '<C-l>',       '<Right>',                  desc = 'go right',                      mode = 'i' },
  -- quickfix
  { '<leader>qn',  ':cnext\n',                 desc = 'quickfix - next result' },
  { '<leader>qp',  ':cprev\n',                 desc = 'quickfix - previous result' },
  { '<leader>qo',  ':copen\n',                 desc = 'quickfix - open' },
  { '<leader>qc',  ':cclose\n',                desc = 'quickfix - close' },
  -- other
  { '<leader>ll',  ':Lazy\n',                  desc = 'open Lazy.nvim package manager' },
  { '<leader>rnt', utils.base.toggle_relative, desc = 'toggle relative line numbering' },
}

M.assign_base_mappings = function() utils.set_keymaps(M.base_mappings) end

M.snacks = {
  { '<A-t>',             utils.snacks.terminal.toggle,      desc = 'open / close floating terminal',                  mode = { 'n', 't' } },
  -- find actions
  { '<leader>f<leader>', utils.snacks.picker.pickers,       desc = 'find available pickers' },
  { '<leader><leader>',  utils.snacks.picker.keymaps,       desc = 'open keymaps picker' },
  { '<leader>fh',        utils.snacks.picker.help_tags,     desc = 'find help in manual' },
  -- base file finders (name)
  { '<leader>ff',        utils.snacks.picker.find_files,    desc = 'find file' },
  { '<leader>fo',        utils.snacks.picker.oldfiles,      desc = 'find previously opened files' },
  { '<leader>fg',        utils.snacks.picker.git_files,     desc = 'find files tracked by git' },
  { '<leader>fa',        utils.snacks.picker.find_all,      desc = 'find all possible files' },
  -- base file finders (grep)
  { '<leader>fw',        utils.snacks.picker.live_grep,     desc = 'find word in project' },
  { '<leader>fcw',       utils.snacks.picker.grep_string,   desc = 'find current word in project' },
  -- base local grep
  { '<leader>fcf',       utils.snacks.picker.infile_search, desc = 'find words in current file' },
  -- buffers
  { '<leader>fb',        utils.snacks.picker.buffers,       desc = 'find opened buffer' },
  -- diagnostics
  { '<leader>fd',        utils.snacks.picker.diagnostics,   desc = 'find problems in diagnostics' },
  -- theme
  { '<leader>th',        utils.snacks.picker.colorscheme,   desc = 'change theme | pick colorscheme' },
  -- TODOs
  { '<leader>td',        utils.snacks.picker.todo,          desc = 'smart picker for todos and more' },
  -- git
  { '<leader>gt',        utils.snacks.picker.git_status,    desc = 'open git status picker' },
  -- github
  { '<leader>gp',        utils.snacks.picker.gh_pr,         desc = 'GitHub Pull Requests (open)' },

  -- lazygit
  { '<leader>lg',        utils.snacks.lazygit.open,         desc = 'open lazygit' },
  { '<leader>lh',        utils.snacks.lazygit.file_history, desc = 'open lazygit - current file history' },
  -- explorer
  { '<leader>e',         utils.snacks.explorer.reveal,      desc = 'show file explorer' },
  { '<leader>E',         utils.snacks.explorer.reveal_all,  desc = 'show file explorer with hidden and ignored files' },
}

M.bufferline = {
  { '<leader>bp',      ':BufferLineTogglePin\n',       desc = 'bufferline - pin current buffer' },
  { '<leader>btr',     utils.bufferline.rename_tab,    desc = 'bufferline - rename current tab' },
  { '<leader><Tab>',   ':tabnext\n',                   desc = 'go to next tab',                 silent = true },
  { '<leader><S-Tab>', ':tabprev\n',                   desc = 'go to prev tab',                 silent = true },
  { '<leader>n<Tab>',  utils.bufferline.new_named_tab, desc = 'open new tab' },
  { '<leader>c<Tab>',  ':tabclose\n',                  desc = 'close current tab' },
  { '<Tab>',           ':BufferLineCycleNext\n',       desc = 'go to next buffer',              silent = true },
  { '<S-Tab>',         ':BufferLineCyclePrev\n',       desc = 'go to prev buffer',              silent = true },
  { '<leader>x',       utils.snacks.buffer.delete,     desc = 'close current buffer',           silent = true },
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
  { '<leader>fm', utils.lsp.format,                'Format' },
}

M.auto_dark_mode = {
  { '<leader>000', utils.auto_dark_mode.disable, desc = 'disable automatic dark mode' },
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

M.gitsigns = {
  { '<leader>gbt', utils.gitsigns.toggle_line_blame, desc = 'gitsigns - current line blame toggle' },
}

M.neotest = {
  { '<leader>tec', utils.neotest.closest, desc = 'NeoTest - TEst Closest' },
  { '<leader>tes', utils.neotest.summary, desc = 'NeoTest - open [te]sts [s]ummary panel' },
  { '<leader>tea', utils.neotest.all,     desc = 'NeoTest - [Te]st [a]ll' },
  { '<leader>tef', utils.neotest.file,    desc = 'NeoTest - [Te]st [f]ile' },
}

M.nvim_ufo = {
  { 'zR',         utils.nvim_ufo.open_all_folds,    desc = 'open all folds in buffer' },
  { 'zM',         utils.nvim_ufo.close_all_folds,   desc = 'ufo -> close all folds in buffer' },
  { '<leader>zu', utils.nvim_ufo.foldcolumn_1,      desc = 'ufo -> show (narrow + ugly) foldcolumn' },
  { '<leader>zp', utils.nvim_ufo.foldcolumn_auto_9, desc = 'ufo -> show (wide + pretty) foldcolumn' },
  { '<leader>zh', utils.nvim_ufo.foldcolumn_0,      desc = 'ufo -> hide foldcolumn' },
}

M.resession = {
  { '<leader>ss', utils.resession.save_session, desc = 'save current session to project root' },
  { '<leader>sl', utils.resession.load_session, desc = 'load session from project root' },
  { '<leader>sd', utils.resession.delete_session, desc = 'delete session from project root' },
  { '<leader>sp', utils.resession.print_current, desc = 'print current session name' },
}

M.sidekick = {
  { '<esc>', utils.sidekick.double_escape, mode = 't', expr = true, desc = 'Double escape to normal mode' },
  { '<leader>as', utils.sidekick.next_edit_suggestion, expr = true, desc = 'Goto/Apply Next Edit Suggestion' },
  { '<leader>at', utils.sidekick.send_this, mode = { 'x', 'n' }, desc = 'Send This' },
  { '<leader>af', utils.sidekick.send_file, desc = 'Send File' },
  { '<leader>av', utils.sidekick.send_selection, mode = { 'x' }, desc = 'Send Visual Selection' },
  { '<leader>ap', utils.sidekick.prompt, mode = { 'n', 'x' }, desc = 'Sidekick Select Prompt' },
  { '<leader>aa', utils.sidekick.toggle_cursor, desc = 'Sidekick Toggle Cursor' },
}

M.visual_whitespace = {
  { '<leader>vwst', utils.visual_whitespace.toggle, desc = 'visual whitespace toggle' },
}

M.which_key = {
  { '<leader>?', utils.which_key.show_local, desc = 'which-key - show local bufer keymaps' },
}

M.yanky = {
  { '<leader>p', utils.snacks.picker.yanky, desc = 'open yank history' },
}

return M
