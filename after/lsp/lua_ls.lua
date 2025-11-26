-- Install: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua#L15
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".git" },
	single_file_support = true,
	settings = { -- https://github.com/LuaLS/lua-language-server/wiki/Settings
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
