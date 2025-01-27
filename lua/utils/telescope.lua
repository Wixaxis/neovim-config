local M         = {}

M.oldfiles      = function() require 'telescope.builtin'.oldfiles() end
M.buffers       = function() require 'telescope.builtin'.buffers() end
M.git_files     = function() require 'telescope.builtin'.git_files() end
M.find_files    = function() require 'telescope.builtin'.find_files() end
M.help_tags     = function() require 'telescope.builtin'.help_tags() end
M.find_all      = ':Telescope find_files follow=true no_ignore=true hidden=true\n'
M.live_grep     = function() require 'telescope.builtin'.live_grep() end
M.diagnostics   = function() require 'telescope.builtin'.diagnostics() end
M.grep_string   = function() require 'telescope.builtin'.grep_string() end
M.telescope		= ':Telescope\n'
M.infile_search = function()
	require 'telescope.builtin'.current_buffer_fuzzy_find(
		require 'telescope.themes'.get_dropdown {
			winblend = 10,
			previewer = false,
		})
end
return M
