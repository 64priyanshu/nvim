vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Enable highlight and indent
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Ensure Installed
local ensure_installed = { "c", "css", "html", "javascript", "lua", "typescript" }
local already_installed = require("nvim-treesitter.config").get_installed()
local parsers_to_Install = vim.iter(ensure_installed)
	:filter(function(parser)
		return not vim.tbl_contains(already_installed, parser)
	end)
	:totable()
require("nvim-treesitter").install(parsers_to_Install)
