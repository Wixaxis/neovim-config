return {
    'folke/which-key.nvim',
    opts = {
        preset = 'helix',
    },
    commander = { {
        keys = { 'n', '<leader>?', { desc = 'which-key - show local bufer keymaps' } },
        cmd = function() require 'which-key'.show({ global = false }) end,
        desc = 'which-key - show local bufer keymaps'
    } }
}
