vim.filetype.add {
  pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
  extension = { slim = 'slim', ['html.slim'] = 'slim' },
}

local query = vim.treesitter.query
local mimetype_language_aliases = {
  importmap = 'json',
  module = 'javascript',
  ['application/ecmascript'] = 'javascript',
  ['text/ecmascript'] = 'javascript',
}
local markdown_info_string_aliases = {
  ex = 'elixir',
  pl = 'perl',
  sh = 'bash',
  uxn = 'uxntal',
  ts = 'typescript',
}

local function safe_node_text(node, source, opts)
  local ok, text = pcall(vim.treesitter.get_node_text, node, source, opts)
  if ok and type(text) == 'string' then return text end
end

local function parser_from_markdown_info_string(alias)
  local match = vim.filetype.match { filename = 'a.' .. alias }
  return match or markdown_info_string_aliases[alias] or alias
end

query.add_directive('set-lang-from-mimetype!', function(match, _, source, pred, metadata)
  local node = match[pred[2]]
  local type_attr_value = node and safe_node_text(node, source)
  if not type_attr_value or type_attr_value == '' then return end

  local configured = mimetype_language_aliases[type_attr_value]
  if configured then
    metadata['injection.language'] = configured
    return
  end

  local parts = vim.split(type_attr_value, '/', {})
  metadata['injection.language'] = parts[#parts]
end, { force = true })

query.add_directive('set-lang-from-info-string!', function(match, _, source, pred, metadata)
  local node = match[pred[2]]
  local injection_alias = node and safe_node_text(node, source)
  if not injection_alias or injection_alias == '' then return end

  metadata['injection.language'] = parser_from_markdown_info_string(injection_alias:lower())
end, { force = true })

query.add_directive('downcase!', function(match, _, source, pred, metadata)
  local capture_id = pred[2]
  local node = match[capture_id]
  local text = node and safe_node_text(node, source, { metadata = metadata[capture_id] }) or ''
  if not metadata[capture_id] then metadata[capture_id] = {} end
  metadata[capture_id].text = text:lower()
end, { force = true })

---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' }, -- 'slim',
  sync_install = false,
  auto_install = true,
  -- slim treesitter config is broken, crashes and has memory leak as of 1.07.2025
  ignore_install = { 'slim' },
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ['<leader>a'] = '@parameter.inner',
    --   },
    --   swap_previous = {
    --     ['<leader>A'] = '@parameter.inner',
    --   },
    -- },
  },
}
