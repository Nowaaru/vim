-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Swap window size and window change mappings.

local nt = { "n", "t" }
do
  vim.keymap.del(nt, "<C-Up>")
  vim.keymap.del(nt, "<C-Down>")
  vim.keymap.del(nt, "<C-Left>")
  vim.keymap.del(nt, "<C-Right>")

  vim.keymap.del(nt, "<C-h>")
  vim.keymap.del(nt, "<C-j>")
  vim.keymap.del(nt, "<C-k>")
  vim.keymap.del(nt, "<C-l>")

  vim.keymap.set(nt, "<C-Up>", "<C-w>k", { desc = "Go to upper window", remap = true })
  vim.keymap.set(nt, "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
  vim.keymap.set(nt, "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })
  vim.keymap.set(nt, "<C-Left>", "<C-w>h", { desc = "Go to left window", remap = true })

  -- Resizing.
  vim.keymap.set(nt, "<C-k>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  vim.keymap.set(nt, "<C-j>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  vim.keymap.set(nt, "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
  vim.keymap.set(nt, "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
end

