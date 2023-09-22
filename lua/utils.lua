local M = {}

M.cmp = {
	confirm_mapping = function(cmp)
		return cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}
	end,

	next_item = function(cmp, luasnip)
		return cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' })
	end,

	prev_item = function(cmp, luasnip)
		return cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' })
	end,
}

M.infile_search = function()
	require 'telescope.builtin'.current_buffer_fuzzy_find(require 'telescope.themes'.get_dropdown {
		winblend = 10,
		previewer = false,
	})
end

M.wksp_list_folders = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end

M.toggle_comment_normal = function()
	require 'Comment'
	require "Comment.api".toggle.linewise.current()
end

M.toggle_comment_visual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"

M.find_all = ':Telescope find_files follow=true no_ignore=true hidden=true\n'

M.format = function() vim.lsp.buf.format { async = true } end

M.floating_terminal = function() require 'FTerm'.toggle() end

M.lazygit = function()
	require 'lazygit'
	vim.cmd ':LazyGit\n'
end

M.focus_tree = function()
	require 'nvim-tree'
	vim.cmd ':NvimTreeFindFile\n'
end

M.save_session = function()
	local curr_session_name = require 'possession.session'.session_name
	if curr_session_name then
		require 'possession'.save(curr_session_name);
	else
		vim.ui.input({ prompt = 'Enter name for new session: ' }, function(input)
			require 'possession'.save(input)
		end)
	end
end

M.print_session = function()
	local curr_session_name = require 'possession.session'.session_name
	if curr_session_name then
		vim.notify('Current session: ' .. curr_session_name)
	else
		vim.notify('Currently not in a session', vim.log.levels.WARN)
	end
end

M.set_keymaps_table = function(keymaps_table)
	for _, v in ipairs(keymaps_table) do
		vim.keymap.set(v[1], v[2], v[3], v[4])
	end
end

return M
