local wezterm = require 'wezterm'
local M = {}

M.globalsPath = os.getenv("HOME") .. "/.config/wezterm/globals.lua"

function M.readLuaObject(filePath)
	local file = assert(loadfile(filePath))
	return file()
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do -- luacheck: ignore 213
        if value == val then
            return true
        end
    end
    return false
end

function M.notify (subject, msg, urgency)
    local allowed_urgency = { 'low', 'normal', 'critical' }
    urgency = urgency or 'normal'
    if not has_value(allowed_urgency, urgency) then
        urgency = 'normal'
    end

    -- macOS: Use AppleScript for notifications
    local script = string.format([[
        display notification "%s" with title "%s" sound name "Tink"
    ]], msg, subject)

    -- Run the AppleScript
    wezterm.run_child_process({ "osascript", "-e", script })
end

function M.writeLuaObject(filePath, luaObject)
	local function tableToString(tbl, indent)
		indent = indent or ""
		local result = "{\n"
		local nextIndent = indent .. "  "
		for k, v in pairs(tbl) do
			local keyStr
			if type(k) == "string" and k:match("^%a[%w_]*$") then
				keyStr = k -- Use key as-is without brackets if it's a valid identifier
			else
				keyStr = "[" .. tostring(k) .. "]"
			end

			if type(v) == "table" then
				result = result .. nextIndent .. keyStr .. " = " .. tableToString(v, nextIndent) .. ",\n"
			else
				local valueStr = (type(v) == "string") and '"' .. v .. '"' or tostring(v)
				result = result .. nextIndent .. keyStr .. " = " .. valueStr .. ",\n"
			end
		end
		result = result .. indent .. "}"
		return result
	end

	local file = assert(io.open(filePath, "w"))
	file:write("return " .. tableToString(luaObject) .. "\n")
	file:close()
end

return M