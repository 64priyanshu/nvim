local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("ibl").setup({
		indent = {
			highlight = { "IblWhitespace" },
			char = "▏",
		},
		exclude = { filetypes = { "markdown", "text" } },
		scope = {
			show_start = false,
			show_end = false,
			injected_languages = true,
			priority = 1024,
			include = {
				node_type = {
					["*"] = {
						"*",
					},
				},
			},
		},

		-- Highlights
		vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#403e41" }),
		vim.api.nvim_set_hl(0, "IblScope", { fg = "#5b595c" }),
	})
end

return M
