return {
    "yetone/avante.nvim",
    event = 'VeryLazy',
    lazy = false,
    version = false,
    opts = {
        provider = 'openrouter-claude-sonnet-4',
        vendors = {
            -- OpenAI GPT Models
            ["openrouter-gpt-4.1"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/gpt-4.1",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gpt-4.1-mini"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/gpt-4.1-mini",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gpt-4.1-nano"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/gpt-4.1-nano",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gpt-4o"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/gpt-4o-2024-11-20",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-o4-mini-high"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/o4-mini-high",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-o4-mini"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "openai/o4-mini",
                api_key_name = "OPENROUTER_API_KEY",
            },

            -- Anthropic Claude Models
            ["openrouter-claude-opus-4"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "anthropic/claude-opus-4",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-claude-sonnet-4"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "anthropic/claude-sonnet-4",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-claude-3.7-sonnet"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "anthropic/claude-3.7-sonnet",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-claude-3.5-haiku"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "anthropic/claude-3.5-haiku-20241022",
                api_key_name = "OPENROUTER_API_KEY",
            },

            -- Google Gemini Models
            ["openrouter-gemini-2.5-pro-preview"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "google/gemini-2.5-pro-preview",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gemini-2.5-flash-preview"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "google/gemini-2.5-flash-preview-05-20",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gemini-2.0-flash"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "google/gemini-2.0-flash-001",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-gemini-2.0-flash-lite"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "google/gemini-2.0-flash-lite-001",
                api_key_name = "OPENROUTER_API_KEY",
            },

            -- DeepSeek Models
            ["openrouter-deepseek-r1"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "deepseek/deepseek-r1:free",
                api_key_name = "OPENROUTER_API_KEY",
            },
            ["openrouter-deepseek-v3"] = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "deepseek/deepseek-chat-v3-0324:free",
                api_key_name = "OPENROUTER_API_KEY",
            },
        },
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
