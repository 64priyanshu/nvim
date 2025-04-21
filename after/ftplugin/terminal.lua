-- Local options
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = false
vim.opt_local.signcolumn = "no"

-- Exit Terminal mode into Normal mode by pressing ESC key
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = true })
