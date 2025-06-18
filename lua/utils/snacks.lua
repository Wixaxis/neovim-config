local M = {}

M.picker = {}
M.picker.find_files = function() Snacks.picker.files() end
M.picker.git_files = function() Snacks.picker.git_files() end
M.picker.find_all = function() Snacks.picker.files({ hidden = true, ignored = true }) end
M.picker.oldfiles = function() Snacks.picker.recent() end
M.picker.live_grep = function() Snacks.picker.grep() end
M.picker.grep_string = function() Snacks.picker.grep_word() end
M.picker.infile_search = function() Snacks.picker.lines() end
M.picker.buffers = function() Snacks.picker.buffers() end
M.picker.help_tags = function() Snacks.picker.help() end
M.picker.diagnostics = function() Snacks.picker.diagnostics() end
M.picker.lsp_references = function() Snacks.picker.lsp_references() end
M.picker.colorscheme = function() Snacks.picker.colorschemes() end
M.picker.git_status = function() Snacks.picker.git_status() end
M.picker.keymaps = function() Snacks.picker.keymaps() end
M.picker.sessions = function() Snacks.picker.projects() end
M.picker.smart = function() Snacks.picker.smart() end
M.picker.todo = function() Snacks.picker.todo_comments() end
M.picker.treesitter_symbols = function() Snacks.picker.treesitter() end
M.picker.lsp_symbols = function() Snacks.picker.lsp_symbols() end
M.picker.command_history = function() Snacks.picker.command_history() end
M.picker.search_history = function() Snacks.picker.search_history() end
M.picker.quickfix = function() Snacks.picker.qflist() end
M.picker.location_list = function() Snacks.picker.loclist() end
M.picker.undo = function() Snacks.picker.undo() end
M.picker.marks = function() Snacks.picker.marks() end
M.picker.jumps = function() Snacks.picker.jumps() end
M.picker.notifications = function() Snacks.picker.notifications() end
M.picker.pickers = function() Snacks.picker.pickers() end
M.picker.yanky = function() Snacks.picker.yanky() end

M.lazygit = {}
M.lazygit.open = function() Snacks.lazygit.open() end
M.lazygit.file_history = function() Snacks.lazygit.log_file() end

M.buffer = {}
M.buffer.delete = function() Snacks.bufdelete.delete() end

return M
