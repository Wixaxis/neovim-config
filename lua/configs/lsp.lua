vim.lsp.config('ruby_lsp', {
  settings = {
    rubyLsp = {
      ['rubyLsp.addonSettings'] = {
        ['Ruby LSP Rails'] = {
          enablePendingMigrationsPrompt = false,
        },
      },
    },
  },
})
