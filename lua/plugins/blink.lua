-- Intelligent code completion with multiple sources like LSP, snippets, and AI
return {
    { 'saghen/blink.compat', version = '*', lazy = true, opts = {} },
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'folke/lazydev.nvim',
            'Kaiser-Yang/blink-cmp-avante'
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
                default = { 'avante', 'lsp', 'lazydev', 'path', 'snippets', 'cmdline', 'buffer' },
                providers = {
                    lazydev  = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
                    markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink', fallbacks = { 'lsp' } },
                    avante   = { name = 'Avante', module = 'blink-cmp-avante' }
                }
            },
            completion = {
                list = { selection = { preselect = false } },
                documentation = { auto_show = true, auto_show_delay_ms = 400 },
                ghost_text = { enabled = true },
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon' }, { 'label', 'label_description', 'source_name', gap = 1 },
                        }
                    }
                },
            }
        },
        opts_extend = { "sources.default" }
    }
}
