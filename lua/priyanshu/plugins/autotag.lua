local M = {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
}

function M.config()
	require("nvim-ts-autotag").setup({
		opts = {
			enable_rename = false,
		},
	})
end

return M
