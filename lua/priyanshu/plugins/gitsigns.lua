local M = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	local border = {
		{ "🭽", "FloatBorder" },
		{ "▔", "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕", "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁", "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏", "FloatBorder" },
	}

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
			border = border,
			style = "minimal",
			relative = "cursor",
			row = 1,
			col = 0,
		},
	})

	-- Keymaps
	vim.keymap.set("n", "]c", "<CMD>Gitsigns next_hunk<CR>", { silent = true })
	vim.keymap.set("n", "[c", "<CMD>Gitsigns prev_hunk<CR>", { silent = true })
	vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns blame_line<CR>", { silent = true })
	vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>", { silent = true })
end

return M
