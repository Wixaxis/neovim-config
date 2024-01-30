return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    commander = {
        {
            cmd = function()
                require 'nvim-autopairs'.disable()
                vim.notify('autopairs disabled')
            end,
            desc = 'autopairs - disable'
        },
        {
            cmd = function()
                require 'nvim-autopairs'.enable()
                vim.notify('autopairs enabled')
            end,
            desc = 'autopairs - enable'
        },
    }
}
