-- Automatically adds closing brackets, quotes, and parentheses
return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    keys = require 'configs.mappings'.autopairs,
}
