return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    commander = require 'configs.mappings'.autopairs,
}
