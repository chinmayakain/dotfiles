local plugins = {
  require("plugins.lsp.lspconfig"),
  require("plugins.lsp.mason"),
  require("plugins.coding.blink-cmp"),
  require("plugins.coding.mini"),
  require("plugins.coding.nvim-cmp"),
  require("plugins.dap.nvim-dap"),
  require("plugins.editor.conform"),
  require("plugins.editor.flash-nvim"),
  require("plugins.editor.snacks"),
  require("plugins.git.git-signs"),
  require("plugins.git.neo-git"),
  require("plugins.test.neotest"),
  require("plugins.test.nvim-coverage"),
  require("plugins.ui.bufferline-nvim"),
  require("plugins.ui.colorscheme"),
  require("plugins.ui.filename"),
  require("plugins.ui.lualine"),
  require("plugins.ui.tailwindcss-colorizer-cmp"),
  require("plugins.ui.virt-column"),
}

return plugins
