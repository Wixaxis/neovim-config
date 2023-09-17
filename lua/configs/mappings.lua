local tel_bltn = require 'telescope.builtin'
local nvim_tree = require 'nvim-tree'
local utils = {
  cmp = {
    confirm_mapping = function(cmp)
      return cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }
    end,

    next_item = function(cmp, luasnip)
      return cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' })
    end,

    prev_item = function(cmp, luasnip)
      return cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' })
    end,
  },

  infile_search = function()
    tel_bltn.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end,

  wksp_list_folders = function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,

  toggle_comment_normal = function()
    require("Comment.api").toggle.linewise.current()
  end,
  toggle_comment_visual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
}

local M = {
  base_mappings = {
    { 'n', '<leader>e',       nvim_tree.focus,             { desc = 'Fil[e] tree' } },
    { 'n', '<leader>fo',      tel_bltn.oldfiles,           { desc = '[F]ind [o]ldfiles' } },
    { 'n', '<leader>fb',      tel_bltn.buffers,            { desc = '[F]ind [b]uffer' } },
    { 'n', '<leader>fcf',     utils.infile_search,         { desc = '[F]ind in [c]urrent file' } },
    { 'n', '<leader>fg',      tel_bltn.git_files,          { desc = '[F]ind [g]it files' } },
    { 'n', '<leader>ff',      tel_bltn.find_files,         { desc = '[F]ind [f]iles' } },
    { 'n', '<leader>fh',      tel_bltn.help_tags,          { desc = '[F]ind [h]elp' } },
    { 'n', '<leader>ft',      ':Telescope\n',              { desc = '[F]ind in [t]elescope' } },
    { 'n', '<leader>fcw',     tel_bltn.grep_string,        { desc = '[F]ind current hovered [w]ord by grep' } },
    { 'n', '<leader>fw',      tel_bltn.live_grep,          { desc = '[F]ind word [G]rep' } },
    { 'n', '<leader>fd',      tel_bltn.diagnostics,        { desc = '[F]ind in [d]iagnostics' } },
    { 'n', '<leader>/',       utils.toggle_comment_normal, { desc = 'Toggle comment' } },
    { 'v', '<leader>/',       utils.toggle_comment_visual, { desc = 'Toggle comment' } },
    { 'n', '<Tab>',           ':bnext\n',                  { desc = 'Next buffer' } },
    { 'n', '<S-Tab>',         ':bprev\n',                  { desc = 'Previous buffer' } },
    { 'n', '<leader><Tab>',   ':tabnext\n',                { desc = 'Next tab' } },
    { 'n', '<leader><S-Tab>', ':tabprev\n',                { desc = 'Previous tab' } },
    { 'n', '<leader>n<Tab>',  ':tabnew\n',                 { desc = 'New tab' } },
    { 'n', '<leader>c<Tab>',  ':tabclose\n',               { desc = 'Close tab' } },
    { 'n', '<leader>ft',      ':Telescope\n',              { desc = '[F]ind in [t]elescope' } },
    { 'n', '<leader>th',      ':Telescope colorscheme\n',  { desc = 'Change [t][h]eme/colorscheme' } },
    { 'n', '<leader>fm',      ':Format\n',                 { desc = '[F]or[m]at document' } },
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

for _, v in ipairs(M.base_mappings) do
  vim.keymap.set(v[1], v[2], v[3], v[4])
end

return M