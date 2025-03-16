return {
  finder = "explorer",
  sort = { fields = { "sort" } },
  hidden = true, -- Show hidden files and directories
  gitignore = false, -- Show gitignored files
  include = { "coverage" },
  supports_live = true,
  tree = true,
  watch = true,
  diagnostics = true,
  diagnostics_open = false,
  git_status = true,
  git_status_open = false,
  git_untracked = true,
  follow_file = true,
  focus = "list",
  auto_close = true,
  jump = { close = false },
  layout = {
    preset = "vertical",
    width = 1.3,
  },
  config = function(opts)
    return require("snacks.picker.source.explorer").setup(opts)
  end,
}
