return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.buttons.val = {
      dashboard.button("SPACE f f", "[F]ind [f]iles", ":Telescope find_files\n"),
      dashboard.button("SPACE f o", "[F]ind [o]ldfiles", ":Telescope oldfiles\n"),
      dashboard.button("SPACE f w", "[F]ind [w]ord by grep", ":Telescope live_grep\n"),
      dashboard.button("SPACE l g", "[L]azy[G]it client", ":LazyGit\n"),
      dashboard.button(":Lazy", "Lazy.nvim package manager", ":Lazy\n"),
      dashboard.button(":q", "Quit neovim", ":qa\n"),
      (function()
        local group = { type = "group", opts = { spacing = 0 } }
        group.val = { {
          type = "text",
          val = "Sessions",
          opts = { position = "center" },
        } }
        local path = vim.fn.stdpath("data") .. "/possession"
        local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
        for i, file in pairs(files) do
          local basename = vim.fs.basename(file):gsub("%.json", "")
          local button = dashboard.button(tostring(i), basename, ":PossessionLoad " .. basename .. "\n")
          table.insert(group.val, button)
        end
        return group
      end)()
    }
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
  end,
}
