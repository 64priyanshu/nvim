local M = {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("nvim-tree").setup({
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			preserve_window_proportions = true,
			width = 30,
		},
		renderer = {
			group_empty = false,
			icons = {
				glyphs = {
					git = {
						unstaged = "U",
						staged = "S",
						unmerged = "UM",
						renamed = "R",
						untracked = "UT",
						deleted = "D",
						ignored = "I",
					},
				},
			},
		},
		filters = {
			dotfiles = true,
		},
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
	})
	vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { silent = true })
end

return M
