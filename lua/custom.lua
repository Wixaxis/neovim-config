local M = {}
local state = {
  commands_created = false,
  last_errmsg = '',
  notify_wrapper = nil,
  original_notify = nil,
}

local function error_log_path()
  return vim.fn.stdpath 'state' .. '/codex/errors.log'
end

local function ensure_error_log()
  local path = error_log_path()
  vim.fn.mkdir(vim.fn.fnamemodify(path, ':h'), 'p')

  local file = io.open(path, 'a')
  if file then file:close() end

  return path
end

local function normalize_message(message)
  if type(message) == 'string' then return message end
  return vim.inspect(message)
end

local function log_error(source, message, context)
  message = vim.trim(normalize_message(message))
  if message == '' then return end

  local file = io.open(ensure_error_log(), 'a')
  if not file then return end

  local header = string.format('[%s] %s', os.date '%Y-%m-%d %H:%M:%S', source)
  if context and context ~= '' then
    header = header .. ' [' .. context .. ']'
  end

  file:write(header .. '\n')
  file:write(message .. '\n\n')
  file:close()
end

local function create_error_commands()
  if state.commands_created then return end

  vim.api.nvim_create_user_command('CodexErrors', function()
    local path = ensure_error_log()
    vim.cmd('tabnew ' .. vim.fn.fnameescape(path))
    vim.bo.filetype = 'log'
  end, { desc = 'Open the Codex error journal' })

  vim.api.nvim_create_user_command('CodexErrorsClear', function()
    local path = ensure_error_log()
    local file = io.open(path, 'w')
    if file then file:close() end
    vim.notify('Cleared Codex error journal', vim.log.levels.INFO)
  end, { desc = 'Clear the Codex error journal' })

  state.commands_created = true
end

local function wrap_notify()
  if vim.notify == state.notify_wrapper then return end

  state.original_notify = vim.notify
  state.notify_wrapper = function(message, level, opts)
    local resolved_level = type(level) == 'string' and vim.log.levels[level] or level or vim.log.levels.INFO
    if resolved_level >= vim.log.levels.WARN then
      log_error('notify', message, resolved_level == vim.log.levels.ERROR and 'ERROR' or 'WARN')
    end

    return state.original_notify(message, level, opts)
  end

  vim.notify = state.notify_wrapper
end

function M.setup_error_journal()
  create_error_commands()
  wrap_notify()

  local group = vim.api.nvim_create_augroup('CustomErrorJournal', { clear = true })
  vim.api.nvim_create_autocmd('SafeState', {
    group = group,
    callback = function()
      local errmsg = vim.trim(vim.v.errmsg or '')
      if errmsg == '' or errmsg == state.last_errmsg then return end

      state.last_errmsg = errmsg
      log_error('v:errmsg', errmsg)
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'VeryLazy',
    callback = wrap_notify,
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
    callback = wrap_notify,
  })
end

function M.setup()
  M.setup_error_journal()
end

function M.setup_lsp()
  require('custom.lsp').setup()
end

return M
