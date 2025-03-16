return {
  {
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
      local surround_mappings = require("config.mappings.mini").surround_mappings
      local mappings = {
        { surround_mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { surround_mappings.delete, desc = "Delete Surrounding" },
        { surround_mappings.find, desc = "Find Right Surrounding" },
        { surround_mappings.find_left, desc = "Find Left Surrounding" },
        { surround_mappings.highlight, desc = "Highlight Surrounding" },
        { surround_mappings.replace, desc = "Replace Surrounding" },
        { surround_mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = require("config.mappings.mini").surround_mappings,
    },
  },
}
