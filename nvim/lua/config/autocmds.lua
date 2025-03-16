-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autocommand to persist colorscheme changes

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local colorscheme = vim.g.colors_name
    if not colorscheme then
      return
    end

    -- Path to theme.lua
    local theme_file = vim.fn.stdpath("config") .. "/lua/helper/theme.lua"

    -- Content to write
    local content = string.format('return { theme = "%s" }', colorscheme)

    -- Write or update the theme.lua file
    vim.fn.writefile({ content }, theme_file)

    -- Notify user
    vim.notify("Using colorscheme " .. colorscheme)
  end,
})
