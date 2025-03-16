local neogit = require("neogit")
local M = {}

-- Gitsigns mappings
function M.gs_setup(gs, buffer)
  -- Navigation
  vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gs.nav_hunk("next")
    end
  end, { buffer = buffer, desc = "Next Hunk" })

  vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gs.nav_hunk("prev")
    end
  end, { buffer = buffer, desc = "Prev Hunk" })

  vim.keymap.set("n", "]H", function() gs.nav_hunk("last") end, { buffer = buffer, desc = "Last Hunk" })
  vim.keymap.set("n", "[H", function() gs.nav_hunk("first") end, { buffer = buffer, desc = "First Hunk" })

  -- Actions
  vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { buffer = buffer, desc = "Stage Hunk" })
  vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { buffer = buffer, desc = "Reset Hunk" })
  vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { buffer = buffer, desc = "Stage Buffer" })
  vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { buffer = buffer, desc = "Undo Stage Hunk" })
  vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { buffer = buffer, desc = "Reset Buffer" })
  vim.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline, { buffer = buffer, desc = "Preview Hunk Inline" })
  vim.keymap.set("n", "<leader>ghf", gs.preview_hunk, { buffer = buffer, desc = "Preview Hunk (float)" })
  vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { buffer = buffer, desc = "Toggle Blame (current line)" })
  vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { buffer = buffer, desc = "Blame Line" })
  vim.keymap.set("n", "<leader>ghB", gs.blame, { buffer = buffer, desc = "Blame Buffer" })
  vim.keymap.set("n", "<leader>ghd", gs.diffthis, { buffer = buffer, desc = "Diff This" })
  vim.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end, { buffer = buffer, desc = "Diff This ~" })
  vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buffer, desc = "GitSigns Select Hunk" })
end

-- Neo-Git mappings
function M.is_git_repo()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  if handle == nil then return false end
  local result = handle:read("*a")
  handle:close()
  return result and result:match("true") ~= nil
end

function M.open_neogit()
  if M.is_git_repo() then
    if vim.fn.bufnr("$") > 0 then
      neogit.open()
    else
      print("No buffers are open")
    end
  else
    print("Not inside a Git repository")
  end
end

function M.neogit_setup()
  vim.keymap.set("n", "<leader>gg", M.open_neogit, { silent = true, noremap = true, desc = "Neogit (Status)" })
  vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true, desc = "Neogit Commit" })
  vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true, desc = "Neogit Pull" })
  vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true, desc = "Neogit Push" })
  vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true, desc = "Git Branches (Telescope)" })
  vim.keymap.set("n", "<leader>gB", ":BlameToggle<CR>", { silent = true, noremap = true, desc = "Toggle Git Blame" })
  vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { silent = true, noremap = true, desc = "Open Git Diff" })
  vim.keymap.set("n", "<leader>gD", ":DiffviewFileHistory<CR>", { silent = true, noremap = true, desc = "Git File History" })
  vim.keymap.set("n", "<leader>gs", ":Neogit stash<CR>", { silent = true, noremap = true, desc = "Git Stash (Neogit)" })
  vim.keymap.set("n", "<leader>gns", ":Neogit<CR>", { silent = true, noremap = true, desc = "Git Status (Neogit)" })
  vim.keymap.set("n", "<leader>gS", ":Neogit stage %<CR>", { silent = true, noremap = true, desc = "Stage Current File" })
  vim.keymap.set("n", "<leader>gr", ":Neogit reset %<CR>", { silent = true, noremap = true, desc = "Reset Current File" })
  vim.keymap.set("n", "<leader>g2", ":Neogit merge --ours<CR>", { silent = true, noremap = true, desc = "Accept Current Change (Ours)" })
  vim.keymap.set("n", "<leader>g3", ":Neogit merge --theirs<CR>", { silent = true, noremap = true, desc = "Accept Incoming Change (Theirs)" })
  vim.keymap.set("n", "<leader>gqn", ":Neogit close<CR>", { silent = true, noremap = true, desc = "Close Neogit" })
  vim.keymap.set("n", "<leader>gqd", ":DiffviewClose<CR>", { silent = true, noremap = true, desc = "Close Diffview" })
end

return M
