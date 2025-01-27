local set_colorscheme = require 'utils.init'.set_default_colorscheme
return {
    "f-person/auto-dark-mode.nvim",
    opts = {
        update_interval = 1000,
        set_dark_mode = function() set_colorscheme 'dark' end,
        set_light_mode = function() set_colorscheme 'light' end,
    },
    commander = require 'configs.mappings'.auto_dark_mode,
}
