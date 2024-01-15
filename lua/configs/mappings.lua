local tel_bltn = require 'telescope.builtin'
local utils = require 'utils'

local M = {
  base_mappings = {
    { keys = { 'n', '<Tab>' },           cmd = ':bnext\n',                  desc = 'Next buffer' },
    { keys = { 'n', '<S-Tab>' },         cmd = ':bprev\n',                  desc = 'Previous buffer' },
    { keys = { 'n', '<leader><Tab>' },   cmd = ':tabnext\n',                desc = 'Next tab' },
    { keys = { 'n', '<leader><S-Tab>' }, cmd = ':tabprev\n',                desc = 'Previous tab' },
    { keys = { 'n', '<leader>n<Tab>' },  cmd = ':tabnew\n',                 desc = 'New tab' },
    { keys = { 'n', '<leader>c<Tab>' },  cmd = ':tabclose\n',               desc = 'Close tab' },
    { keys = { 'n', '<leader>fm' },      cmd = utils.format_current_buffer, desc = '[F]or[m]at document' },
    { keys = { 'n', '<leader>gt' },      cmd = ':Telescope git_status\n',   desc = 'Telescope [g]it s[t]atus' },
    { keys = { 'n', '<leader>x' },       cmd = ':bdelete\n',                desc = 'Close buffer [x]' },
    { keys = { 'n', '<C-h>' },           cmd = '<C-w>h',                    desc = 'Window left' },
    { keys = { 'n', '<C-l>' },           cmd = '<C-w>l',                    desc = 'Window right' },
    { keys = { 'n', '<C-j>' },           cmd = '<C-w>j',                    desc = 'Window down' },
    { keys = { 'n', '<C-k>' },           cmd = '<C-w>k',                    desc = 'Window up' },
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
    { '<C-g>',       vim.lsp.buf.signature_help,             'Signature' },
    { '<leader>wa',  vim.lsp.buf.add_workspace_folder,       '[W]orkspace folder [a]dd' },
    { '<leader>wr',  vim.lsp.buf.remove_workspace_folder,    '[W]orkspace folder [r]emove' },
    { '<leader>wl',  utils.wksp_list_folders,                '[W]orkspace folder [l]ist' },
  },
}

-- TODO: add mappings and commands to control neovide

require 'commander'.add(M.base_mappings, {})

return M
