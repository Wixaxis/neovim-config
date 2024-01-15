return {
    "vim-test/vim-test",
    ft = '',
    commander = {
        { cmd = ':TestFile -strategy=neovim_sticky\n', desc = 'Run current test file in sticky terminal' },
    },
}
