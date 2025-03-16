-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Copilot --
local function get_computer_model()
  local ok, handle = pcall(io.popen, "sysctl -n hw.model")
  if not ok or not handle then
    return nil
  end
  local result = handle:read("*a")
  handle:close()
  if result then
    return result:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace
  end
  return nil
end
-- Store the computer model globally
_G.COMPUTER_MODEL = get_computer_model()
-- Compute the Copilot model based on the computer model
_G.COPILOT_MODEL = _G.COMPUTER_MODEL == "MacBookAir" and "gpt-4o"
-- Optional: Create a command to show the computer model
vim.api.nvim_create_user_command("ShowComputerModel", function()
  local model = _G.COMPUTER_MODEL or "Unknown"
  print("Computer Model: " .. model)
end, {})

vim.g.lazygit_config = false
