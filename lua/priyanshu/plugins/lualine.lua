local M = {
	"nvim-lualine/lualine.nvim",
	event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn", "info", "hint" },
		symbols = { error = "E", warn = "W", info = "I", hint = "H" },
		colored = true,
		always_visible = false,
	}

	require("lualine").setup({
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename", "diff" },
			lualine_x = { diagnostics, "encoding", { "filetype", icons_enabled = true } },
			lualine_y = { { "location", padding = 1 } },
			lualine_z = { "progress" },
		},
		options = {
			globalstatus = true,
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
	})
end

return M
