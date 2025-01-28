return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require 'harpoon'
        harpoon:setup()
        require 'commander'.add(require 'configs.mappings'.harpoon(harpoon), {})
    end,
}
