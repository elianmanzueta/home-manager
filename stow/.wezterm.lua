local wezterm = require("wezterm")

-- WSL
-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
-- 	config.default_domain = "WSL:Ubuntu"
-- end

local config = wezterm.config_builder()
local act = wezterm.action

-- Apperance
config.color_scheme = "duckbones"
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font_size = 14

-- Keys
config.keys = {
    -- Panes
    { key = "s", mods = "CTRL|ALT",  action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "CTRL|ALT",  action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "w", mods = "CTRL|ALT",  action = act.CloseCurrentPane({ confirm = false }) },
    { key = "h", mods = "CTRL|ALT",  action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "CTRL|ALT",  action = act.ActivatePaneDirection("Right") },

    -- Tabs
    { key = "{", mods = "ALT",       action = act.ActivateTabRelative(-1) },
    { key = "}", mods = "ALT",       action = act.ActivateTabRelative(1) },
    { key = "t", mods = "SHIFT|ALT", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "q", mods = "SHIFT|ALT", action = act.CloseCurrentTab({ confirm = true }) },
}

return config
