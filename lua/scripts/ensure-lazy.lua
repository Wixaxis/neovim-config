-- TODO: move to utils as function
-- NOTE: require 'utils'.ensure_lazy()
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath }
end
vim.opt.rtp:prepend(lazypath)
