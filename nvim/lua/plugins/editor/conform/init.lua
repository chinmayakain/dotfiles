-- @type LazySpec[]
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("plugins.editor.conform.internal"),
  },
}
