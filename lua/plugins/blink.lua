return {

    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',

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
        },

        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = 'mono'
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        completion = {
            list = {
                selection = {
                    preselect = false
                }
            }
        }
    },
    opts_extend = { "sources.default" }
}
