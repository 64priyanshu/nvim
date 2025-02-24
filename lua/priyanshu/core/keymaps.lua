-- Toggle hlsearch
vim.keymap.set("n", "<leader>h", "<CMD>set nohlsearch!<CR>", { silent = true })

-- Create split and move cursor to new split
vim.keymap.set("n", "|", "<CMD>vsplit<CR><C-w>l", { silent = true })
vim.keymap.set("n", "-", "<CMD>split<CR><C-w>j", { silent = true })

-- Quick file save/close action
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>bp|bd #<CR>", { silent = true })

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

-- Stay in Visual mode after changing Indent with < >
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Exit Terminal mode into Normal mode by pressing ESC key
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Move around in Line wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

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

-- Terminal splits
vim.keymap.set("n", "<leader>t-", "<CMD>belowright 10split | term<CR>", { silent = true })
vim.keymap.set("n", "<leader>t|", "<CMD>botright 70vsplit | term<CR>", { silent = true })

-- Remap to move horizontally in command-line mode without using arrow key
vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-l>", "<Right>")

-- Quickfix keymaps
vim.keymap.set("n", "]q", "<CMD>cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", "<CMD>cprev<CR>", { silent = true })

-- Toggle quickfix window (Doesn't open if qf is empty)
vim.keymap.set("n", "<leader>tq", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end, { silent = true })

-- Clear Quickfix list
vim.keymap.set("n", "<leader>ck", function()
	vim.fn.setqflist({}, "f")
	print("Quickfix list deleted.")
end, { silent = true })
