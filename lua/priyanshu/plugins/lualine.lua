local M = {
	"nvim-lualine/lualine.nvim",
	event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("lualine").setup({
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { "filename" },
		},
		options = {
			show_command = false,
		},
	})
end

return M
