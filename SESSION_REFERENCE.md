# Session Management Reference

This document provides a comprehensive guide to how session management works in this Neovim configuration, including plugin documentation and implementation details.

## Table of Contents

1. [Overview](#overview)
2. [Plugin: possession.nvim](#plugin-possessionnvim)
3. [Implementation Details](#implementation-details)
4. [Keybindings](#keybindings)
5. [Session Storage](#session-storage)
6. [Integration Points](#integration-points)
7. [Usage Examples](#usage-examples)
8. [Troubleshooting](#troubleshooting)

---

## Overview

This configuration uses **possession.nvim** for session management. Sessions allow you to save and restore your Neovim workspace state, including:
- Open buffers and files
- Window layout and splits
- Tab configuration
- Current working directory
- Cursor positions
- Folding states
- Plugin states (nvim-tree, dap, neotest, etc.)

### Key Features

- ✅ Save/load Vim sessions
- ✅ Track last used session
- ✅ Sessions stored in JSON files
- ✅ Store arbitrary data in session files
- ✅ User hooks before/after save/load
- ✅ Uses `:mksession` under the hood
- ✅ Configurable automatic save (with CWD support)
- ✅ Configurable automatic loading (based on CWD)
- ✅ Integration with Snacks picker for session selection
- ✅ Dashboard integration for quick session loading

---

## Plugin: possession.nvim

**Repository:** [jedrzejboczar/possession.nvim](https://github.com/jedrzejboczar/possession.nvim)

**Dependencies:** `nvim-lua/plenary.nvim`

### Configuration

The plugin is configured in `lua/plugins/possession.lua`:

```lua
return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = true,  -- Uses default configuration
  lazy = false, -- Loads immediately (not lazy)
  keys = require('configs.mappings').possession,
}
```

**Current Configuration:** Uses default settings (`opts = true`), which means:
- Session directory: `~/.local/share/nvim/data/possession/`
- Auto-save: Disabled
- Auto-load: Disabled
- Commands: Default names (e.g., `:PossessionSave`, `:PossessionLoad`)

### Available Commands

The plugin provides these commands (with default names):

| Command | Description |
|---------|-------------|
| `:PossessionSave [name]` | Save current session with optional name |
| `:PossessionLoad [name]` | Load a session by name |
| `:PossessionSaveCwd` | Save session based on current working directory |
| `:PossessionLoadCwd` | Load session based on current working directory |
| `:PossessionRename [old] [new]` | Rename a session |
| `:PossessionClose` | Close current session (without loading another) |
| `:PossessionDelete [name]` | Delete a session |
| `:PossessionShow` | Show current session name |
| `:PossessionPick` | Interactive picker for sessions |
| `:PossessionList` | List all sessions |
| `:PossessionListCwd` | List sessions for current working directory |
| `:PossessionMigrate` | Migrate old vimscript sessions to JSON format |

### Plugin API

The plugin exposes several Lua modules:

#### `require('possession')`
Main module with functions:
- `save(name)` - Save current session
- `load(name)` - Load a session
- `close()` - Close current session
- `delete(name)` - Delete a session
- `rename(old, new)` - Rename a session

#### `require('possession.session')`
Session management utilities:
- `get_session_name()` - Get current session name (returns `nil` if not in a session)
- `exists(name)` - Check if session exists

#### `require('possession.query')`
Query utilities for finding sessions:
- `workspaces_with_shortcuts()` - Group sessions by workspace
- `alpha_workspace_layout()` - Generate layout for alpha-nvim

---

## Implementation Details

### 1. Utility Functions (`lua/utils/init.lua`)

The configuration provides wrapper functions for common session operations:

```lua
M.possession = {
  save_session = function()
    local curr_session_name = require('possession.session').get_session_name()
    if curr_session_name then
      -- If already in a session, save to that session
      require('possession').save(curr_session_name)
    else
      -- Otherwise, prompt for a new session name
      vim.ui.input({ prompt = 'Enter name for new session: ' }, 
        function(input) require('possession').save(input) end)
    end
  end,
  
  print_current = function()
    local curr_session_name = require('possession.session').get_session_name()
    if curr_session_name then
      vim.notify('Current session: ' .. curr_session_name)
    else
      vim.notify('Currently not in a session', vim.log.levels.WARN)
    end
  end,
}
```

**Key Behavior:**
- `save_session()`: Smart save that reuses current session name if available
- `print_current()`: Shows current session name or warns if not in a session

### 2. Snacks Picker Integration (`lua/utils/snacks.lua`)

```lua
M.picker.sessions = function() Snacks.picker.projects() end
```

**Note:** The `sessions` picker actually calls `Snacks.picker.projects()`. This is because the Snacks picker's `projects` source is configured to show possession.nvim sessions. The `projects` picker reads from the possession session directory and displays them as selectable items.

### 3. Dashboard Integration (`lua/configs/snacks/dashboard.lua`)

The dashboard automatically displays available sessions:

```lua
local session_key = function(i, name) 
  return { 
    icon = ' ', 
    indent = 4, 
    key = tostring(i), 
    desc = name, 
    action = ':PossessionLoad ' .. name .. '\n' 
  } 
end

local path = vim.fn.stdpath 'data' .. '/possession'
local files = vim.split(vim.fn.glob(path .. '/*.json'), '\n')
if #files > 0 then
  table.insert(keys, { desc = 'Sessions', icon = ' ' })
  for i, file in pairs(files) do
    local name = vim.fs.basename(file):gsub('%.json', ''):gsub('%%20', ' ')
    table.insert(keys, session_key(i, name))
  end
end
```

**Behavior:**
- Scans `~/.local/share/nvim/data/possession/` for `.json` files
- Creates dashboard buttons for each session
- Session names are URL-decoded (replaces `%20` with spaces)
- Clicking a session number loads that session

---

## Keybindings

All session-related keybindings are defined in `lua/configs/mappings.lua`:

### Session Management Keybindings

| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>sl` | `utils.snacks.picker.sessions` | Open session picker (via Snacks) |
| `<leader>ss` | `utils.possession.save_session` | Save current session (smart save) |
| `<leader>sp` | `utils.possession.print_current` | Print current session name |

**Note:** There's a duplicate keybinding for `<leader>sl` in both `M.snacks` and `M.possession` sections. The one in `M.snacks` (line 50) is the primary one.

### Keybinding Breakdown

- **`<leader>sl`** - "**S**ession **L**oad" - Opens picker to select and load a session
- **`<leader>ss`** - "**S**ession **S**ave" - Saves current session
- **`<leader>sp`** - "**S**ession **P**rint" - Shows current session name

---

## Session Storage

### Storage Location

Sessions are stored in:
```
~/.local/share/nvim/data/possession/
```

Or programmatically:
```lua
vim.fn.stdpath('data') .. '/possession'
```

### File Format

Sessions are stored as JSON files with the following structure:

```json
{
  "name": "session-name",
  "cwd": "/path/to/working/directory",
  "user_data": [],
  "plugins": {
    "nvim_tree": [],
    "close_windows": [],
    "dap": [],
    "dapui": [],
    "neotest": {"tabs": []},
    "tabby": [],
    "kulala": {"tabs": []},
    "symbols_outline": [],
    "neo_tree": [],
    "delete_hidden_buffers": [],
    "outline": []
  },
  "vimscript": "let SessionLoad = 1\n..."
}
```

**Components:**
- `name`: Session name
- `cwd`: Working directory when session was saved
- `user_data`: Custom data (empty by default, can be populated via hooks)
- `plugins`: Plugin-specific state data
- `vimscript`: The actual Vim session script (generated by `:mksession`)

### File Naming

- Session files are named: `{session-name}.json`
- Spaces in session names are URL-encoded as `%20` in filenames
- Example: Session "nvim config" → File "nvim%20config.json"

### Current Sessions

Based on the filesystem, example sessions found:
- `activenow.json` - ActiveNow project session
- `nvim%20config.json` - Neovim config session
- `static%20testing%20site.json` - Static testing site session

---

## Integration Points

### 1. Snacks Picker Integration

The session picker uses Snacks' `projects` picker source:

```lua
-- In lua/utils/snacks.lua
M.picker.sessions = function() Snacks.picker.projects() end
```

**How it works:**
- Snacks picker has a built-in `projects` source
- This source reads from the possession session directory
- Displays sessions in a fuzzy-findable list
- Selecting a session loads it via `:PossessionLoad`

### 2. Dashboard Integration

The dashboard (startup screen) automatically lists sessions:

- Sessions appear as numbered buttons (1, 2, 3, etc.)
- Clicking a number loads that session
- Sessions are dynamically loaded from the filesystem
- Only shows if sessions exist

### 3. Plugin State Preservation

The plugin automatically saves/restores state for:
- `nvim-tree` / `neo-tree` - File explorer state
- `dap` / `dapui` - Debugger breakpoints and UI
- `neotest` - Test runner state
- `tabby` - Tab management
- `kulala` - Custom plugin state
- `symbols_outline` / `outline` - Symbol outline windows
- Window layouts (floating windows, splits, etc.)

---

## Usage Examples

### Basic Usage

```lua
-- Save current session
vim.cmd(':PossessionSave my-project')

-- Load a session
vim.cmd(':PossessionLoad my-project')

-- Using the utility functions
require('utils.init').possession.save_session()
require('utils.init').possession.print_current()
```

### Via Keybindings

1. **Save a session:**
   - Press `<leader>ss` (Space + s + s)
   - If already in a session, it saves to that session
   - If not, you'll be prompted for a session name

2. **Load a session:**
   - Press `<leader>sl` (Space + s + l)
   - Use the picker to select a session
   - Press Enter to load

3. **Check current session:**
   - Press `<leader>sp` (Space + s + p)
   - Notification shows current session name

### Via Dashboard

1. Open Neovim (dashboard appears automatically)
2. Look for the "Sessions" section
3. Press the number key corresponding to the session
4. Session loads immediately

### Via Commands

```vim
" Save current session
:PossessionSave my-session

" Load a session
:PossessionLoad my-session

" List all sessions
:PossessionList

" Delete a session
:PossessionDelete my-session

" Show current session
:PossessionShow
```

---

## Troubleshooting

### Session Not Saving

**Problem:** Session doesn't save when using `<leader>ss`

**Solutions:**
1. Check if possession.nvim is loaded: `:lua print(require('possession') ~= nil)`
2. Verify session directory exists: `:lua print(vim.fn.stdpath('data') .. '/possession')`
3. Check for errors: `:messages`

### Session Not Loading

**Problem:** Session doesn't load or loads incorrectly

**Solutions:**
1. Verify session file exists: Check `~/.local/share/nvim/data/possession/`
2. Check session file is valid JSON
3. Try loading manually: `:PossessionLoad session-name`
4. Check for plugin conflicts

### Picker Not Showing Sessions

**Problem:** `<leader>sl` doesn't show sessions

**Solutions:**
1. Verify Snacks picker is enabled
2. Check if sessions exist: `:PossessionList`
3. Verify `Snacks.picker.projects()` works: `:lua Snacks.picker.projects()`

### Dashboard Not Showing Sessions

**Problem:** Sessions don't appear on dashboard

**Solutions:**
1. Check if session files exist in the possession directory
2. Verify dashboard config is loading: Check `lua/configs/snacks/dashboard.lua`
3. Check file permissions on session directory

### Session Name Encoding Issues

**Problem:** Session names with spaces show as `%20`

**Solutions:**
- This is expected behavior (URL encoding)
- The dashboard automatically decodes: `:gsub('%%20', ' ')`
- When using commands, use the encoded name or quotes: `:PossessionLoad "my session"`

---

## Advanced Configuration

### Customizing Session Behavior

To customize possession.nvim, modify `lua/plugins/possession.lua`:

```lua
return {
  'jedrzejboczar/possession.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    session_dir = vim.fn.stdpath('data') .. '/possession',
    autosave = {
      current = false,  -- Auto-save current session
      cwd = false,     -- Auto-save based on CWD
      tmp = false,      -- Auto-save to temp session
      on_load = true,   -- Save before loading new session
      on_quit = true,   -- Save on quit
    },
    autoload = false,   -- Auto-load: false | 'last' | 'auto_cwd' | 'last_cwd'
    -- ... other options
  },
  lazy = false,
  keys = require('configs.mappings').possession,
}
```

### Adding Custom Hooks

You can add hooks to save/restore custom data:

```lua
opts = {
  hooks = {
    before_save = function(name)
      -- Return data to save
      return { custom_data = 'value' }
    end,
    after_load = function(name, user_data)
      -- Use saved data
      if user_data.custom_data then
        -- Do something
      end
    end,
  },
}
```

### Session Options

Control what gets saved in sessions via `sessionoptions`:

```lua
-- In lua/configs/core.lua or similar
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize'
```

See `:help 'sessionoptions'` for available options.

---

## Plugin Documentation Reference

### possession.nvim Official Documentation

**Location:** `~/.local/share/nvim/lazy/possession.nvim/README.md`

**Key Points:**
- Uses JSON files instead of pure Vimscript
- Stores session metadata alongside Vimscript
- Supports hooks for custom data
- Integrates with Telescope
- Supports auto-save and auto-load
- Works with various plugins (nvim-tree, dap, etc.)

### Default Configuration

The plugin uses these defaults when `opts = true`:

- **Session directory:** `~/.local/share/nvim/data/possession/`
- **Auto-save:** Disabled
- **Auto-load:** Disabled
- **Commands:** Full names (e.g., `:PossessionSave`)
- **Plugins:** All supported plugins enabled
- **Telescope:** Enabled (but not used in this config)

### Supported Plugins

The plugin automatically handles state for:
- nvim-tree / neo-tree
- symbols-outline / outline
- tabby
- dap / dapui
- neotest
- kulala
- Window layouts
- Hidden buffers (optional)

---

## Summary

### Quick Reference

| Action | Method |
|--------|--------|
| Save session | `<leader>ss` or `:PossessionSave name` |
| Load session | `<leader>sl` or `:PossessionLoad name` |
| Show current | `<leader>sp` or `:PossessionShow` |
| List sessions | `:PossessionList` |
| Delete session | `:PossessionDelete name` |

### File Locations

- **Plugin config:** `lua/plugins/possession.lua`
- **Utilities:** `lua/utils/init.lua` (M.possession)
- **Keybindings:** `lua/configs/mappings.lua` (M.possession)
- **Dashboard:** `lua/configs/snacks/dashboard.lua`
- **Session storage:** `~/.local/share/nvim/data/possession/`

### Key Functions

- `require('possession').save(name)` - Save session
- `require('possession').load(name)` - Load session
- `require('possession.session').get_session_name()` - Get current session name
- `Snacks.picker.projects()` - Open session picker

---

*Last updated: Based on current configuration analysis*
