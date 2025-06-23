-- Automatically saves files when you stop typing
return {
    "Pocco81/auto-save.nvim",
    opts = {
        execution_message = { message = function() return 'Saved' end },
        condition = function(buf)
            if not vim.api.nvim_buf_is_valid(buf) then
                return false
            end
            if vim.bo[buf].filetype == "harpoon" then
                return false
            end
            return true
        end
    }
}
