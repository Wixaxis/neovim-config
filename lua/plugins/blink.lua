return {
    { 'saghen/blink.compat', version = '*', lazy = true, opts = {} },
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'folke/lazydev.nvim'
        },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'none',

                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<Right>'] = { 'snippet_forward', 'fallback' },
                ['<Left>'] = { 'snippet_backward', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<PageUp>'] = { 'scroll_documentation_up', 'fallback' },
                ['<PageDown>'] = { 'scroll_documentation_down', 'fallback' },
                ['<Esc>'] = { 'cancel', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono'
            },

            sources = {
                -- default = { 'lazydev', 'avante_commands', 'avante_files', 'avante_mentions', 'path', 'snippets', 'buffer' },
                default = { 'lazydev', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- score_offset = 100,
                    },
                    -- avante_commands = {
                    --     name = "avante_commands",
                    --     module = "blink.compat.source",
                    --     score_offset = 90,
                    --     opts = {},
                    -- },
                    -- avante_files = {
                    --     name = "avante_files",
                    --     module = "blink.compat.source",
                    --     score_offset = 100,
                    --     opts = {},
                    -- },
                    -- avante_mentions = {
                    --     name = "avante_mentions",
                    --     module = "blink.compat.source",
                    --     score_offset = 1000,
                    --     opts = {},
                    -- },
                }
            },

            completion = {
                list = {
                    selection = {
                        preselect = false
                    }
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 400,
                },
                ghost_text = { enabled = true },
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon' },
                            { 'label', 'label_description','source_name', gap = 1 },
                        },
                    }
                }
            }
        },
        opts_extend = { "sources.default" }
    }
}
