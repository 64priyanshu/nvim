local M = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("gruvbox").setup({
		overrides = {
			SignColumn = { bg = "#282828" },
			FloatBorder = { fg = "#7e7764", bg = "#32302f" },
			NormalFloat = { bg = "#32302f" },
		},
	})
	-- Enabling colorscheme
	vim.cmd("colorscheme gruvbox")
end

return M
