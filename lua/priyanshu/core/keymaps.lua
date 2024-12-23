-- Toggle hlsearch
vim.keymap.set("n", "<leader>h", "<CMD>set nohlsearch!<CR>", { silent = true })

-- Create split and move cursor to new split
vim.keymap.set("n", "|", "<CMD>vsplit<CR><C-w>l", { silent = true })
vim.keymap.set("n", "-", "<CMD>split<CR><C-w>j", { silent = true })

-- Quick file save/close action
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>bd<CR>", { silent = true })

-- Line Wrap
vim.keymap.set("n", "<leader>lw", "<CMD>set wrap!<CR>", { silent = true })

-- Toggle Read-Only mode for current buffer
vim.keymap.set("n", "<leader>ro", function()
	local modifiable = vim.bo.modifiable

	vim.bo.modifiable = not modifiable

	if vim.bo.modifiable then
		print("[Modifiable]")
	else
		print("[Read only]")
	end
end, { silent = true })

-- Move Lines in Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- This function fixes screen flickering when pressing <C-d> from top of the file
local function lazy(keys)
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	return function()
		local old = vim.o.lazyredraw
		vim.o.lazyredraw = true
		vim.api.nvim_feedkeys(keys, "nx", false)
		vim.o.lazyredraw = old
	end
end

-- Cursor stays at the center of the screen
vim.keymap.set("n", "<C-d>", lazy("<C-d>zz"))
vim.keymap.set("n", "<C-u>", lazy("<C-u>zz"))

-- Cursor stays at the center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Cursor stays at the current position after Joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Stay in Visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Exit Terminal mode into Normal mode by pressing ESC key
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Move around in Line wrap
vim.keymap.set("n", "<A-j>", "gj")
vim.keymap.set("n", "<A-k>", "gk")

-- Resize split with Arrow Keys
vim.keymap.set("n", "<Up>", "<CMD>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Down>", "<CMD>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<Right>", "<CMD>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Left>", "<CMD>vertical resize -2<CR>", { silent = true })

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- Keep the deleted text in black-hole register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Copy current directory path to clipboard
vim.keymap.set(
	"n",
	"<leader>cfp",
	'<CMD>let @+ = expand("%:p:h")<CR><CMD>lua print("Copied path to: " .. vim.fn.expand("%:p:h"))<CR>'
)

-- Quickfix keymaps
vim.keymap.set("n", "<leader>cn", "<CMD>cnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>cp", "<CMD>cprev<CR>", { silent = true })
vim.keymap.set("n", "<leader>co", "<CMD>copen<CR>", { silent = true })
vim.keymap.set("n", "<leader>cc", "<CMD>cclose<CR>", { silent = true })

-- Empty Quickfix list
vim.keymap.set("n", "<leader>ck", function()
	vim.fn.setqflist({}, "f")
	print("Quickfix list deleted")
end, { silent = true })
