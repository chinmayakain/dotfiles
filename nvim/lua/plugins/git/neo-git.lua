return {
  "NeogitOrg/neogit",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "FabijanZulj/blame.nvim",
  },
  config = function()
    local neogit = require("neogit")
    local git_mappings = require("config.mappings.git") -- Updated to reflect the consolidated mappings file

    neogit.setup({ integrations = { diffview = true } })
    git_mappings.neogit_setup() -- Load all Git-related keybindings, including Neogit
  end,
}
