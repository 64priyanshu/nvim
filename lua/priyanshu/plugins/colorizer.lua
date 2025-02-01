local M = {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
}

function M.config()
	require("colorizer").setup({
		DEFAULT_OPTIONS = {
			RGB = true,
			RRGGBB = true,
			names = false,
			RRGGBBAA = true,
			rgb_fn = false,
			hsl_fn = false,
			css = false,
			css_fn = false,
			mode = "background",
		},
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

	-- Keymaps
	vim.keymap.set("n", "<leader>ca", function()
		vim.cmd("ColorizerAttachToBuffer")
		print("Colorizer attached to the buffer.")
	end, { silent = true })

	vim.keymap.set("n", "<leader>cr", function()
		vim.cmd("ColorizerReloadAllBuffers")
		print("Colorizer reloaded for all buffers.")
	end, { silent = true })

	vim.keymap.set("n", "<leader>ct", function()
		vim.cmd("ColorizerToggle")
		print("Colorizer toggled.")
	end, { silent = true })
end

return M
