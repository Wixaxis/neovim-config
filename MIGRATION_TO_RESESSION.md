# Migration from possession.nvim to resession.nvim

## Changes Made

### ✅ Plugin Replacement
- **Removed:** `lua/plugins/possession.lua`
- **Added:** `lua/plugins/resession.lua`
  - Configured for project-root storage (`.nvim-session/` directory)
  - Integrated with scope.nvim extension
  - Auto-save on exit
  - Auto-load on startup (when no args)

### ✅ Scope.nvim Integration
- Updated `lua/plugins/scope.lua` to load before resession (required for extension)
- Added `lazy = false` to ensure scope loads first

### ✅ Keybindings Updated
- **Removed:** `M.possession` mappings
- **Added:** `M.resession` mappings:
  - `<leader>ss` - Save session to project root
  - `<leader>sl` - Load session from project root
  - `<leader>sd` - Delete session from project root
  - `<leader>sp` - Print current session name

### ✅ Utility Functions Updated
- **Removed:** `M.possession` functions (used possession.nvim API)
- **Added:** `M.resession` functions (use resession.nvim API)
  - All functions now save/load from project root (`.nvim-session/`)

### ✅ Dashboard Updated
- **Removed:** Session display code (lines 10-19)
- Sessions no longer appear on dashboard

### ✅ Removed Duplicate Keybinding
- Removed `<leader>sl` from `M.snacks` section (was duplicate)

## New Session Storage

### Old Location (possession.nvim)
```
~/.local/share/nvim/data/possession/*.json
```

### New Location (resession.nvim)
```
{project-root}/.nvim-session/{session-name}.json
```

Sessions are now stored **in each project's root directory** instead of a global location.

## Key Features

### ✅ Project-Root Storage
Sessions are automatically saved to `.nvim-session/` in each project's root directory.

### ✅ Scope.nvim Integration
Native extension support - scope.nvim state is automatically saved/restored with sessions.

### ✅ Auto-Save
- Saves session on exit (`VimLeavePre`)
- Periodic auto-save every 60 seconds (background)

### ✅ Auto-Load
- Automatically loads session when opening Neovim in a project directory
- Only loads if no file arguments provided
- Silently fails if no session exists (no errors)

### ✅ Bufferline Compatible
Works seamlessly with bufferline.nvim - tabs and buffers are preserved.

## Usage

### Manual Commands
- `<leader>ss` - Save current session
- `<leader>sl` - Load session for current project
- `<leader>sd` - Delete session for current project
- `<leader>sp` - Show current session name

### Automatic Behavior
- Session auto-saves on exit
- Session auto-loads on startup (if in project directory)
- Session auto-saves every 60 seconds while working

## Configuration

The plugin is configured in `lua/plugins/resession.lua`:

```lua
opts = {
  extensions = { scope = {} }, -- Native scope.nvim support
  dir = '.nvim-session', -- Store in project root
  autosave = {
    enabled = true,
    interval = 60,
    notify = false,
  },
}
```

## Migration Notes

### Old Sessions
Old sessions in `~/.local/share/nvim/data/possession/` are **not migrated**. You can:
1. Delete them (you said you don't care about existing sessions)
2. Manually migrate if needed (not recommended)

### .gitignore
Consider adding `.nvim-session/` to your project `.gitignore` files if you don't want to commit session files.

## Testing

After restarting Neovim:
1. Open a project directory
2. Open some files, create splits, etc.
3. Exit Neovim (`:qa`)
4. Reopen Neovim in the same directory
5. Session should auto-load with all your buffers/windows restored

## Troubleshooting

### Session Not Loading
- Check if `.nvim-session/` directory exists in project root
- Check if session file exists
- Verify scope.nvim is loaded (required for extension)

### Session Not Saving
- Check file permissions in project directory
- Verify resession.nvim is loaded
- Check `:messages` for errors

---

*Migration completed successfully*
