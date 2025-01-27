return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-rspec",
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('neotest').setup({
            adapters = {
                require 'neotest-rspec' ({
                    filter_dirs = { '.git', 'node_modules', 'concerns', 'api' }
                })
            },
            status = {
                enabled = true,
                virtual_text = false,
                signs = true,
            }
        })
    end,
    commander = require 'configs.mappings'.neotest,
}
