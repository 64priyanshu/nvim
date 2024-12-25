local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "c", "python", "c_sharp", "html", "css", "typescript", "javascript", "php" },

		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = { "python", "css", "javascript" },
		},
		autopairs = {
			enable = true,
		},
	})
end

return M
