-- Session management with project-root storage and scope.nvim integration
return {
  'stevearc/resession.nvim',
  lazy = false, -- Load immediately so auto-load works
  dependencies = {
    { 'tiagovla/scope.nvim', lazy = false, config = true },
  },
  opts = {
    extensions = {
      scope = {}, -- Native scope.nvim support
      bufferline = {}, -- Custom extension for bufferline tab names
    },
    dir = '.nvim-session', -- Store sessions in project root
    autosave = {
      enabled = false, -- Disable auto-save - save manually with <leader>ss
      interval = 60,
      notify = false,
    },
    load_detail = true, -- Show more detail when selecting sessions
    load_order = 'modification_time', -- Sort by modification time
    -- Save and restore these options
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
    
    -- Explicitly setup with options to ensure they're applied
    resession.setup(opts)

    -- Track if we're in a session load to enable buffer loading
    local is_loading_session = false
    local buffer_load_autocmd_id = nil
    
    -- Function to ensure a buffer is loaded
    local function ensure_buffer_loaded(bufnr, winid)
      if not vim.api.nvim_buf_is_valid(bufnr) then return false end
      
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      if not buf_name or buf_name == '' then return false end
      if not vim.bo[bufnr].buflisted then return false end
      if vim.fn.filereadable(buf_name) ~= 1 then return false end
      
      -- Check if buffer needs loading
      local is_loaded = vim.api.nvim_buf_is_loaded(bufnr)
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      local first_line = ''
      if line_count > 0 then
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
        first_line = lines[1] or ''
      end
      
      -- If buffer is not loaded or appears empty, load it
      if not is_loaded or (line_count <= 1 and first_line == '') then
        return pcall(function()
          -- If we have a window, switch to it first
          if winid and vim.api.nvim_win_is_valid(winid) then
            vim.api.nvim_set_current_win(winid)
          end
          
          -- Use bufload first, then edit to ensure file is read
          vim.fn.bufload(bufnr)
          -- Force reload the file content
          vim.cmd('silent! edit ' .. vim.fn.fnameescape(buf_name))
        end)
      end
      
      return true
    end
    
    -- Ensure all buffers are loaded after session restore
    -- This fixes the issue where buffers in inactive tabs are empty
    resession.add_hook('pre_load', function()
      is_loading_session = true
    end)
    
    resession.add_hook('post_load', function()
      -- Use a delay to ensure resession has finished all its work
      vim.defer_fn(function()
        vim.schedule(function()
          local current_tab = vim.api.nvim_get_current_tabpage()
          local all_tabs = vim.api.nvim_list_tabpages()
          
          -- Load all buffers in all tabs and ensure windows show the correct buffers
          for _, tabpage in ipairs(all_tabs) do
            if vim.api.nvim_tabpage_is_valid(tabpage) then
              -- Switch to this tab temporarily
              vim.api.nvim_set_current_tabpage(tabpage)
              
              local windows = vim.api.nvim_tabpage_list_wins(tabpage)
              for _, winid in ipairs(windows) do
                if vim.api.nvim_win_is_valid(winid) then
                  local bufnr = vim.api.nvim_win_get_buf(winid)
                  
                  -- Check if window is showing an empty buffer
                  local buf_name = ''
                  local is_empty = false
                  
                  if vim.api.nvim_buf_is_valid(bufnr) then
                    buf_name = vim.api.nvim_buf_get_name(bufnr)
                    is_empty = (buf_name == '' or not vim.bo[bufnr].buflisted)
                  else
                    is_empty = true
                  end
                  
                  -- If window shows empty buffer, try to find a file buffer for it
                  if is_empty then
                    -- Look through all buffers to find one that should be in this tab
                    local all_bufs = vim.api.nvim_list_bufs()
                    for _, check_bufnr in ipairs(all_bufs) do
                      if vim.api.nvim_buf_is_valid(check_bufnr) then
                        local check_name = vim.api.nvim_buf_get_name(check_bufnr)
                        if check_name and check_name ~= '' and vim.bo[check_bufnr].buflisted then
                          -- Check if this buffer is already in another window in this tab
                          local already_used = false
                          for _, other_winid in ipairs(windows) do
                            if other_winid ~= winid and vim.api.nvim_win_is_valid(other_winid) then
                              if vim.api.nvim_win_get_buf(other_winid) == check_bufnr then
                                already_used = true
                                break
                              end
                            end
                          end
                          
                          -- If buffer isn't used in this tab, use it for this window
                          if not already_used then
                            pcall(function()
                              vim.api.nvim_set_current_win(winid)
                              vim.api.nvim_win_set_buf(winid, check_bufnr)
                              ensure_buffer_loaded(check_bufnr, winid)
                            end)
                            break
                          end
                        end
                      end
                    end
                  else
                    -- Buffer has a name, ensure it's loaded and displayed
                    pcall(function()
                      -- Switch to window and explicitly set the buffer
                      -- This forces Neovim to properly display the buffer
                      vim.api.nvim_set_current_win(winid)
                      vim.api.nvim_win_set_buf(winid, bufnr)
                      ensure_buffer_loaded(bufnr, winid)
                    end)
                  end
                end
              end
            end
          end
          
          -- Set up autocmd to load buffers when tabs are entered
          -- This catches any buffers that weren't ready initially
          if buffer_load_autocmd_id then
            pcall(vim.api.nvim_del_autocmd, buffer_load_autocmd_id)
          end
          
          -- Set up autocmds to load buffers when tabs/buffers are entered
          buffer_load_autocmd_id = vim.api.nvim_create_autocmd({ 'TabEnter', 'BufEnter', 'WinEnter' }, {
            callback = function(event)
              if is_loading_session then
                vim.schedule(function()
                  if event.event == 'TabEnter' then
                    -- Load all buffers in the entered tab and ensure windows show them
                    local tabpage = vim.api.nvim_get_current_tabpage()
                    local windows = vim.api.nvim_tabpage_list_wins(tabpage)
                    for _, winid in ipairs(windows) do
                      if vim.api.nvim_win_is_valid(winid) then
                        local bufnr = vim.api.nvim_win_get_buf(winid)
                        
                        -- Explicitly set the buffer in the window to ensure it's displayed
                        if vim.api.nvim_buf_is_valid(bufnr) then
                          local buf_name = vim.api.nvim_buf_get_name(bufnr)
                          if buf_name and buf_name ~= '' then
                            pcall(function()
                              vim.api.nvim_set_current_win(winid)
                              vim.api.nvim_win_set_buf(winid, bufnr)
                              ensure_buffer_loaded(bufnr, winid)
                            end)
                          end
                        end
                      end
                    end
                  elseif event.event == 'BufEnter' then
                    -- Load the entered buffer and ensure it's shown
                    local bufnr = event.buf
                    local winid = vim.api.nvim_get_current_win()
                    ensure_buffer_loaded(bufnr, winid)
                    if vim.api.nvim_buf_is_valid(bufnr) then
                      pcall(function()
                        vim.api.nvim_win_set_buf(winid, bufnr)
                      end)
                    end
                  elseif event.event == 'WinEnter' then
                    -- When entering a window, ensure it shows its buffer
                    -- WinEnter event doesn't have event.win, use current win instead
                    local winid = vim.api.nvim_get_current_win()
                    if vim.api.nvim_win_is_valid(winid) then
                      local bufnr = vim.api.nvim_win_get_buf(winid)
                      if vim.api.nvim_buf_is_valid(bufnr) then
                        local buf_name = vim.api.nvim_buf_get_name(bufnr)
                        if buf_name and buf_name ~= '' then
                          pcall(function()
                            -- Explicitly set the buffer to ensure it's displayed
                            vim.api.nvim_win_set_buf(winid, bufnr)
                            ensure_buffer_loaded(bufnr, winid)
                          end)
                        end
                      end
                    end
                  end
                end)
              end
            end,
            desc = 'Load buffers after session restore',
          })
          
          -- Clean up after a short time
          vim.defer_fn(function()
            is_loading_session = false
            if buffer_load_autocmd_id then
              pcall(vim.api.nvim_del_autocmd, buffer_load_autocmd_id)
              buffer_load_autocmd_id = nil
            end
          end, 2000)
          
          -- Restore original tab
          vim.api.nvim_set_current_tabpage(current_tab)
        end)
      end, 100)
    end)

    -- Helper function to get session name from CWD
    local function get_session_name()
      local cwd = vim.fn.getcwd()
      -- Use the directory name as session name, or full path if needed
      -- This creates a unique session per project directory
      return cwd
    end

    -- No auto-save - sessions are saved manually with <leader>ss

    -- Auto-load on enter (if no args and not reading from stdin)
    -- Use User event to wait for Lazy to finish, or fallback to VimEnter with delay
    local function try_load_session()
      -- Check if we should load a session:
      -- 1. No file arguments (or only directory argument like "nvim .")
      -- 2. Not reading from stdin
      -- 3. Not already in a session
      local argc = vim.fn.argc(-1)
      local should_load = (argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1))
      
      if should_load and not vim.g.using_stdin and not resession.get_current() then
        local session_name = get_session_name()
        resession.load(session_name, { dir = '.nvim-session', silence_errors = true })
        -- Notify when auto-loading
        local current = resession.get_current()
        if current then
          vim.notify('Auto-loaded session: ' .. current, vim.log.levels.INFO)
        end
      end
    end

    -- Try to load after Lazy finishes (if available)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyDone',
      callback = try_load_session,
      once = true,
    })

    -- Fallback: also try on VimEnter with a delay (in case LazyDone doesn't fire)
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local argc = vim.fn.argc(-1)
        local should_load = (argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1))
        
        if should_load and not vim.g.using_stdin then
          -- Wait a bit longer to ensure everything is ready
          vim.defer_fn(try_load_session, 500)
        end
      end,
      nested = true,
    })

    -- Track if we're reading from stdin
    vim.api.nvim_create_autocmd('StdinReadPre', {
      callback = function()
        vim.g.using_stdin = true
      end,
    })
  end,
  keys = require('configs.mappings').resession,
}
