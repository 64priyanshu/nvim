-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/html.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/html.lua#L4
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	single_file_support = true,
	init_options = {
		provideFormatter = true,
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = { css = true, javascript = true },
	},
}
