local buffer_cwd = {}

-- Restore CWD when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if buffer_cwd[buf] then
			vim.api.nvim_set_current_dir(buffer_cwd[buf])
		end
	end,
})

-- Save CWD when leaving buffer
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		buffer_cwd[buf] = vim.fn.getcwd()
	end,
})
