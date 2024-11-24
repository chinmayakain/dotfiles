--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

-- Pull in the wezterm API
local wezterm = require "wezterm"
local mux = wezterm.mux
local run = wezterm.run

-- Configuration table
local config = {}

-- Use config_builder for better error messages in newer versions
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- =====================
-- General Configuration
-- =====================
-- Default shell
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono NL", { weight = 'DemiBold' })
config.font_size = 11
config.front_end = "OpenGL"
config.win32_system_backdrop = 'Tabbed'
config.window_background_opacity = 0.2
config.window_decorations = "TITLE | RESIZE"
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5,
}

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_ease_out = 'Linear' 
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_rate = 600

-- Tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- ===================
-- Leader Key Settings
-- ===================
-- Leader key configuration
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }

-- ====================
-- Key Bindings Section
-- ====================
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


-- Return the configuration table
return config
