return {
    "gbprod/yanky.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        require 'yanky'.setup {}
        require("telescope").load_extension("yank_history")
    end,
    commander = require 'configs.mappings'.yanky,
}
