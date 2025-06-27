-- Highlights the current line and word under the cursor
return {
  'yamatsum/nvim-cursorline',
  opts = {
    cursorline = {
      enable = true,
      timeout = 600,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
    },
  },
}
