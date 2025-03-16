return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  opts = function()
    local gs = require("gitsigns")
    local git_mapping = require("config.mappings.git")

    return {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        git_mapping.gs_setup(gs, buffer)
      end,
    }
  end,
}
