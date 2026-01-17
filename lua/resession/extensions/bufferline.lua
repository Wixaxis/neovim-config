-- Extension to save and restore bufferline tab names
local M = {}

-- Track pending tab names and restoration state
local pending_tab_names = nil
local restored_tabs = {}
local autocmd_id = nil

---Restore tab names for all current tabs
---@param tab_names table Table mapping tab index to name
local function restore_all_tab_names(tab_names)
  if not tab_names then return end
  
  local all_tabs = vim.api.nvim_list_tabpages()
  if #all_tabs == 0 then return end
  
  local restored_count = 0
  local total_to_restore = 0
  
  -- Count how many tabs we need to restore
  for _, name in pairs(tab_names) do
    if name and type(name) == 'string' then
      total_to_restore = total_to_restore + 1
    end
  end
  
  for index, tabpage in ipairs(all_tabs) do
    local saved_name = tab_names[index]
    
    if saved_name and type(saved_name) == 'string' then
      -- Check if we've already restored this tab
      local tab_id = tostring(tabpage)
      if not restored_tabs[tab_id] then
        local is_valid = pcall(vim.api.nvim_tabpage_is_valid, tabpage)
        if is_valid then
          local ok = pcall(vim.api.nvim_tabpage_set_var, tabpage, 'name', saved_name)
          if ok then
            restored_tabs[tab_id] = true
            restored_count = restored_count + 1
          end
        end
      else
        restored_count = restored_count + 1
      end
    end
  end
  
  -- If all tabs are restored, clean up the autocmd
  if restored_count >= total_to_restore and total_to_restore > 0 and autocmd_id then
    pcall(vim.api.nvim_del_autocmd, autocmd_id)
    autocmd_id = nil
    restored_tabs = {}
  end
end

---Get the saved data for this extension
---@param opts resession.Extension.OnSaveOpts Information about the session being saved
---@return table
M.on_save = function(opts)
  local tab_names = {}
  
  -- Get all tabpages in order
  local all_tabs = vim.api.nvim_list_tabpages()
  
  -- Store tab names by their index (order) in the tab list
  -- This ensures we can restore them correctly even if tab numbers change
  for index, tabpage in ipairs(all_tabs) do
    local ok, name = pcall(vim.api.nvim_tabpage_get_var, tabpage, 'name')
    if ok and name and name ~= '' then
      -- Store by index (1-based) to preserve order
      tab_names[index] = name
    end
  end
  
  return { tab_names = tab_names }
end

---Restore the extension state
---@param data table The value returned from on_save
M.on_pre_load = function(data)
  -- Reset restoration state
  restored_tabs = {}
  pending_tab_names = data and data.tab_names or nil
end

---Restore the extension state after tabs are restored
---@param data table The value returned from on_save
M.on_post_load = function(data)
  local tab_names = (data and data.tab_names) or pending_tab_names
  if not tab_names then return end
  
  pending_tab_names = nil
  
  -- Try to restore immediately with a very short delay
  vim.schedule(function()
    -- First attempt: try immediately
    restore_all_tab_names(tab_names)
    
    -- Set up autocmd as fallback for tabs that weren't ready yet
    -- This will catch tabs as they become available
    if autocmd_id then
      pcall(vim.api.nvim_del_autocmd, autocmd_id)
    end
    
    autocmd_id = vim.api.nvim_create_autocmd({ 'TabEnter', 'TabNew', 'TabNewEntered' }, {
      callback = function()
        vim.schedule(function()
          restore_all_tab_names(tab_names)
        end)
      end,
      desc = 'Restore bufferline tab names after session load',
    })
    
    -- Clean up autocmd after a reasonable time (5 seconds)
    -- This prevents it from running indefinitely
    vim.defer_fn(function()
      if autocmd_id then
        pcall(vim.api.nvim_del_autocmd, autocmd_id)
        autocmd_id = nil
        restored_tabs = {}
      end
    end, 5000)
  end)
end

---Called when resession gets configured
---@param config table The configuration data passed in the config
M.config = function(config)
  -- Clean up any lingering autocmds when extension is configured
  if autocmd_id then
    pcall(vim.api.nvim_del_autocmd, autocmd_id)
    autocmd_id = nil
  end
end

return M
