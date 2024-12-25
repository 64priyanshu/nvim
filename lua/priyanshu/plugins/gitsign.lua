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
	})
end

return M
