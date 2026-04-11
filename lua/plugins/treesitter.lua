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

-- From Kickstarter nvim config

local function treesitter_try_attach(buf, language)
	-- check if parser exists and load it
	if not vim.treesitter.language.add(language) then
		return
	end
	-- enables syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)
end

local available_parsers = require("nvim-treesitter").get_available()

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		local installed_parsers = require("nvim-treesitter").get_installed "parsers"

		if vim.tbl_contains(installed_parsers, language) then
			-- enable the parser if it is installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
			require("nvim-treesitter").install(language):await(function()
				treesitter_try_attach(buf, language)
			end)
		else
			-- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})
