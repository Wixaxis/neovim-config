local tel_bltn = require 'telescope.builtin'
local utils = require 'utils'

local M = {
  base_mappings = {
    { keys = { 'n', '<Tab>', { desc = 'Next buffer', silent = true } },        cmd = ':bnext\n',                                     desc = 'go to next buffer' },
    { keys = { 'n', '<S-Tab>', { desc = 'Previous buffer', silent = true } },  cmd = ':bprev\n',                                     desc = 'go to prev buffer' },
    { keys = { 'n', '<leader><Tab>', { desc = 'Next tab', silent = true } },   cmd = ':tabnext\n',                                   desc = 'go to next tab' },
    { keys = { 'n', '<leader><S-Tab>', { desc = 'Prev tab', silent = true } }, cmd = ':tabprev\n',                                   desc = 'go to prev tab' },
    { keys = { 'n', '<leader>n<Tab>', { desc = 'New tab', silent = true } },   cmd = ':tabnew\n',                                    desc = 'open new tab' },
    { keys = { 'n', '<leader>c<Tab>', { desc = 'Close tab', silent = true } }, cmd = ':tabclose\n',                                  desc = 'close current tab' },
    { keys = { 'n', '<leader>fm', { desc = '[F]or[m]at document' } },          cmd = utils.format_current_buffer,                    desc = 'format document' },
    { keys = { 'n', '<leader>gt', { desc = 'Telescope [g]it s[t]atus' } },     cmd = ':Telescope git_status\n',                      desc = 'open telescope -> git_status' },
    { keys = { 'n', '<leader>x', { desc = 'Close buffer [x]' } },              cmd = ':bdelete\n',                                   desc = 'close current buffer' },
    { keys = { 'n', '<C-h>', { desc = 'Window left' } },                       cmd = '<C-w>h',                                       desc = 'go to window left' },
    { keys = { 'n', '<C-l>', { desc = 'Window right' } },                      cmd = '<C-w>l',                                       desc = 'go to window right' },
    { keys = { 'n', '<C-j>', { desc = 'Window down' } },                       cmd = '<C-w>j',                                       desc = 'go to window below (down)' },
    { keys = { 'n', '<C-k>', { desc = 'Window up' } },                         cmd = '<C-w>k',                                       desc = 'go to window above (up)' },
    { keys = { 'n', '<leader>ll', { desc = '[L]azy.nvim package manager' } },  cmd = ':Lazy\n',                                      desc = 'open Lazy.nvim package manager' },
    { cmd = ':Lazy sync\n',                                                    desc = 'open Lazy.nvim and sync (update) all plugins' }
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
