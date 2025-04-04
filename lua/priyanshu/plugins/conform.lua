local M = {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
}
function M.config()
	require("conform").setup({
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
		},
	})

	-- Custom command to Disable format on save: FormatDisable, FormatDisable! (for current buffer)
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			vim.b.disable_autoformat = true
			vim.notify("Autoformat on save disabled for the current buffer.", vim.log.levels.WARN)
		else
			vim.g.disable_autoformat = true
			vim.notify("Autoformat on save disabled globally.", vim.log.levels.WARN)
		end
	end, {
		bang = true,
	})

	-- Custom command to Enable format on save for all buffers: FormatEnable
	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
		vim.notify("Autoformat on save enabled.", vim.log.levels.INFO)
	end, {})
end

return M
