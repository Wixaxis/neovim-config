# Bufferline Tab Names Restoration - TODO

## Problem Statement

When saving a Neovim session with resession.nvim, tab names set via bufferline.nvim's `:BufferLineTabRename` command are not being restored when the session is loaded.

**User Workflow:**
1. User creates tabs and names them using `<leader>n<Tab>` (new named tab) or `<leader>btr` (rename current tab)
2. User saves session with `<leader>ss`
3. User closes and reopens Neovim
4. Session loads but tab names are lost

## Current Implementation

**File:** `lua/resession/extensions/bufferline.lua`

**What it does:**
- `on_save()`: Collects tab names from `vim.fn.gettabinfo()` and stores them in `tab_names` table (tabnr -> name mapping)
- `on_post_load()`: Attempts to restore tab names after session loads using:
  1. Direct `vim.api.nvim_tabpage_set_var()` calls
  2. Bufferline's `tabpages.rename_tab()` function as fallback
  3. UI refresh to update display

**Status:** ❌ Not working - tab names are not restored

## How Bufferline Stores Tab Names

From analyzing `bufferline.nvim` source code:

1. **Storage Method:**
   - Tab names are stored as tabpage variables: `vim.api.nvim_tabpage_set_var(tabpage, "name", name)`
   - The variable is named `"name"` and stored on each tabpage
   - Bufferline reads from `tabpage.variables.name` when rendering

2. **Rename Function:**
   ```lua
   -- From bufferline/lua/bufferline/tabpages.lua
   function M.rename_tab(tabnr, name)
     if name == "" then name = tostring(tabnr) end
     api.nvim_tabpage_set_var(0, "name", name)  -- Note: uses 0 for current tabpage
     ui.refresh()
   end
   ```

3. **Reading Tab Names:**
   - `vim.fn.gettabinfo()` returns tab information including `variables.name`
   - Structure: `{ tabnr = 1, variables = { name = "My Tab Name" }, windows = {...} }`

## Key Files

- **Extension:** `lua/resession/extensions/bufferline.lua`
- **Bufferline Plugin:** `lua/plugins/bufferline.lua`
- **Tab Naming Utils:** `lua/utils/init.lua` (M.bufferline.rename_tab, M.bufferline.new_named_tab)
- **Mappings:** `lua/configs/mappings.lua` (M.bufferline section)

## What Was Tried

1. **Direct Tabpage Variable Setting:**
   ```lua
   vim.api.nvim_tabpage_set_var(tabpage, 'name', saved_name)
   ```
   - Issue: May not work if called before bufferline initializes

2. **Bufferline API Method:**
   ```lua
   require('bufferline.tabpages').rename_tab(tabnr, name)
   ```
   - Issue: The function uses `0` (current tabpage) internally, so we'd need to switch tabs

3. **Timing Issues:**
   - Added `vim.defer_fn` with delays (100ms, 150ms)
   - Tried calling after tabs are restored
   - Issue: May need to wait for bufferline to fully initialize

## Potential Issues

1. **Tab Number Mismatch:**
   - When session loads, tab numbers may be different
   - We're storing by `tabnr` but restored tabs might have different numbers
   - **Solution needed:** Map by tab order/index instead of tab number

2. **Timing:**
   - Bufferline may not be initialized when `on_post_load` runs
   - Tabpage variables might need to be set at a different time
   - **Solution needed:** Use bufferline hooks or wait for specific events

3. **Tabpage Handle vs Number:**
   - `nvim_tabpage_set_var()` needs a tabpage handle, not a number
   - We're using `vim.api.nvim_tabpage_get_number()` to match
   - **Solution needed:** Ensure we're using the correct tabpage handles

4. **Session Restoration Order:**
   - Tabs are restored by resession, then extensions run
   - Tab names might need to be set during tab restoration, not after
   - **Solution needed:** Check if resession has hooks during tab restoration

## Research Needed

1. **Resession Extension API:**
   - Check if there are hooks that run during tab restoration (not just after)
   - Look at resession's built-in extensions for examples
   - Check `plugin_docs/resession.nvim.md` for extension patterns

2. **Bufferline Initialization:**
   - When does bufferline initialize relative to session loading?
   - Are there bufferline events we can hook into?
   - Can we force bufferline to refresh after setting names?

3. **Tab Mapping:**
   - How to reliably map saved tabs to restored tabs?
   - Should we use tab order/index instead of tab number?
   - Can we use tabpage handles directly?

4. **Alternative Approaches:**
   - Could we use resession's `on_pre_load` to prepare data?
   - Should we use a different event or autocmd?
   - Could we hook into bufferline's own events?

## Next Steps (When Resuming)

1. **Debug Current Implementation:**
   - Add logging to see if `on_save` is collecting names correctly
   - Add logging to see if `on_post_load` is being called
   - Check if tabpage variables are actually being set
   - Verify bufferline is initialized when we try to set names

2. **Test Tab Mapping:**
   - Save a session with named tabs
   - Check what data is actually saved
   - Load session and check tab numbers vs saved numbers
   - Verify if tab order is preserved

3. **Try Different Timing:**
   - Use `User` events if bufferline emits any
   - Try longer delays
   - Try using `BufEnter` or `TabEnter` autocmds
   - Check if there's a bufferline initialization event

4. **Alternative Implementation:**
   - Consider using resession hooks instead of extension
   - Try setting names in `on_pre_load` if possible
   - Use bufferline's internal state if accessible
   - Consider a custom autocmd that runs after session load

## Reference Code

### Current Extension (Not Working)
```lua
-- lua/resession/extensions/bufferline.lua
M.on_save = function(opts)
  local tab_names = {}
  local tabs = vim.fn.gettabinfo()
  for _, tab in ipairs(tabs) do
    if tab.variables and tab.variables.name then
      tab_names[tab.tabnr] = tab.variables.name
    end
  end
  return { tab_names = tab_names }
end

M.on_post_load = function(data)
  -- Current implementation tries to restore names but doesn't work
end
```

### Bufferline Tab Naming
```lua
-- From bufferline source
function M.rename_tab(tabnr, name)
  api.nvim_tabpage_set_var(0, "name", name)  -- 0 = current tabpage
  ui.refresh()
end
```

### User Functions
```lua
-- lua/utils/init.lua
M.bufferline = {
  rename_tab = function()
    vim.ui.input({ prompt = 'Rename current tab:' }, function(input) 
      vim.cmd(':BufferLineTabRename ' .. input .. '\n') 
    end)
  end,
  new_named_tab = function()
    vim.cmd ':tabnew\n'
    vim.ui.input({ prompt = 'Name for new tab:' }, function(input)
      if input then vim.cmd(':BufferLineTabRename ' .. input .. '\n') end
    end)
  end,
}
```

## Related Documentation

- **Resession Extensions:** `plugin_docs/resession.nvim.md` (lines 224-310)
- **Bufferline Source:** `~/.local/share/nvim/lazy/bufferline.nvim/lua/bufferline/tabpages.lua`
- **Resession Extension Examples:** Check `~/.local/share/nvim/lazy/resession.nvim/lua/resession/extensions/` for built-in examples

## Questions to Answer

1. Do restored tabs maintain their original tab numbers?
2. When exactly does bufferline initialize relative to session loading?
3. Can we access bufferline's internal tab state?
4. Are there bufferline events we can hook into?
5. Should we use tab order/index instead of tab number for mapping?
6. Is there a better hook point in resession's restoration process?

---

*Created: When implementing bufferline tab name restoration*  
*Status: Not working - needs investigation*  
*Priority: Medium (nice to have feature)*
