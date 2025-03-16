-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- General Keymaps

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying to register" })
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Jumplist - forward
keymap.set("n", "<C-m>", "<C-o>", opts)
-- Jumplist - backward
keymap.set("n", "<C-n>", "<C-i>", opts)

-- Resize window without needing to press `Ctrl-w` repeatedly
keymap.set("n", ">", ":vertical resize +2<CR>", opts)
keymap.set("n", "<", ":vertical resize -2<CR>", opts)
keymap.set("n", "^", ":resize +2<CR>", opts)
keymap.set("n", "|", ":resize -2<CR>", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Jump to next repeated word under cursor
keymap.set("n", "]]", "/^$/<CR>", { desc = "Jump to next empty line" })
keymap.set("n", "[[", "?^$/<CR>", { desc = "Jump to previous empty line" })

-- Navigate
keymap.set("n", "J", "<C-d>", opts)
keymap.set("n", "K", "<C-u>", opts)
keymap.set("n", "JJ", "<C-f>", opts)
keymap.set("n", "KK", "<C-b>", opts)
keymap.set("n", "gh", vim.lsp.buf.hover, opts)
