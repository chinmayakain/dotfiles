--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

-- =====================
-- Install required
-- =====================
-- Tmux
-- fc-list
-- fzf
-- lua

-- Pull APIs
local wezterm = require("wezterm")
local features = require("features")
local act = wezterm.action
local config = wezterm.config_builder()
local G = require("globals")

-- Configuration table
local config = {}

-- Use config_builder for better error messages in newer versions
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- =====================
-- General Configuration
-- =====================

config.default_prog = { "/bin/zsh", "-l", "-c", "~/.config/wezterm/scripts/shell/tmux-attach.sh" }

-- =====================
-- Fonts
-- =====================
local font
-- if G.font.family == "Default" then
-- 	font = wezterm.font_with_fallback({})
-- else
font = wezterm.font_with_fallback({
	{ family = G.font, weight = 400, italic = false },
})
-- end

config.font_rules = { { intensity = "Bold", font = font }, { intensity = "Normal", font = font } }
config.font_size = 15

if G.OLED then
	G.background = "#000000"
end

-- =====================
-- Color scheme
-- =====================
local scheme = wezterm.color.get_builtin_schemes()[G.colorscheme]
scheme.background = G.background or scheme.background

for colorscheme, overrides in pairs({
	["Poimandres"] = { background = "#0E0F15" },
	["catppuccin-mocha"] = { background = "#11111b" },
	["rose-pine"] = { background = "#12101A" },
	["rose-pine-moon"] = { background = "#12101A" },
	["tokyonight"] = { background = "#15161F" },
	["tokyonight_moon"] = { background = "#15161F" },
	["Gruvbox Material (Gogh)"] = { background = "#0f0f0f" },
	["Nightfly (Gogh)"] = { background = "#010F1A" },
}) do
	if G.colorscheme == colorscheme then
		for property, value in pairs(overrides) do
			scheme[property] = value
			scheme.background = G.background or value
		end
	end
end

config.color_scheme = "CustomTheme"
config.color_schemes = { ["CustomTheme"] = scheme }
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
config.command_palette_bg_color = scheme.background
config.command_palette_fg_color = scheme.foreground

-- =====================
-- Window
-- =====================
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.window_padding = G.padding
config.window_close_confirmation = "NeverPrompt"
config.macos_window_background_blur = 100
config.window_background_opacity = G.opacity
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 140
config.initial_rows = 40
config.enable_scroll_bar = false
config.window_frame = { font = wezterm.font({ family = G.font, weight = 400 }) }
config.command_palette_font_size = 16
config.front_end = "WebGpu"
config.bidi_enabled = true
config.background = {
    {
      source = {
        Color = '#000000'
      },
    },
    {
      source = {
        File = os.getenv('HOME') .. '/.config/wezterm/assets/background/bg-flame-variant.png'
      },
      height = "100%",
	  width = "100%",
      opacity = 0.9
    }
}

-- CURSOR
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.hide_mouse_cursor_when_typing = true
config.animation_fps = 60

-- ENV
config.set_environment_variables = { PATH = "/opt/homebrew/bin:" .. os.getenv("PATH") }

config.disable_default_key_bindings = true

-- ===================
-- Leader Key Settings
-- ===================
-- Leader key configuration
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }


config.keys = {
    -- Wezterm-specific shortcuts
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "f",
        action = wezterm.action.ToggleFullScreen,
    },
    {
        mods = "LEADER",
        key = "x",
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },

    -- Tmux-style tab navigation
    {
        mods = "LEADER",
        key = "b",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1),
    },

    -- Pane splitting
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    -- Pane navigation
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down",
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up",
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right",
    },

    -- Pane resizing
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 },
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 },
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 },
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 },
    },
    { key = "p", mods = "CMD|CTRL", action = wezterm.action_callback(features.togglePadding) },
	{ key = "z", mods = "CMD|CTRL", action = wezterm.action_callback(features.decreaseOpacity) },
	{ key = "c", mods = "CMD|CTRL", action = wezterm.action_callback(features.increaseOpacity) },
	{ key = "x", mods = "CMD|CTRL", action = wezterm.action_callback(features.resetOpacity) },
	{ key = "k", mods = "CMD|CTRL", action = wezterm.action_callback(features.theme_switcher) },
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action_callback(features.font_switcher) },
	{ key = "b", mods = "CMD|CTRL", action = features.global_bg() },
	{ key = "o", mods = "CMD|CTRL", action = wezterm.action_callback(features.toggleOLED) },

	{ key = "m", mods = "CMD", action = wezterm.action.Hide },
	{ key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
	{ key = "L", mods = "CMD", action = act.ShowDebugOverlay },
	{ key = "P", mods = "CMD", action = act.ActivateCommandPalette },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "q", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
}

-- Add number-based tab activation (1-based indexing)
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- ==================
-- Custom Status Line
-- ==================
wezterm.on("update-right-status", function(window, _)
    local SOLID_LEFT_ARROW = ""
    local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
    local prefix = ""

    if window:leader_is_active() then
        prefix = " " .. utf8.char(0x1f30a) -- ocean wave
        SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    end

    if window:active_tab():tab_id() ~= 0 then
        ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
    end

    window:set_left_status(wezterm.format {
        { Background = { Color = "#b7bdf8" } },
        { Text = prefix },
        ARROW_FOREGROUND,
        { Text = SOLID_LEFT_ARROW },
    })
end)

return config
