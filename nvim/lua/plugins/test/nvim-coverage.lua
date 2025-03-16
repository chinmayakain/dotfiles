return {
  "andythigpen/nvim-coverage",
  lazy = true,
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio",
  },
  cmd = { "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageClear", "CoverageSummary" },
  keys = {
    {
      "<leader>cc",
      function()
        require("coverage").load(true)
        vim.defer_fn(function()
          require("coverage").show()
        end, 100) -- Small delay to ensure coverage is loaded
      end,
      desc = "Load & Show Coverage",
    },
    { "<leader>cl", ":CoverageLoad<CR>", desc = "Load Coverage" },
    { "<leader>cH", ":CoverageSummary<CR>", desc = "Coverage Summary" },
    { "<leader>ch", ":CoverageHide<CR>", desc = "Hide Coverage" },
    { "<leader>cx", ":CoverageClear<CR>", desc = "Clear Coverage" },
  },
  config = function()
    local coverage = require("coverage")
    coverage.setup({
      commands = true,
      auto_reload = true,
      highlights = {
        covered = { fg = "#C3E88D" },
        uncovered = { fg = "#F07178" },
        partial = { gf = "#AA71F0" },
      },
      signs = {
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
        partial = { hl = "CoverageUncovered", text = "▎" },
      },
      summary = { min_coverage = 80.0 },
      lang = {
        typescript = { coverage_file = vim.fn.getcwd() .. "/coverage/lcov.info" },
        javascript = { coverage_file = vim.fn.getcwd() .. "/coverage/lcov.info" },
        go = { coverage_file = vim.fn.getcwd() .. "/coverage.out" },
      },
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "NeotestTestFinished",
      callback = function()
        vim.defer_fn(function()
          coverage.load(true)
          coverage.show()
        end, 500) -- Add slight delay to allow Jest to generate coverage
      end,
    })
  end,
}
