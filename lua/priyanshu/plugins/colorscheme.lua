local M = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("gruvbox").setup({
		overrides = {
			SignColumn = { bg = "#282828" },
		},
	})
	vim.cmd("colorscheme gruvbox")
end

return M
