local M = {}
local pending, restored, autocmd_id = nil, {}, nil

local function restore(tab_names)
  if not tab_names then return end
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs == 0 then return end
  local count, total = 0, 0
  for _, name in pairs(tab_names) do
    if name and type(name) == 'string' then total = total + 1 end
  end
  for i, tab in ipairs(tabs) do
    local name = tab_names[i]
    if name and type(name) == 'string' then
      local id = tostring(tab)
      if not restored[id] and pcall(vim.api.nvim_tabpage_is_valid, tab) then
        if pcall(vim.api.nvim_tabpage_set_var, tab, 'name', name) then
          restored[id] = true
          count = count + 1
        end
      elseif restored[id] then
        count = count + 1
      end
    end
  end
  if count >= total and total > 0 and autocmd_id then
    pcall(vim.api.nvim_del_autocmd, autocmd_id)
    autocmd_id = nil
    restored = {}
  end
end

M.on_save = function()
  local names = {}
  for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local ok, name = pcall(vim.api.nvim_tabpage_get_var, tab, 'name')
    if ok and name and name ~= '' then names[i] = name end
  end
  return { tab_names = names }
end

M.on_pre_load = function(data)
  restored = {}
  pending = data and data.tab_names or nil
end

M.on_post_load = function(data)
  local names = (data and data.tab_names) or pending
  if not names then return end
  pending = nil
  vim.schedule(function()
    restore(names)
    if autocmd_id then pcall(vim.api.nvim_del_autocmd, autocmd_id) end
    autocmd_id = vim.api.nvim_create_autocmd({ 'TabEnter', 'TabNew', 'TabNewEntered' }, {
      callback = function() vim.schedule(function() restore(names) end) end,
      desc = 'Restore bufferline tab names after session load',
    })
    vim.defer_fn(function()
      if autocmd_id then
        pcall(vim.api.nvim_del_autocmd, autocmd_id)
        autocmd_id = nil
        restored = {}
      end
    end, 5000)
  end)
end

M.config = function()
  if autocmd_id then
    pcall(vim.api.nvim_del_autocmd, autocmd_id)
    autocmd_id = nil
  end
end

return M
