return {
  'MagicDuck/grug-far.nvim',
  opts = {
    keymaps = {
      close = { n = '<localleader>x' },
      swapReplacementInterpreter = { n = '<localleader>c' },
    },
    windowCreationCommand = 'tabnew | :BufferLineTabRename Search and replace',
  },
}
