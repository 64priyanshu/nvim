-- Instead of 4, use 2 spaces as (auto)indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

-- Print startuptime on entering Neovim
local start_time = vim.fn.reltime()

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000 -- Convert to milliseconds
		print("Startup time: " .. string.format("%.3f ms", elapsed))
	end,
})
