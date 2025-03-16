local Path = require("helper.util.path")

local M = {}

M.cwd = function()
  local cwd = vim.uv.cwd()
  assert(cwd, "Could not get current working directory")
  return Path:new(cwd)
end

return M
