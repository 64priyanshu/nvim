local M = {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
}

function M.config()
	require("colorizer").setup({
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
end

return M
