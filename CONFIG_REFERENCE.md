# Neovim Configuration Reference

This document provides a comprehensive guide to navigating and modifying this Neovim configuration.

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Initialization Flow](#initialization-flow)
4. [Key Components](#key-components)
5. [Common Patterns](#common-patterns)
6. [How to Make Changes](#how-to-make-changes)

---

## Overview

This Neovim configuration is organized using a modular structure with clear separation of concerns:
- **Configs**: Core Neovim settings and configurations
- **Plugins**: Plugin definitions and configurations (managed by Lazy.nvim)
- **Utils**: Utility functions and helpers
- **Defaults**: Default settings and theme preferences

---

## Directory Structure

```
nvim/
├── init.lua                    # Entry point - loads all configuration
├── defaults.lua                # Default settings (themes, neovide config)
├── .stylua.toml                # Lua formatting rules
│
├── lua/
│   ├── configs/                # Core Neovim configurations
│   │   ├── core.lua            # Basic Neovim options and keymaps
│   │   ├── mappings.lua        # Keymap definitions organized by feature
│   │   ├── lsp.lua             # LSP configuration
│   │   ├── neovide.lua         # Neovide-specific settings
│   │   ├── nvim-treesitter.lua # Treesitter configuration
│   │   └── snacks/             # Snacks plugin configurations
│   │       ├── dashboard.lua
│   │       └── indent.lua
│   │
│   ├── plugins/                # Plugin definitions (Lazy.nvim)
│   │   ├── *.lua               # One file per plugin/plugin group
│   │   └── ...                 # See full list below
│   │
│   └── utils/                  # Utility modules
│       ├── init.lua            # Main utility module (exports all utils)
│       ├── lazy_installer.lua  # Ensures Lazy.nvim is installed
│       ├── autocmds.lua        # Autocommand definitions
│       ├── lsp.lua             # LSP utility functions
│       ├── neovide.lua         # Neovide utilities
│       └── snacks.lua          # Snacks plugin utilities
│
├── ftplugin/                   # Filetype-specific configurations
│   ├── coffee.lua
│   └── java.lua
│
└── lang-servers/               # Language server configurations
    └── intellij-java-google-style.xml
```

---

## Initialization Flow

The configuration loads in this order (as defined in `init.lua`):

1. **`configs.core`** - Sets basic Neovim options (leader, numbers, clipboard, etc.)
2. **`utils.lazy_installer`** - Ensures Lazy.nvim is installed
3. **`lazy.setup`** - Loads all plugins from `lua/plugins/` directory
4. **`utils.init.set_default_colorscheme`** - Sets the default theme
5. **`configs.mappings.assign_base_mappings`** - Sets base keymaps
6. **`configs.neovide`** - Neovide-specific config (if running in Neovide)
7. **`configs.nvim-treesitter`** - Treesitter setup
8. **`utils.autocmds.setup`** - Sets up autocommands
9. **`configs.lsp`** - LSP configuration

---

## Key Components

### 1. Entry Point: `init.lua`

The main entry point that orchestrates the entire configuration. It:
- Loads core settings
- Installs/loads Lazy.nvim
- Loads all plugins
- Sets up themes, mappings, and autocommands

### 2. Core Configuration: `lua/configs/`

#### `core.lua`
- Sets global Neovim options (`vim.opt`, `vim.g`)
- Defines basic keymaps (leader, escape, movement)
- **Modify here for**: Basic editor behavior, default options

#### `mappings.lua`
- Centralized keymap definitions organized by feature
- Uses `utils.init.set_keymaps()` helper
- **Structure**: Each feature has its own table (e.g., `M.snacks`, `M.lsp_mappings`)
- **Modify here for**: Adding/changing keybindings

#### `lsp.lua`
- LSP server configuration
- **Modify here for**: LSP settings, server-specific configs

#### `neovide.lua`
- Neovide GUI-specific settings
- **Modify here for**: Font, transparency, cursor settings

#### `nvim-treesitter.lua`
- Treesitter parser configuration
- **Modify here for**: Syntax highlighting, parser settings

### 3. Plugins: `lua/plugins/`

Each plugin has its own file. Plugins are automatically discovered by Lazy.nvim.

**Current plugins:**
- `auto-dark-mode.lua` - Automatic theme switching
- `auto-save.lua` - Auto-save functionality
- `autopairs.lua` - Auto-pairing brackets/quotes
- `barbecue.lua` - Winbar/breadcrumbs
- `better-escape.lua` - Better escape key behavior
- `blink.lua` - Blink plugin
- `bufferline.lua` - Buffer/tab management
- `colorizer.lua` - Color highlighting
- `comment.lua` - Comment toggling
- `gitsigns.lua` - Git signs in gutter
- `grug-far.lua` - Find and replace
- `lazydev.lua` - Lazy.nvim development helpers
- `lualine.lua` - Statusline
- `mason-lspconfig.lua` - LSP server installation
- `neotest.lua` - Testing framework
- `noice.lua` - UI improvements
- `nvim-cursorline.lua` - Cursor line highlighting
- `nvim-jdtls.lua` - Java LSP configuration
- `nvim-treesitter.lua` - Syntax parsing
- `nvim-ufo.lua` - Folding
- `possession.lua` - Session management
- `rails.lua` - Rails support
- `render-markdown.lua` - Markdown rendering
- `scope.lua` - Scope plugin
- `sidekick.lua` - AI assistant
- `snacks.lua` - Snacks plugin suite
- `suda.lua` - Sudo write support
- `theme.lua` - Theme collection
- `todo-comments.lua` - TODO highlighting
- `transparent.lua` - Transparent background
- `trouble.lua` - Diagnostics UI
- `vim-sleuth.lua` - Auto-detect indentation
- `visual-whitespace.lua` - Whitespace visualization
- `which-key.lua` - Keybinding hints
- `yanky.lua` - Yank history

**To add a plugin:**
1. Create a new file in `lua/plugins/` (e.g., `my-plugin.lua`)
2. Return a table with plugin configuration (see existing files for examples)
3. Lazy.nvim will automatically load it

**To modify a plugin:**
- Edit the corresponding file in `lua/plugins/`

### 4. Utilities: `lua/utils/`

#### `init.lua`
- Main utility module that exports all helper functions
- Contains helper functions for:
  - Keymap setting (`set_keymaps`)
  - Theme management (`set_default_colorscheme`)
  - Plugin-specific utilities (bufferline, comment, gitsigns, etc.)

#### `lazy_installer.lua`
- Ensures Lazy.nvim is installed before use
- **Don't modify** unless changing installation method

#### `autocmds.lua`
- Defines autocommands (LspAttach, TextYankPost, VimResized, etc.)
- **Modify here for**: Adding new autocommands

#### `lsp.lua`
- LSP utility functions (rename, code actions, goto definitions, etc.)
- **Modify here for**: LSP-related helper functions

#### `snacks.lua`
- Utilities for the Snacks plugin suite
- **Modify here for**: Snacks-specific helpers

#### `neovide.lua`
- Neovide-specific utilities
- **Modify here for**: Neovide helper functions

### 5. Defaults: `defaults.lua`

Contains default settings:
- `dark_theme` / `light_theme` - Theme names
- `neovide` - Neovide GUI settings (font, size, transparency, etc.)

**Modify here for**: Default themes, Neovide appearance

---

## Common Patterns

### Keymap Definition Pattern

Keymaps are defined in `configs/mappings.lua` using this structure:

```lua
M.feature_name = {
  { '<key>', function_or_string, desc = 'description', mode = 'n' },
  -- mode can be 'n', 'v', 'i', 't', or a table like { 'n', 'v' }
}
```

Then applied using:
```lua
require('utils.init').set_keymaps(M.feature_name)
```

### Plugin Definition Pattern

Plugins in `lua/plugins/` follow this pattern:

```lua
return {
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({
      -- configuration options
    })
  end,
  -- other Lazy.nvim options (dependencies, event, etc.)
}
```

### Utility Function Pattern

Utilities in `lua/utils/init.lua` are organized by plugin/feature:

```lua
M.plugin_name = {
  action_name = function()
    -- implementation
  end,
}
```

---

## How to Make Changes

### Adding a New Keybinding

1. Open `lua/configs/mappings.lua`
2. Find the appropriate feature section (or create a new one)
3. Add a new keymap entry:
   ```lua
   { '<leader>xx', function() -- action -- end, desc = 'description' },
   ```
4. If it's a new feature section, make sure it's applied in the appropriate place

### Adding a New Plugin

1. Create a new file in `lua/plugins/` (e.g., `my-plugin.lua`)
2. Add the plugin definition:
   ```lua
   return {
     'author/plugin-name',
     config = function()
       require('plugin-name').setup({})
     end,
   }
   ```
3. Lazy.nvim will automatically load it on next Neovim start

### Modifying Core Settings

1. **Basic options**: Edit `lua/configs/core.lua`
2. **LSP settings**: Edit `lua/configs/lsp.lua`
3. **Treesitter**: Edit `lua/configs/nvim-treesitter.lua`
4. **Neovide**: Edit `lua/configs/neovide.lua` or `defaults.lua` (for GUI settings)

### Adding a New Autocommand

1. Open `lua/utils/autocmds.lua`
2. Add to the `setup()` function:
   ```lua
   vim.api.nvim_create_autocmd('EventName', {
     callback = function() -- action -- end,
     group = vim.api.nvim_create_augroup('GroupName', { clear = true }),
     pattern = '*',
   })
   ```

### Adding a New Utility Function

1. Open `lua/utils/init.lua`
2. Add to the appropriate section (or create a new one):
   ```lua
   M.feature_name = {
     function_name = function()
       -- implementation
     end,
   }
   ```

### Changing Default Theme

1. Open `defaults.lua`
2. Modify `dark_theme` or `light_theme` values
3. Available themes are listed in `lua/plugins/theme.lua`

### Filetype-Specific Configuration

1. Create or edit a file in `ftplugin/` directory
2. Name it after the filetype (e.g., `python.lua`)
3. Add filetype-specific settings

---

## Code Style

- **Formatting**: Run `stylua .` to format Lua files
- **Column width**: 160 characters
- **Indentation**: 2 spaces
- **Quote style**: Auto-prefer single quotes
- **Naming**: `snake_case` for variables/functions, `PascalCase` for modules

---

## Quick Reference: Key Files

| File | Purpose | When to Edit |
|------|---------|--------------|
| `init.lua` | Entry point | Changing load order, adding initialization steps |
| `lua/configs/core.lua` | Basic Neovim options | Changing editor defaults |
| `lua/configs/mappings.lua` | All keybindings | Adding/modifying keymaps |
| `lua/configs/lsp.lua` | LSP configuration | LSP server settings |
| `lua/plugins/*.lua` | Plugin definitions | Adding/configuring plugins |
| `lua/utils/init.lua` | Utility functions | Adding helper functions |
| `lua/utils/autocmds.lua` | Autocommands | Adding event handlers |
| `defaults.lua` | Default settings | Changing themes, Neovide settings |

---

## Tips

1. **Use Lazy.nvim UI**: Press `<leader>ll` to open the Lazy.nvim interface
2. **Check keymaps**: Press `<leader>?` to see local keymaps, `<leader><leader>` for all keymaps
3. **Reload config**: After changes, run `:source %` or restart Neovim
4. **Format code**: Run `:!stylua %` to format the current file
5. **Plugin docs**: Check `plugin_docs/` directory if it exists for plugin documentation

---

## Common Tasks

### Find a Keybinding
- Search in `lua/configs/mappings.lua` for the key sequence
- Or use `<leader><leader>` to open the keymap picker

### Find a Plugin Configuration
- Look in `lua/plugins/` for the plugin name
- Check the plugin's documentation for available options

### Debug LSP Issues
- Check `lua/configs/lsp.lua` for server configurations
- Check `lua/utils/lsp.lua` for LSP utility functions
- Use `:LspInfo` to see active LSP servers

### Change Theme
- Edit `defaults.lua` to change default theme
- Or use `<leader>th` to pick a theme interactively

---

*Last updated: Based on current configuration structure*
