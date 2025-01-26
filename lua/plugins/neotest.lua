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
        require('neotest').setup({
            adapters = {
                require 'neotest-rspec'({
                    filter_dirs = { '.git', 'node_modules', 'concerns', 'api'}
                })
            },
            status = {
                enabled = true,
                virtual_text = false,
                signs = true,
            }
        })
    end,
    commander = { {
        keys = { 'n', '<leader>tec', { desc = 'NeoTest - [Te]st [c]losest' } },
        cmd = function()
            require('neotest').run.run()
            require('neotest').summary.open()
        end,
        decs = 'NeoTest - [te]st [c]losest'
    }, {
        keys = { 'n', '<leader>tes', { desc = 'NeoTest - toggle [te]sts [s]ummary panel' } },
        cmd = function()
            require('neotest').summary.toggle()
        end,
        decs = 'NeoTest - open [te]sts [s]ummary panel'
    }, {
        keys = { 'n', '<leader>tea', { desc = 'NeoTest - [Te]st [a]ll' } },
        cmd = function()
            require('neotest').run.run(vim.fn.getcwd())
            require('neotest').summary.open()
        end,
        decs = 'NeoTest - [Te]st [a]ll'
    }, {
        keys = { 'n', '<leader>tef', { desc = 'NeoTest - [Te]st [f]ile' } },
        cmd = function()
            require('neotest').run.run(vim.fn.expand("%"))
            require('neotest').summary.open()
        end,
        decs = 'NeoTest - [Te]st [f]ile'
    } }
}
