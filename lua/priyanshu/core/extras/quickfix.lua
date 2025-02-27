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
