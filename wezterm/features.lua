local wezterm = require("wezterm")
local utils = require("utils")
local act = wezterm.action
local u = dofile(os.getenv("HOME") .. "/.config/wezterm/utils.lua")

local M = {}

M.scriptsPath = os.getenv("HOME") .. "/.config/wezterm/scripts"

M.cmd_to_tmux_prefix = function(key, tmux_key)
	return {
		mods = "CMD",
		key = key,
		action = act.Multiple({
			act.SendKey({ mods = "CTRL", key = "a" }),
			act.SendKey({ key = tmux_key }),
		}),
	}
end

-- fzf switcher which opens in a right split and executes a command
M.fzfSwitcher = function(window, pane, script, command)
	-- execute fzf with update script on every cursor move
	local fzfCommand = "fzf --color=bg+:-1 --reverse  --preview-window=down,1 --preview='" .. script .. " {}'"

	window:perform_action(
		act.SplitPane({
			direction = "Right",
			command = {
				args = {
					"zsh",
					"-c",
					command .. fzfCommand,
				},
			},
			size = { Percent = 25 },
		}),
		pane
	)
    notify.send('Font switched!', 'Font has been switched to a new one.', 'normal')
end

M.font_switcher = function(window, pane)
	-- get system fonts by family name including only monospaced fonts, format and sort them
	local fontsCommand = "fc-list :spacing=100 family | grep -v '^\\.' | cut -d ',' -f1 | sort -u | "

	M.fzfSwitcher(window, pane, M.scriptsPath .. "/updateFont.lua", fontsCommand)
end

M.theme_switcher = function(window, pane)
	-- get builtin wezterm color schemes
	local builtinSchemes = wezterm.get_builtin_color_schemes()

	-- build a new table from the builtin wezterm color schemes names
	local schemes = {}

	for key, _ in pairs(builtinSchemes) do
		table.insert(schemes, tostring(key))
	end

	-- sort them alphabetically
	table.sort(schemes, function(c1, c2)
		return c1 < c2
	end)

	-- build the command from schemes table to be passed to fzf
	local schemesCommand = 'echo -e "' .. table.concat(schemes, "\n") .. '" | '

	M.fzfSwitcher(window, pane, M.scriptsPath .. "/updateScheme.lua", schemesCommand)
    notify.send('Theme switched!', 'WezTerm theme has been changed.', 'normal')
end

M.global_bg = function(window)  -- pass window here
	return act.PromptInputLine({
		description = "Enter a global bg color! 🎨",
		action = wezterm.action_callback(function(_, _, line)
			local lua = u.readLuaObject(u.globalsPath)
			if line == "" then
				lua.background = nil
				u.writeLuaObject(u.globalsPath, lua)
			elseif line then
				lua.background = line
				u.writeLuaObject(u.globalsPath, lua)
			end
            notify.send('Global background changed!', 'The global background color has been updated.', 'normal')
		end),
	})
end

M.togglePadding = function(window)  -- pass window here
	local lua = u.readLuaObject(u.globalsPath)
	if lua.padding.top == 0 then
		lua.padding = { top = 20, bottom = 20, left = 20, right = 20 }
	else
		lua.padding = { top = 0, bottom = 0, left = 0, right = 0 }
	end
	u.writeLuaObject(u.globalsPath, lua)
    notify.send('Padding toggled!', 'Padding has been toggled.', 'normal')
end

M.increaseOpacity = function(window)  -- pass window here
	local lua = u.readLuaObject(u.globalsPath)
	if lua.opacity <= 1 then
		lua.opacity = lua.opacity + 0.01
		u.writeLuaObject(u.globalsPath, lua)
        notify.send('Opacity increased!', 'Opacity has been increased.', 'normal')
	end
end

M.decreaseOpacity = function(window)  -- pass window here
	local lua = u.readLuaObject(u.globalsPath)
	if lua.opacity >= 0.5 then
		lua.opacity = lua.opacity - 0.01
		u.writeLuaObject(u.globalsPath, lua)
        utils.notify('Opacity decreased!', 'Opacity has been decreased.', 'normal')
	end
end

M.resetOpacity = function(window)  -- pass window here
	local lua = u.readLuaObject(u.globalsPath)
	lua.opacity = 1
	u.writeLuaObject(u.globalsPath, lua)
    utils.notify('Opacity reset!', 'Opacity has been reset to default.', 'normal')
end


-- Toggle OLED function
M.toggleOLED = function(window)
    -- Toggle OLED mode logic
    local lua = u.readLuaObject(u.globalsPath)
    lua.OLED = not lua.OLED
    u.writeLuaObject(u.globalsPath, lua)
    utils.notify('OLED Mode', 'Terminal OLED mode has been toggled.', 'normal')
end


return M
