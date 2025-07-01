local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
      vim.notify(vim.lsp.status(), 'info', {
        id = 'lsp_progress',
        title = 'LSP Progress',
        opts = function(notif)
          notif.style = 'minimal'
          notif.icon = ev.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local bufnr = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then return end

      local lsp_mappings = require('configs.mappings').lsp_mappings
      require('utils.init').set_keymaps(lsp_mappings, { buffer = bufnr })
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
