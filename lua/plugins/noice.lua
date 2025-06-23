-- Provides better UI for messages, command line, and notifications
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = { notify = { enabled = false } },
    dependencies = { "MunifTanjim/nui.nvim" }
}
