return {
  'stevearc/resession.nvim',
  lazy = false,
  dependencies = {
    { 'tiagovla/scope.nvim', lazy = false, config = true },
  },
  opts = {
    extensions = {
      scope = {},
      bufferline = {},
    },
    dir = '.nvim-session',
    autosave = {
      enabled = false,
      interval = 60,
      notify = false,
    },
    load_detail = true,
    load_order = 'modification_time',
    options = {
      'binary',
      'bufhidden',
      'buflisted',
      'cmdheight',
      'diff',
      'filetype',
      'modifiable',
      'previewwindow',
      'readonly',
      'scrollbind',
      'winfixheight',
      'winfixwidth',
    },
  },
  config = function(_, opts)
    local resession = require('resession')
    resession.setup(opts)

    local loading = false
    local autocmd_id = nil

    local function load_buf(bufnr, winid)
      if not vim.api.nvim_buf_is_valid(bufnr) then return false end
      local name = vim.api.nvim_buf_get_name(bufnr)
      if not name or name == '' or not vim.bo[bufnr].buflisted or vim.fn.filereadable(name) ~= 1 then return false end
      local loaded = vim.api.nvim_buf_is_loaded(bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
      if not loaded or (vim.api.nvim_buf_line_count(bufnr) <= 1 and (lines[1] or '') == '') then
        return pcall(function()
          if winid and vim.api.nvim_win_is_valid(winid) then vim.api.nvim_set_current_win(winid) end
          vim.fn.bufload(bufnr)
          vim.cmd('silent! edit ' .. vim.fn.fnameescape(name))
        end)
      end
      return true
    end

    local function fix_windows()
      local cur_tab = vim.api.nvim_get_current_tabpage()
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        if vim.api.nvim_tabpage_is_valid(tab) then
          vim.api.nvim_set_current_tabpage(tab)
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              local name = vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) or ''
              local empty = name == '' or not vim.bo[buf].buflisted
              if empty then
                for _, b in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.api.nvim_buf_is_valid(b) then
                    local n = vim.api.nvim_buf_get_name(b)
                    if n and n ~= '' and vim.bo[b].buflisted then
                      local used = false
                      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                        if w ~= win and vim.api.nvim_win_is_valid(w) and vim.api.nvim_win_get_buf(w) == b then
                          used = true
                          break
                        end
                      end
                      if not used then
                        pcall(function()
                          vim.api.nvim_set_current_win(win)
                          vim.api.nvim_win_set_buf(win, b)
                          load_buf(b, win)
                        end)
                        break
                      end
                    end
                  end
                end
              else
                pcall(function()
                  vim.api.nvim_set_current_win(win)
                  vim.api.nvim_win_set_buf(win, buf)
                  load_buf(buf, win)
                end)
              end
            end
          end
        end
      end
      vim.api.nvim_set_current_tabpage(cur_tab)
    end

    local function handle_event(event)
      if not loading then return end
      vim.schedule(function()
        if event.event == 'TabEnter' then
          local tab = vim.api.nvim_get_current_tabpage()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              local name = vim.api.nvim_buf_get_name(buf)
              if name and name ~= '' then
                pcall(function()
                  vim.api.nvim_set_current_win(win)
                  vim.api.nvim_win_set_buf(win, buf)
                  load_buf(buf, win)
                end)
              end
            end
          end
        elseif event.event == 'BufEnter' or event.event == 'WinEnter' then
          local buf = event.buf or vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
          local win = vim.api.nvim_get_current_win()
          load_buf(buf, win)
          if vim.api.nvim_buf_is_valid(buf) then
            pcall(function() vim.api.nvim_win_set_buf(win, buf) end)
          end
        end
      end)
    end

    resession.add_hook('pre_load', function() loading = true end)
    resession.add_hook('post_load', function()
      vim.defer_fn(function()
        vim.schedule(function()
          fix_windows()
          if autocmd_id then pcall(vim.api.nvim_del_autocmd, autocmd_id) end
          autocmd_id = vim.api.nvim_create_autocmd({ 'TabEnter', 'BufEnter', 'WinEnter' }, {
            callback = handle_event,
            desc = 'Load buffers after session restore',
          })
          vim.defer_fn(function()
            loading = false
            if autocmd_id then
              pcall(vim.api.nvim_del_autocmd, autocmd_id)
              autocmd_id = nil
            end
          end, 2000)
        end)
      end, 100)
    end)

    local function try_load()
      local argc = vim.fn.argc(-1)
      local should = (argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1))
      if should and not vim.g.using_stdin and not resession.get_current() then
        resession.load(vim.fn.getcwd(), { dir = '.nvim-session', silence_errors = true })
        local curr = resession.get_current()
        if curr then vim.notify('Auto-loaded session: ' .. curr, vim.log.levels.INFO) end
      end
    end

    vim.api.nvim_create_autocmd('User', { pattern = 'LazyDone', callback = try_load, once = true })
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local argc = vim.fn.argc(-1)
        local should = (argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1))
        if should and not vim.g.using_stdin then vim.defer_fn(try_load, 500) end
      end,
      nested = true,
    })
    vim.api.nvim_create_autocmd('StdinReadPre', { callback = function() vim.g.using_stdin = true end })
  end,
  keys = require('configs.mappings').resession,
}
