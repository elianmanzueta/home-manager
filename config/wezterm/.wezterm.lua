local wezterm = require("wezterm")
local config = {}

--x86_64-pc-windows-msvc - Windows
-- x86_64-apple-darwin - macOS (Intel)
-- aarch64-apple-darwin - macOS (Apple Silicon)
-- x86_64-unknown-linux-gnu - Linux

-- WSL
if wezterm.running_under_wsl() then
	config.default_domain = "WSL:Arch"
end

-- Apperance
config.color_scheme = "duckbones"
config.font = wezterm.font("JetBrains Mono")

-- Keys
config.keys = {
	-- Panes
	{ key = "s", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "w", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },

	{ key = "s", mods = "CTRL", action = wezterm.action.PaneSelect },

  -- Tabs
	{ key = "{", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "}", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "t", mods = "SHIFT|ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "q", mods = "SHIFT|ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
}

return config
