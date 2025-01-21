local M = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("gitsigns").setup({
		update_debounce = 0,
		signs = {
			add = { text = "a" },
			change = { text = "c" },
			delete = { text = "d" },
			topdelete = { text = "tp" },
			changedelete = { text = "cd" },
			untracked = { text = "u" },
		},
		signs_staged_enable = false,
		preview_config = {
			border = "none",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
	vim.keymap.set("n", "]c", "<CMD>Gitsigns next_hunk<CR>", { silent = true })
	vim.keymap.set("n", "[c", "<CMD>Gitsigns prev_hunk<CR>", { silent = true })
	vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns blame_line<CR>", { silent = true })
end

return M
