local M = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		focus = true,
		auto_close = true,
		vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "#282828" }),
		vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "TroubleNormal" }),
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>" },
		{ "<leader>td", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>" },
		{
			"]t",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
		},
		{
			"[t",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
		},
	},
}

return M
