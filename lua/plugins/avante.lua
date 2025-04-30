return {
    "yetone/avante.nvim",
    lazy = false,
    version = false,
    opts = {
        provider = "claude",
        cursor_applying_provider = 'gemini',
        behaviour = {
            enable_cursor_planning_mode = false,
        },
        claude = {
            max_tokens = 4096,
        },
        gemini = {
            max_tokens = 32768,
        }
    },
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = { insert_mode = true },
                },
            },
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = { file_types = { "markdown", "Avante" } },
            ft = { "markdown", "Avante" },
        },
    },
}
