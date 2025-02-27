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
