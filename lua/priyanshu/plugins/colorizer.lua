return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			"*",
			html = {
				names = false,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
			},
			css = {
				names = false,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
			},
		})
	end,
}
