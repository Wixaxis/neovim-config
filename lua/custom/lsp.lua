local M = {}
local state = {
  applying_saved_state = false,
  original_enable = nil,
  wrapped_enable = nil,
}

local default_enabled_servers = {
  ruby_lsp = true,
}

local function state_path()
  return vim.fn.stdpath 'state' .. '/codex/lsp-enabled.json'
end

local function ensure_state_file()
  local path = state_path()
  vim.fn.mkdir(vim.fn.fnamemodify(path, ':h'), 'p')
  return path
end

local function lsp_state(names)
  local state = {}

  for _, name in ipairs(names or {}) do
    if type(name) == 'string' and name ~= '' then
      state[name] = true
    end
  end

  return state
end

local function read_enabled_servers()
  local path = ensure_state_file()
  local file = io.open(path, 'r')

  if not file then return vim.deepcopy(default_enabled_servers) end

  local content = file:read '*a'
  file:close()

  if vim.trim(content) == '' then return {} end

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok or type(decoded) ~= 'table' then
    vim.notify('Invalid saved LSP state, falling back to defaults', vim.log.levels.WARN)
    return vim.deepcopy(default_enabled_servers)
  end

  return lsp_state(decoded)
end

local function write_enabled_servers(enabled_servers)
  local path = ensure_state_file()
  local names = vim.tbl_keys(enabled_servers)
  table.sort(names)

  local file = io.open(path, 'w')
  if not file then
    vim.notify('Could not write saved LSP state', vim.log.levels.ERROR)
    return
  end

  file:write(vim.json.encode(names))
  file:close()
end

local function persist_enabled_servers(names, enabled)
  local enabled_servers = read_enabled_servers()

  for _, name in ipairs(vim._ensure_list(names)) do
    enabled_servers[name] = enabled and true or nil
  end

  write_enabled_servers(enabled_servers)
end

local function has_lsp_config(name)
  return #vim.api.nvim_get_runtime_file(('lsp/%s.lua'):format(name), true) > 0
end

local function mason_lsp_server(package)
  local neovim = package.spec.neovim or {}
  local candidates = {}

  if type(neovim.lspconfig) == 'string' then
    candidates[#candidates + 1] = neovim.lspconfig
  end

  candidates[#candidates + 1] = package.name

  for _, alias in ipairs(package:get_aliases()) do
    candidates[#candidates + 1] = alias
  end

  for _, candidate in ipairs(candidates) do
    if has_lsp_config(candidate) then return candidate end
  end
end

local function installed_lsp_packages()
  local registry = require 'mason-registry'
  pcall(registry.refresh)

  local enabled_servers = read_enabled_servers()
  local packages = {}

  for _, package in ipairs(registry.get_installed_packages()) do
    if vim.tbl_contains(package.spec.categories or {}, 'LSP') then
      local server = mason_lsp_server(package)

      if server then
        packages[#packages + 1] = {
          package = package.name,
          server = server,
          description = package.spec.description,
          homepage = package.spec.homepage,
          enabled = enabled_servers[server] == true,
          text = table.concat({ package.name, server, package.spec.description or '' }, ' '),
        }
      end
    end
  end

  table.sort(packages, function(left, right)
    if left.enabled ~= right.enabled then return left.enabled end
    return left.server < right.server
  end)

  return packages
end

local function set_server_enabled(server, enabled)
  local ok, err = pcall(vim.lsp.enable, server, enabled)

  if ok then return true end

  vim.notify(('Failed to %s %s: %s'):format(enabled and 'enable' or 'disable', server, err), vim.log.levels.ERROR)
  return false
end

local function wrap_lsp_enable()
  if vim.lsp.enable == state.wrapped_enable then return end
  state.original_enable = state.original_enable or vim.lsp.enable

  state.wrapped_enable = function(names, enabled)
    local ok, result = pcall(state.original_enable, names, enabled)

    if not ok then error(result) end

    if not state.applying_saved_state then
      persist_enabled_servers(names, enabled ~= false)
    end

    return result
  end

  vim.lsp.enable = state.wrapped_enable
end

local function toggle_server(item)
  local enabled_servers = read_enabled_servers()
  local enable = not enabled_servers[item.server]

  if not set_server_enabled(item.server, enable) then return end

  enabled_servers[item.server] = enable or nil
  write_enabled_servers(enabled_servers)

  vim.notify(('%s %s'):format(enable and 'Enabled' or 'Disabled', item.server), vim.log.levels.INFO)
end

local function preview(ctx)
  local item = ctx.item
  if not item then return end

  local lines = {
    ('Server:  %s'):format(item.server),
    ('Package: %s'):format(item.package),
    ('Status:  %s'):format(item.enabled and 'enabled' or 'disabled'),
  }

  if item.description and item.description ~= '' then
    lines[#lines + 1] = ''
    vim.list_extend(lines, vim.split(vim.trim(item.description), '\n', { plain = true }))
  end

  if item.homepage and item.homepage ~= '' then
    lines[#lines + 1] = ''
    lines[#lines + 1] = item.homepage
  end

  vim.bo[ctx.buf].modifiable = true
  vim.api.nvim_buf_set_lines(ctx.buf, 0, -1, false, lines)
  vim.bo[ctx.buf].modifiable = false
end

local function register_picker()
  if type(Snacks) == 'table' and type(Snacks.picker) == 'table' then
    Snacks.picker.lsp_enable = M.picker
  end
end

function M.picker()
  Snacks.picker.pick({
    title = 'LSP Enable',
    layout = { preset = 'select' },
    preview = preview,
    finder = installed_lsp_packages,
    format = function(item)
      return {
        { item.enabled and 'on  ', item.enabled and 'DiagnosticOk' or 'SnacksPickerDimmed' },
        { item.server, 'SnacksPickerSpecial' },
        { '  ' },
        { item.package, 'SnacksPickerComment' },
      }
    end,
    actions = {
      confirm = function(picker, item)
        if not item then return end

        toggle_server(item)
        picker.list:set_target()
        picker:find()
      end,
    },
  })
end

function M.setup()
  wrap_lsp_enable()
  local enabled_servers = read_enabled_servers()

  if vim.fn.filereadable(state_path()) == 0 then
    write_enabled_servers(enabled_servers)
  end

  state.applying_saved_state = true
  for _, item in ipairs(installed_lsp_packages()) do
    set_server_enabled(item.server, enabled_servers[item.server] == true)
  end
  state.applying_saved_state = false

  vim.api.nvim_create_user_command('LspEnablePicker', M.picker, { desc = 'Toggle Mason-installed LSP servers' })
  register_picker()

  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('CustomLspPicker', { clear = true }),
    pattern = 'VeryLazy',
    callback = register_picker,
  })
end

return M
