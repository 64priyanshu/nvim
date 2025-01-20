local M = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>" },
		{ "<leader>td", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>" },
		{
			"<leader>tj",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
		},
		{
			"<leader>tk",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
		},
	},
}

return M
