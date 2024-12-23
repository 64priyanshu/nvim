return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
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
			vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#403e41" }),
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#5b595c" }),
		})
	end,
}
