return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is too old
  event = "InsertEnter",
  enabled = true,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
    "rose-pine/neovim",
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local mappings = require("config.mappings.cmp")
    local auto_select = true

    -- Load Rose Pine colors
    local rose_pine = require("rose-pine.palette")

    -- Set custom highlights for cmp window
    vim.api.nvim_set_hl(0, "CmpBorder", { fg = rose_pine.overlay, bg = "NONE" })
    vim.api.nvim_set_hl(0, "CmpBackground", { bg = rose_pine.surface })
    vim.api.nvim_set_hl(0, "CmpGhostText", { fg = rose_pine.muted, bg = "NONE" })

    return {
      auto_brackets = {},
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = mappings,
      sources = cmp.config.sources({
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "emoji" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 41,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 31,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 1, width - 1) .. "…"
            end
          end

          return item
        end,
      },
      experimental = {
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
      sorting = defaults.sorting,
      window = {
        completion = {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
          winhighlight = "Normal:CmpBackground,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = {
            { "󰙎", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
          winhighlight = "Normal:CmpBackground,FloatBorder:CmpBorder",
        },
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")

    -- Global cmp setup
    cmp.setup(opts)

    -- Enable `vim-dadbod-completion` only for SQL-related file types
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        cmp.setup.buffer({
          completion = opts.completion, -- Use same completion settings
          preselect = opts.preselect, -- Preselect behavior
          mapping = opts.mapping, -- Use same key mappings
          formatting = opts.formatting, -- Same formatting
          sorting = opts.sorting, -- Same sorting logic
          experimental = opts.experimental, -- Enable ghost text if set globally
          window = opts.window, -- Use same window UI
          sources = cmp.config.sources({
            { name = "vim-dadbod-completion" },
          }, {
            { name = "buffer" },
          }),
        })
      end,
    })
  end,
}
