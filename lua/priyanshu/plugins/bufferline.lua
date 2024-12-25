local M = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("bufferline").setup({
		options = {
			always_show_bufferline = false,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 1,
				},
			},
			sort_by = "insert_at_end",
		},
	})

	-- Navigate Buffer
	vim.keymap.set("n", "E", "<CMD>BufferLineCycleNext<CR>", { silent = true })
	vim.keymap.set("n", "Q", "<CMD>BufferLineCyclePrev<CR>", { silent = true })

	-- Reorder Buffers
	vim.keymap.set("n", "<leader>E", "<CMD>BufferLineMoveNext<CR>", { silent = true })
	vim.keymap.set("n", "<leader>Q", "<CMD>BufferLineMovePrev<CR>", { silent = true })
end

return M
