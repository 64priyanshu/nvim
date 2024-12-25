local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

function M.config()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"clangd",
			"csharp_ls",
			"html",
			"cssls",
			"intelephense",
			"emmet_language_server",
			"pyright",
		},
		lazy = false,
		opts = {
			auto_install = true,
		},
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			"prettier",
			"stylua",
		},
		auto_update = false,
	})
end

return M
