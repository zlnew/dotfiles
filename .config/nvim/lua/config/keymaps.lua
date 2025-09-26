-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move lines up and down (Ctrl + Shift + Arrow)
local opts = { noremap = true, silent = true }

-- Normal mode
vim.keymap.set("n", "<C-S-Up>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<C-S-Down>", ":m .+1<CR>==", opts)

-- Visual mode (keeps selection after move)
vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv-gv", opts)
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv-gv", opts)

-- Insert mode (exit insert, move, re-indent, return to insert at same spot)
vim.keymap.set("i", "<C-S-Up>", "<Esc>:m .-2<CR>==gi", opts)
vim.keymap.set("i", "<C-S-Down>", "<Esc>:m .+1<CR>==gi", opts)

-- Dadbod UI Toggle
vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Dadbod UI" })
