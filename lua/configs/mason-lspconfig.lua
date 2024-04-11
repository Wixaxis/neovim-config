local M = {}

M.on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  for _, v in ipairs(require('configs.mappings').lsp_mappings) do
    nmap(v[1], v[2], v[3])
  end

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require 'lspconfig'.coffeesense.setup {
  cmd = { 'npx', 'coffeesense-language-server' ,'--stdio' },
}

M.servers = {
  html = { filetypes = { 'html', 'slim' } },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').default_capabilities(M.capabilities)

M.mason_lspconfig = require 'mason-lspconfig'

M.mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(M.servers),
}



M.mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == 'jdtls' then return ;end
    if M.servers[server_name] == nil then
      require 'lspconfig'[server_name].setup {
        capabilities = M.capabilities,
        on_attach = M.on_attach,
      }
    else
      require('lspconfig')[server_name].setup {
        capabilities = M.capabilities,
        on_attach = M.on_attach,
        settings = M.servers[server_name],
        filetypes = (M.servers[server_name] or {}).filetypes,
      }
    end
  end
}

return M
