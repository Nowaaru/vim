-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Swap window size and window change mappings.
do
  vim.keymap.del("n", "<C-h>")
  vim.keymap.del("n", "<C-j>")
  vim.keymap.del("n", "<C-k>")
  vim.keymap.del("n", "<C-l>")

  vim.keymap.del("n", "<C-h>")
  vim.keymap.del("n", "<C-j>")
  vim.keymap.del("n", "<C-k>")
  vim.keymap.del("n", "<C-l>")

  map("n", "<C-Up>", "<C-w>h", { desc = "Go to left window", remap = true })
  map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
  map("n", "<C-Left>", "<C-w>k", { desc = "Go to upper window", remap = true })
  map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

  -- Resizing.
  map("n", "<C-h>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-k>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

