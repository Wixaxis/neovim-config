local M = {}
M.neovide = require 'utils.neovide'
M.lsp = require 'utils.lsp'
M.snacks = require 'utils.snacks'
M.autocmds = require 'utils.autocmds'

M.str_split = function(inputstr, sep)
  if sep == nil then sep = '%s' end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

M.set_default_colorscheme = function(theme_mode)
  theme_mode = theme_mode or 'dark'
  local default_theme = theme_mode == 'dark' and require('defaults').dark_theme or require('defaults').light_theme
  local current_theme = vim.cmd.colorscheme()
  if current_theme == default_theme then
    vim.notify('Theme [' .. current_theme .. '] already set, omitting...')
    return
  end
  vim.notify('Set theme to ' .. default_theme)
  vim.cmd.colorscheme(default_theme)
end

M.set_keymaps = function(keymaps, opts)
  opts = opts or {}

  for _, keymap in ipairs(keymaps) do
    local key = keymap[1]
    local action = keymap[2]
    local desc = keymap.desc
    local mode = keymap.mode or 'n'
    local buffer = keymap.buffer
    local silent = keymap.silent

    local keymap_opts = vim.tbl_extend('force', opts, {
      desc = desc,
      buffer = buffer,
      silent = silent,
    })

    for k, v in pairs(keymap_opts) do
      if v == nil then keymap_opts[k] = nil end
    end

    if type(mode) == 'table' then
      for _, m in ipairs(mode) do
        vim.keymap.set(m, key, action, keymap_opts)
      end
    else
      vim.keymap.set(mode, key, action, keymap_opts)
    end
  end
end

---@diagnostic disable-next-line: undefined-field
M.sys_name = vim.loop.os_uname().sysname

M.base = {
  toggle_relative = function() vim.wo.relativenumber = not vim.wo.relativenumber end,
}

M.bufferline = {
  rename_tab = function()
    vim.ui.input({ prompt = 'Rename current tab:' }, function(input) vim.cmd(':BufferLineTabRename ' .. input .. '\n') end)
  end,
  new_named_tab = function()
    vim.cmd ':tabnew\n'
    vim.ui.input({ prompt = 'Name for new tab:' }, function(input)
      if input then vim.cmd(':BufferLineTabRename ' .. input .. '\n') end
    end)
  end,
}

M.auto_dark_mode = { disable = function() require('auto-dark-mode').disable() end }

M.autopairs = {
  enable = function() require('nvim-autopairs').enable() end,
  disable = function() require('nvim-autopairs').disable() end,
}

M.barbecue = { toggle = function() require('barbecue.ui').toggle() end }

M.comment = {
  one_line = function()
    require 'Comment'
    require('Comment.api').toggle.linewise.current()
  end,
  many_lines = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
}

M.gitsigns = {
  toggle_line_blame = function()
    if vim.api.nvim_buf_is_valid(vim.g.last_current_bufnr) then vim.api.nvim_set_current_buf(vim.g.last_current_bufnr) end
    package.loaded.gitsigns.toggle_current_line_blame()
    vim.g.last_current_bufnr = nil
  end,
}

M.neotest = {
  summary = function() require('neotest').summary.toggle() end,
  closest = function()
    require('neotest').run.run()
    require('neotest').summary.open()
  end,
  all = function()
    require('neotest').run.run(vim.fn.getcwd())
    require('neotest').summary.open()
  end,
  file = function()
    require('neotest').run.run(vim.fn.expand '%')
    require('neotest').summary.open()
  end,
}

M.nvim_tree = {
  open = function()
    require 'nvim-tree'
    vim.cmd ':NvimTreeFindFile\n'
  end,
  rename_file = function() require('snacks').rename.rename_file() end,
}

M.nvim_ufo = {
  open_all_folds = function() require('ufo').openAllFolds() end,
  close_all_folds = function() require('ufo').closeAllFolds() end,
  foldcolumn_1 = ':bufdo set foldcolumn=1\n',
  foldcolumn_auto_9 = ':bufdo set foldcolumn=auto:9\n',
  foldcolumn_0 = ':bufdo set foldcolumn=0\n',
}

M.resession = {
  save_session = function()
    local resession = require('resession')
    local session_name = vim.fn.getcwd()
    resession.save(session_name, { dir = '.nvim-session', notify = true })
  end,
  load_session = function()
    local resession = require('resession')
    local session_name = vim.fn.getcwd()
    resession.load(session_name, { dir = '.nvim-session', silence_errors = true })
    -- Load doesn't have notify option, but we can add our own notification
    local current = resession.get_current()
    if current then
      vim.notify('Session loaded: ' .. current, vim.log.levels.INFO)
    end
  end,
  delete_session = function()
    local resession = require('resession')
    local session_name = vim.fn.getcwd()
    resession.delete(session_name, { dir = '.nvim-session', notify = true })
  end,
  print_current = function()
    local resession = require('resession')
    local current = resession.get_current()
    if current then
      vim.notify('Current session: ' .. current)
    else
      vim.notify('Currently not in a session', vim.log.levels.WARN)
    end
  end,
}

M.visual_whitespace = { toggle = function() require('visual-whitespace').toggle() end }

M.sidekick = {
  double_escape = (function()
    local esc_timer = (vim.uv or vim.loop).new_timer()
    return function()
      if esc_timer:is_active() then
        esc_timer:stop()
        vim.cmd 'stopinsert'
      else
        esc_timer:start(200, 0, function() end)
        return '<esc>'
      end
    end
  end)(),
  next_edit_suggestion = function()
    if not require('sidekick').nes_jump_or_apply() then
      return '<Tab>'
    end
  end,
  send_this = function() require('sidekick.cli').send { msg = '{this}' } end,
  send_file = function() require('sidekick.cli').send { msg = '{file}' } end,
  send_selection = function() require('sidekick.cli').send { msg = '{selection}' } end,
  prompt = function() require('sidekick.cli').prompt() end,
  toggle_cursor = function() require('sidekick.cli').toggle { name = 'cursor', focus = true } end,
}

M.which_key = { show_local = function() require('which-key').show { global = false } end }

return M
