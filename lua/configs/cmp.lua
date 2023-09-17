local cmp = require 'cmp'
local luasnip = require 'luasnip'
local mappings = require 'configs.mappings'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = mappings.cmp_mappings(cmp, luasnip),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
