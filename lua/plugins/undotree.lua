-- Enable Undo Tree
vim.cmd.packadd("nvim.undotree")

-- Keymap to toggle Undo Tree
vim.keymap.set("n", "<leader>u", "<CMD>Undotree<CR>")
