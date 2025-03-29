local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	local border = {
		{ "🭽", "FloatBorder" },
		{ "▔", "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕", "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁", "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏", "FloatBorder" },
	}

	vim.diagnostic.config({
		virtual_text = true,
		underline = true,
		update_in_insert = true,
		severity_sort = true,
		signs = {
			numhl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			},
		},
		float = {
			focusable = true,
			style = "minimal",
			border = border,
			source = "always",
			header = "",
			prefix = "",
			suffix = "",
		},
	})

	-- Capabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = true,
		lineFoldingOnly = true,
	}
	capabilities.textDocument.semanticTokens.multilineTokenSupport = true
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local bufnr = ev.buf
			local client = vim.lsp.get_client_by_id(ev.data.client_id)

			if not client then
				return
			end

			if client.server_capabilities.completionProvider then
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			end
			if client.server_capabilities.definitionProvider then
				vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
			end
			--- Disable semantic tokens
			client.server_capabilities.semanticTokensProvider = nil

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, bufopts)
			vim.keymap.set("n", "<leader>lS", vim.lsp.buf.workspace_symbol, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
			-- Lsp Hover Windows
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({
					border = border,
				})
			end, bufopts)
			vim.keymap.set("n", "gK", function()
				vim.lsp.buf.signature_help({
					border = border,
				})
			end, bufopts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help({
					border = border,
				})
			end, bufopts)
			-- Diagnostic
			vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_next({ float = false })
			end, bufopts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev({ float = false })
			end, bufopts)
		end,
	})

	-- LSPs config for languages
	local langservers = {
		"clangd",
		"ts_ls",
		"html",
		"cssls",
	}

	for _, server in ipairs(langservers) do
		require("lspconfig")[server].setup({
			capabilities = capabilities,
		})
	end

	require("lspconfig").lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "opt", "cmd" },
				},
			},
			runtime = {
				version = "LuaJIT",
			},
		},
	})

	require("lspconfig").emmet_language_server.setup({
		capabilities = capabilities,
		filetypes = {
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"typescriptreact",
			"php",
		},
	})
end

return M
