-- Install: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua#L4
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true },
	root_markers = { "package.json", ".git" },
	single_file_support = true,
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}
