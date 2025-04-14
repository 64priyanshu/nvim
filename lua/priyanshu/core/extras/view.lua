-- Store view files in  home/.vim/viewdir
vim.opt.viewdir = vim.fn.expand("$HOME") .. "/.vim/viewdir"

-- Autocommand to save view state on exiting buffer window
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! mkview")
		end
	end,
})

-- Autocommand to load view state and center screen on entering a buffer window
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! loadview")
			vim.cmd("normal! zz")
		end
	end,
})
