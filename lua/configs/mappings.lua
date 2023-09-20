local tel_bltn = require 'telescope.builtin'
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
  find_all = ':Telescope find_files follow=true no_ignore=true hidden=true\n',
  format = function()
    vim.lsp.buf.format { async = true }
  end,
  floating_terminal = function()
    require 'FTerm'.toggle()
  end,
  lazygit = function()
    require 'lazygit'
    vim.cmd ':LazyGit\n'
  end,
  focus_tree = function()
    require 'nvim-tree'
    vim.cmd ':NvimTreeFindFile\n'
  end,
  save_session = function()
    local curr_session_name = require 'possession.session'.session_name
    if curr_session_name then
      require 'possession'.save(curr_session_name)
    else
      vim.ui.input({ prompt = 'Enter name for new session: ' }, function(input)
        require 'possession'.save(input)
      end)
    end
  end,
  print_session = function()
    local curr_session_name = require 'possession.session'.session_name
    if curr_session_name then
      vim.notify('Current session: ' .. curr_session_name)
    else
      vim.notify('Currently not in a session', vim.log.levels.WARN)
    end
  end,
}

local M = {
  base_mappings = {
    { 'n', '<leader>e',       utils.focus_tree,               { desc = 'Fil[e] tree' } },
    { 'n', '<leader>fo',      tel_bltn.oldfiles,              { desc = '[F]ind [o]ldfiles' } },
    { 'n', '<leader>fb',      tel_bltn.buffers,               { desc = '[F]ind [b]uffer' } },
    { 'n', '<leader>fcf',     utils.infile_search,            { desc = '[F]ind in [c]urrent file' } },
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
    { 'n', '<leader>fm',      utils.format,                   { desc = '[F]or[m]at document' } },
    { 'n', '<leader>lg',      utils.lazygit,                  { desc = 'Open [L]azy [G]it' } },
    { 'n', '<leader>sl',      ':Telescope possession list\n', { desc = '[S]essions - [l]ist' } },
    { 'n', '<leader>ss',      utils.save_session,             { desc = '[S]essions - [s]ave current' } },
    { 'n', '<leader>sp',      utils.print_session,            { desc = '[S]essions - [p]rint current session name' } },
    { 'n', '<leader>gt',      ':Telescope git_status\n',      { desc = 'Telescope [g]it s[t]atus' } },
    { 'n', '<leader>x',       ':bdelete\n',                   { desc = 'Close buffer [x]' } },
    { 'n', '<A-i>',           utils.floating_terminal,        { desc = 'Toggle floating terminal' } },
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

for _, v in ipairs(M.base_mappings) do
  vim.keymap.set(v[1], v[2], v[3], v[4])
end

return M
