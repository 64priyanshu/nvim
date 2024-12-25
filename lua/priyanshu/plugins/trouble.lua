local M = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>" },
		{ "<leader>td", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>" },
	},
}

return M
