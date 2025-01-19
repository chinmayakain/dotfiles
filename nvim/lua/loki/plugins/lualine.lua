return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/lazy.nvim" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    local colors = {
      bg = "#112638",
      fg = "#c3ccdc",
      blue = "#65D1FF",
      green = "#3EFFDC",
      cyan = "#89dceb",
      red = "#FF4A4A",
      magenta = "#cba6f7",
      yellow = "#FFDA7B",
      gray = "#585b70",
      orange = "#f9e2af",
      violet = "#FF61EF",
      inactive_bg = "#2c3043",
    }

    local mode_icons = {
      n = " NORMAL",
      i = " INSERT",
      v = " VISUAL",
      V = " V-LINE",
      [""] = " V-BLOCK",
      c = " COMMAND",
      R = " REPLACE",
      t = " TERMINAL",
    }

    local function mode_color()
      local mode_map = {
        n = colors.blue,
        i = colors.green,
        v = colors.magenta,
        V = colors.magenta,
        [""] = colors.magenta,
        c = colors.red,
        R = colors.violet,
        t = colors.yellow,
      }
      return { fg = mode_map[vim.fn.mode()] or colors.fg, bg = colors.bg, gui = "bold" }
    end

    lualine.setup {
      options = {
        theme = "auto",
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { "dashboard", "NvimTree" },
      },
      sections = {
        lualine_a = {
          {
            function()
              return mode_icons[vim.fn.mode()] or " UNKNOWN"
            end,
            color = mode_color,
          },
        },
        lualine_b = {
          { "branch", icon = "", color = { fg = colors.fg, bg = colors.bg }  },
          { "diff", symbols = { added = " ", modified = "󰝤 ", removed = " " } },
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- Relative path
            shorting_target = 40,
            symbols = { modified = " ", readonly = " ", unnamed = "[No Name]" },
          },
        },
        lualine_x = {
          {
            function()
              return lazy_status.updates()
            end,
            cond = function()
              return pcall(require, "lazy.status") and lazy_status.has_updates()
            end,
            color = { fg = "#ff9e64" },
          },
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "encoding" },
          { "fileformat" },
        },
        lualine_y = { { "filetype", colored = true, icon_only = true, icon = { align = 'right' } } },
        lualine_z = { { "progress", color = { bg = colors.bg, fg = colors.fg } }, { "location", color = { bg = colors.bg, fg = colors.fg} } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fugitive", "nvim-tree", "quickfix" },
    }
  end,
}

