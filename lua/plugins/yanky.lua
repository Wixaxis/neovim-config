return {
    "gbprod/yanky.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        require 'yanky'.setup {}
        require("telescope").load_extension("yank_history")
    end,
    commander = { {
        keys = { 'n', '<leader>p', { desc = '[P]aste from yank history' } },
        cmd = ':Telescope yank_history\n',
        desc = 'open yank history & paste here'
    } },
}
