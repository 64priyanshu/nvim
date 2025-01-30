-- Instead of 4, use 2 spaces as (auto)indentation in python files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 80,
		})
	end,
})

-- Remove trailing whitespaces before saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
		vim.cmd([[%s/\s\+$//e]]) -- Perform the substitution to remove trailing spaces
		vim.api.nvim_win_set_cursor(0, pos) -- Restore the cursor position
	end,
})

-- Go to the location where the file was last exited when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Exit these windows/buffers pressing <ESC> or q
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"help",
		"lspinfo",
		"checkhealth",
		"qf",
	},
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<esc>", "<CMD>close<CR>", { noremap = true, silent = true })
		vim.cmd("setlocal nobuflisted")
	end,
})

-- Exit command-line window pressing <ESC> or q
vim.api.nvim_create_autocmd("CmdWinEnter", {
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<ESC>", "<CMD>close<CR>", { noremap = true, silent = true })
	end,
})

-- Hide some UI elements in terminal inside vim
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.cursorline = false
			vim.opt_local.signcolumn = "no"
			vim.opt.filetype = "terminal"
			vim.cmd.startinsert() -- Start in insert mode
		end
	end,
})

-- Set up logdir and logfile paths
local logdir = vim.fn.expand("$HOME") .. "/.vim/logdir"
local logfile = logdir .. "/log.txt"

-- Create logdir if it doesn't exist
vim.fn.mkdir(logdir, "p")

-- Autocommand to re-write (not append) vim messages in logs.txt on exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local messages = vim.fn.execute("messages")
		messages = messages:gsub("^\n+", ""):gsub("\n+$", "")
		vim.fn.writefile(vim.split(messages, "\n"), logfile)
	end,
})
