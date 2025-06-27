-- Provides better UI for messages, command line, and notifications
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- messages = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },
  },
  dependencies = { 'MunifTanjim/nui.nvim' },
}
