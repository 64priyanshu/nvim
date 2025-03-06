local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "c", "python", "c_sharp", "html", "css", "typescript", "javascript", "php" },

		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			-- Disable treesitter highlight for large files and mentioned files
			disable = function(lang, bufnr)
				-- local langs = { "html" }
				local langs = {}
				if vim.tbl_contains(langs, lang) then
					return true
				end
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = {
			enable = true,
			-- Disable treesitter indent for files with more than 5k lines and for mentioned filetypes
			disable = function(lang, bufnr)
				local langs = { "python", "css", "javascript" }
				return vim.api.nvim_buf_line_count(bufnr) > 5000 or vim.tbl_contains(langs, lang)
			end,
		},
		autopairs = {
			enable = true,
		},
	})
end

return M
