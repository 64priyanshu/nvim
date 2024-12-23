return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			overrides = {
				SignColumn = { bg = "#282828" },
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
