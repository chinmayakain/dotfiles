return {
  "folke/snacks.nvim",
  keys = require("config.mappings.snacks"),
  opts = {
    terminal = require("plugins.editor.snacks.terminal"),
    dashboard = require("plugins.editor.snacks.dashboard"),
    picker = require("plugins.editor.snacks.picker"), -- This has explorer cofig embedded into it.
  },
}
