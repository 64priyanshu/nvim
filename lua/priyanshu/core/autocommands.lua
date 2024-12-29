-- Instead of 4, use 2 spaces as (auto)indentation in python files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
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

-- Set up logdir and logfile paths
local logdir = vim.fn.expand("$HOME") .. "/.vim/logdir"
local logfile = logdir .. "/logs.txt"

-- Create logdir if it doesn't exist
vim.fn.mkdir(logdir, "p")

-- Autocommand to re-write (not append) vim messages in logs.txt on exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.cmd(string.format("silent! redir! > %s", logfile))
		vim.cmd("silent! messages")
		vim.cmd("silent! redir END")
	end,
})
