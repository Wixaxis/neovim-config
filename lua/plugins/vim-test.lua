return {
    "vim-test/vim-test",
    ft = '',
    commander = {
        { cmd = ':TestFile -strategy=neovim_sticky\n', desc = 'Run current test file in sticky terminal' },
        { cmd = ':TestSuite -strategy=neovim_sticky\n', desc = 'Run all tests in sticky terminal' },
    },
}
