return {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },
    init = function()
        vim.o.foldenable = true
        vim.o.foldcolumn = 'auto:9'
        vim.o.foldlevel = 99
        vim.wo.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldmethod = 'indent'
        vim.o.fillchars = [[eob: ,fold: ,foldopen:⌄,foldsep:│,foldclose:>]]
    end,
    opts = {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end
    },
    commander = { {
        keys = { 'n', 'zR', { desc = 'ufo -> Open all folds' } },
        cmd = function() require('ufo').openAllFolds() end,
        desc = 'open all folds in buffer'
    }, {
        keys = { 'n', 'zM', { desc = 'ufo -> Close all folds' } },
        cmd = function() require('ufo').closeAllFolds() end,
        desc = 'ufo -> close all folds in buffer'
    }, {
        cmd = ':bufdo set foldcolumn=1\n',
        desc = 'ufo -> show (narrow + ugly) foldcolumn'
    }, {
        cmd = ':bufdo set foldcolumn=auto:9\n',
        desc = 'ufo -> show (wide + pretty) foldcolumn'
    }, {
        cmd = ':bufdo set foldcolumn=0\n',
        desc = 'ufo -> hide foldcolumn'
    } }
}
