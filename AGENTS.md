## Build/Lint/Test Commands

- **Linting**: Run `stylua .` to format Lua files.
- **Testing**: Tests are run from within Neovim using the `neotest` plugin. There are no specific command-line test commands.

## Code Style Guidelines

- **Formatting**: Follow the rules in `.stylua.toml`.
  - `column_width = 160`
  - `indent_type = "Spaces"`
  - `indent_width = 2`
  - `quote_style = "AutoPreferSingle"`
- **Types**: Add types where possible, but it's not strictly required.
- **Naming Conventions**:
  - Use `snake_case` for variables and function names.
  - Use `PascalCase` for modules that return a table with functions.
- **Error Handling**: Use `pcall` and `xpcall` for error handling where appropriate.
- **Imports/Requires**:
  - Use `require` to import modules.
  - Group requires at the top of the file.
