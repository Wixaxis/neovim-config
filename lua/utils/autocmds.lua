local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local lsp_mappings = require('configs.mappings').lsp_mappings
      require('utils.init').set_keymaps(lsp_mappings, { buffer = ev.buf })
    end,
  })

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    pattern = '*',
  })

  -- Automatically resize splits when resizing the Neovim window
  vim.api.nvim_create_autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('ResizeSplits', { clear = true }),
    pattern = '*',
    callback = function()
      vim.cmd 'wincmd ='
    end,
  })
end

return M
