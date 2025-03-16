return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "nvim-neotest/neotest-python", ft = "python" },
    { "nvim-neotest/neotest-jest", ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
    { "nvim-neotest/neotest-go", ft = "go" },
  },
  config = function()
    local localIcons = require("helper.icons")

    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--cov" },
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-go")({
          args = { "-race", "-covermode=atomic", "-coverprofile=coverage.out" },
        }),
      },
      icons = {
        unknown = localIcons.ui.Alien,
        passed = localIcons.ui.CircleCheck,
        failed = localIcons.ui.circleCross,
      },
      summary = {
        enabled = true,
        animated = true,
        open = "botright vsplit | vertical resize 50",
        count = true,
        follow = false,
        expand_errors = false,
        mappings = {
          output = "K",
          next_failed = "<C-J>",
          prev_failed = "<C-K>",
          watch = "W",
          mark = "m",
          clear_marked = "<C-m>",
          expand = { "<LeftMouse>", "	" },
          jumpto = "<CR>",
          expand_all = "za",
          short = "s",
          attach = "a",
          stop = "S",
          run = "r",
          debug = "d",
          run_marked = "R",
          debug_marked = "D",
          target = "t",
          clear_target = "T",
        },
      },
      log_level = 2,
      consumers = {},
      highlights = {},
      floating = {
        border = "rounded",
        max_height = 0.9,
        max_width = 0.9,
        options = {},
      },
      strategies = {
        integrated = {
          width = 80,
        },
      },
      run = {
        enabled = true,
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      quickfix = {
        enabled = true,
        open = true,
      },
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
      state = {
        enabled = true,
      },
      watch = {
        enabled = true,
        symbol_queries = {},
      },
      diagnostic = {
        enabled = true,
        severity = 1,
      },
      projects = {},
      discovery = {
        enabled = true,
        concurrent = 0,
      },
      running = {
        concurrent = true,
      },
      default_strategy = "integrated",
    })
  end,
}
