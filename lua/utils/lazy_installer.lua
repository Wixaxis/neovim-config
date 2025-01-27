local M = {}
M.ensure_installed = function()
	local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
	local install_script = { 'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
	if not vim.loop.fs_stat(lazypath) then vim.fn.system(install_script) end
	vim.opt.rtp:prepend(lazypath)
end
return M
