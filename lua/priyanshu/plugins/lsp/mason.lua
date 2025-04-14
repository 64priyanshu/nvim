local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

function M.config()
	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			-- LSPs
			"clangd",
			"css-lsp",
			"emmet-language-server",
			"html-lsp",
			"intelephense",
			"lua-language-server",
			"typescript-language-server",
			-- Others
			"prettier",
			"stylua",
		},
		auto_update = false,
	})
end

return M
