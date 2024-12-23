return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					function()
						if vim.bo.filetype == "NvimTree" then -- Check if the current window is in nvim-tree
							return vim.fn.fnamemodify(vim.fn.expand("%:h"), ":~") -- Show only the path (relative path)
						else
							return vim.fn.expand("%:t") -- Show the filename in other buffers
						end
					end,
				},
			},
			options = {
				show_command = false,
				disabled_filetypes = { "dashboard" },
			},
		})
	end,
}
