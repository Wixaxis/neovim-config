local keys = {
  { icon = "󰈞", key = "SPACE f f", desc = "[F]ind [f]iles", action = ":Telescope find_files" },
  { icon = "", key = "SPACE f o", desc = "[F]ind [o]ldfiles", action = ":Telescope oldfiles" },
  { icon = "", key = "SPACE f w", desc = "[F]ind [w]ord by grep", action = ":Telescope live_grep" },
  { icon = "", key = "SPACE l g", desc = "[L]azy[G]it", action = ":LazyGit" },
  { icon = "󰒲", key = "SPACE l l", desc = "Lazy.nvim package manager", action = ":Lazy" },
  { icon = "󰩈", key = "q", desc = "Quit neovim", action = ":qa", padding = 1 },
}

local session_key = function(i, name)
  return { icon = "", indent = 4, key = tostring(i), desc = name, action = ":PossessionLoad " .. name .. "\n" }
end

local path = vim.fn.stdpath("data") .. "/possession"
local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
if #files > 0 then
  table.insert(keys, { desc = 'Sessions', icon = ' ' })
  for i, file in pairs(files) do
    table.insert(keys, session_key(i, vim.fs.basename(file):gsub("%.json", ""):gsub("%%20", " ")))
  end
end

return {
  enabled = true,
  preset = { keys = keys },
  sections = {
    { section = "header" },
    { section = "keys",   gap = 1, padding = 1 },
    { section = "startup" },
  },
}
