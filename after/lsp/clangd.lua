-- Install: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/clangd.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/clangd.lua#L51
return {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
	single_file_support = true,
}
