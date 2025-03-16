return function()
  local snacks = require("snacks")
  local picker = require("snacks.picker")
  local rename = require("snacks.rename")
  local icons = require("helper.icons")

  return {
    -- find
    {"<leader>fb", function() Snacks.picker.buffers({ sort_lastused = true }) end, desc = "Buffers"},
    {"<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config")[1] or vim.fn.stdpath("config") }) end, desc = "Find Config File"},
    {"<leader>ff", function() Snacks.picker.files() end, desc = "Find Files"},
    {"<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files"},
    {"<leader>fp", function() Snacks.picker.projects() end, desc = "Projects"},
    {"<leader>fr", function() Snacks.picker.recent() end, desc = "Recent"},
    -- Explorer keymaps
    {"<leader>e", function() picker.explorer({}) end, desc = "Open Snacks Explorer (cwd)"},
    {"<leader>fe", function() picker.explorer({ cwd = LazyVim.root(), follow_file = false }) end, desc = "Open Snacks Explorer (cursor on current file)"},
    {"<leader>fE", function() picker.explorer({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Open Snacks Explorer (current directory)"},
    -- Rename current file
    {"<leader>r", function() rename.rename_file() end, desc = "Rename current file (fast)"},
    -- Top Pickers & Explorer
    {"<leader><space>", function() vim.cmd("bnext") end, desc = "Cycle through Buffers"},
    {"<leader><bs>", function() vim.cmd("bprevious") end, desc = "Cycle Backward through Buffers"},
    {"<leader>,", function() Snacks.picker.buffers({ sort_lastused = true }) end, desc = "Buffers"},
    {"<leader>/", function() Snacks.picker.grep() end, desc = "Grep"},
    {"<leader>:", function() Snacks.picker.command_history() end, desc = "Command History"},
    {"<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History"},
    -- Picker keymaps
    {"<leader>fs", function() picker.grep() end, desc = "Search for string"},
    {"<leader>fw", function() snacks.picker.grep_word() end, desc = "Search Visual selection or Word", mode = { "n", "x" }},
    {"<leader>fk", function() snacks.picker.keymaps({ layout = "ivy" }) end, desc = "Search Keymaps (Snacks Picker)"},
    -- Search
    {"<leader>sm", function() Snacks.picker.marks() end, desc = "Marks"},
    -- Utils
    {"<leader>ft", function() snacks.picker.colorschemes({ layout = "ivy" }) end, desc = "Pick Color Schemes"},
    {"<leader>fh", function() snacks.picker.help() end, desc = "Help Pages"},
    -- Grep
    {"<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines"},
    {"<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers"},
    {"<leader>sg", function() Snacks.picker.grep() end, desc = "Grep"},
    {"<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }},
    -- Search
    {"<leader>s\"", function() Snacks.picker.registers() end, desc = "Registers"},
    {"<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History"},
    {"<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds"},
    {"<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History"},
    {"<leader>sC", function() Snacks.picker.commands() end, desc = "Commands"},
    {"<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics"},
    {"<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics"},
    {"<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages"},
    {"<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights"},
    {"<leader>si", function() Snacks.picker.icons() end, desc = "Icons"},
    {"<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps"},
    {"<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps"},
    {"<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List"},
    {"<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages"},
    {"<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec"},
    {"<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List"},
    {"<leader>sR", function() Snacks.picker.resume() end, desc = "Resume"},
    {"<leader>su", function() Snacks.picker.undo() end, desc = "Undo History"},
    -- Terminal Toggle
    {"<C-_>", function()
      local root_dir = vim.fn.getcwd()
      if vim.bo.buftype == "terminal" then vim.cmd("hide")
      else Snacks.terminal.toggle("zsh", { cwd = root_dir, env = { TERM = "xterm-256color" }, win = { style = "terminal", relative = "editor", width = 0.85, height = 0.85, border = "rounded", title = " " .. icons.ui.Terminal .. " Terminal ", title_pos = "center", hl = { border = "SnacksBorder", background = "SnacksBackground" } } })
      end
    end, desc = "Open Snacks Terminal in Float"},
  }
end
