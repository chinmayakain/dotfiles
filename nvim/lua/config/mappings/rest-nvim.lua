local M = {}

function M.setup_rest_keymaps()
  return {
    { "<leader>rr", "<Plug>RestNvim", desc = "Run REST request under cursor" },
  }
end

return M
