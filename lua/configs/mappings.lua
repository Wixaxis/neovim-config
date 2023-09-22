local tel_bltn = require 'telescope.builtin'
local utils = require 'utils'

local M = {
  base_mappings = {
    { 'n', '<leader>e',       utils.focus_tree,               { desc = 'Fil[e] tree' } },
    { 'n', '<leader>fo',      tel_bltn.oldfiles,              { desc = '[F]ind [o]ldfiles' } },
    { 'n', '<leader>fb',      tel_bltn.buffers,               { desc = '[F]ind [b]uffer' } },
    { 'n', '<leader>fcf',     utils.infile_search,            { desc = '[F]ind in [c]urrent [f]ile' } },
    { 'n', '<leader>fg',      tel_bltn.git_files,             { desc = '[F]ind [g]it files' } },
    { 'n', '<leader>ff',      tel_bltn.find_files,            { desc = '[F]ind [f]ile' } },
    { 'n', '<leader>fa',      utils.find_all,                 { desc = '[F]ind [a]ll' } },
    { 'n', '<leader>fh',      tel_bltn.help_tags,             { desc = '[F]ind [h]elp' } },
    { 'n', '<leader>ft',      ':Telescope\n',                 { desc = '[F]ind in [t]elescope' } },
    { 'n', '<leader>fcw',     tel_bltn.grep_string,           { desc = '[F]ind [c]urrently hovered [w]ord by grep' } },
    { 'n', '<leader>fw',      tel_bltn.live_grep,             { desc = '[F]ind [w]ord grep' } },
    { 'n', '<leader>fd',      tel_bltn.diagnostics,           { desc = '[F]ind in [d]iagnostics' } },
    { 'n', '<leader>/',       utils.toggle_comment_normal,    { desc = 'Toggle comment' } },
    { 'v', '<leader>/',       utils.toggle_comment_visual,    { desc = 'Toggle comment' } },
    { 'n', '<Tab>',           ':bnext\n',                     { desc = 'Next buffer' } },
    { 'n', '<S-Tab>',         ':bprev\n',                     { desc = 'Previous buffer' } },
    { 'n', '<leader><Tab>',   ':tabnext\n',                   { desc = 'Next tab' } },
    { 'n', '<leader><S-Tab>', ':tabprev\n',                   { desc = 'Previous tab' } },
    { 'n', '<leader>n<Tab>',  ':tabnew\n',                    { desc = 'New tab' } },
    { 'n', '<leader>c<Tab>',  ':tabclose\n',                  { desc = 'Close tab' } },
    { 'n', '<leader>ft',      ':Telescope\n',                 { desc = '[F]ind in [t]elescope' } },
    { 'n', '<leader>th',      ':Telescope colorscheme\n',     { desc = 'Change [t][h]eme/colorscheme' } },
    { 'n', '<leader>td',      ':TodoTelescope\n',             { desc = 'List [t]o[d]o tags in project' } },
    { 'n', '<leader>fm',      utils.format,                   { desc = '[F]or[m]at document' } },
    { 'n', '<leader>lg',      utils.lazygit,                  { desc = 'Open [L]azy [G]it' } },
    { 'n', '<leader>sl',      ':Telescope possession list\n', { desc = '[S]essions - [l]ist' } }, -- TODO: expand session management, It's poor
    { 'n', '<leader>ss',      utils.save_session,             { desc = '[S]essions - [s]ave current' } },
    { 'n', '<leader>sp',      utils.print_session,            { desc = '[S]essions - [p]rint current session name' } },
    { 'n', '<leader>gt',      ':Telescope git_status\n',      { desc = 'Telescope [g]it s[t]atus' } },
    { 'n', '<leader>x',       ':bdelete\n',                   { desc = 'Close buffer [x]' } },
    { 'n', '<A-i>',           utils.floating_terminal,        { desc = 'Toggle floating terminal' } }, -- TODO: expand terminals support (create, search/select, remove, notify, send, move)
    { 't', '<A-i>',           utils.floating_terminal,        { desc = 'Toggle floating terminal' } },
    { 'n', '<C-h>',           '<C-w>h',                       { desc = 'Window left' } },
    { 'n', '<C-l>',           '<C-w>l',                       { desc = 'Window right' } },
    { 'n', '<C-j>',           '<C-w>j',                       { desc = 'Window down' } },
    { 'n', '<C-k>',           '<C-w>k',                       { desc = 'Window up' } },
  },

  cmp_mappings = function(cmp, luasnip)
    return cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = utils.cmp.confirm_mapping(cmp),
      ['<Tab>'] = utils.cmp.next_item(cmp, luasnip),
      ['<S-Tab>'] = utils.cmp.prev_item(cmp, luasnip),
    }
  end,

  lsp_mappings = {
    { '<leader>rs',  vim.lsp.buf.rename,                     '[R]ename [s]ymbol' },
    { '<leader>ca',  vim.lsp.buf.code_action,                '[C]ode [a]ction' },
    { 'gd',          vim.lsp.buf.definition,                 '[G]o to [d]efinition' },
    { 'gD',          vim.lsp.buf.declaration,                '[G]o to [D]eclaration' },
    { 'gr',          tel_bltn.lsp_references,                '[G]o to [r]eference' },
    { 'gI',          vim.lsp.buf.implementation,             '[G]o to [i]mplementation' },
    { 'gtd',         vim.lsp.buf.type_definition,            '[G]o to [t]ype [d]efinition' },
    { '<leader>fsc', tel_bltn.lsp_document_symbols,          '[F]ind [s]ymbol in [c]urrent buffer' },
    { '<leader>fsw', tel_bltn.lsp_dynamic_workspace_symbols, '[F]ind [s]ymbol in [w]orkspace' },
    { 'K',           vim.lsp.buf.hover,                      'Hover' },
    { '<C-k>',       vim.lsp.buf.signature_help,             'Signature' },
    { '<leader>wa',  vim.lsp.buf.add_workspace_folder,       '[W]orkspace folder [a]dd' },
    { '<leader>wr',  vim.lsp.buf.remove_workspace_folder,    '[W]orkspace folder [r]emove' },
    { '<leader>wl',  utils.wksp_list_folders,                '[W]orkspace folder [l]ist' },
  },
}

utils.set_keymaps_table(M.base_mappings)

return M
