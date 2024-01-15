return {
    "gbprod/yanky.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        require 'yanky'.setup {}
        require("telescope").load_extension("yank_history")
    end,
    commander = { {
        keys = { 'n', '<leader>p' },
        cmd = ':Telescope yank_history\n',
        desc = '[P]aste from yank history'
    } },
}
