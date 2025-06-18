return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    keys = require 'configs.mappings'.autopairs,
}
