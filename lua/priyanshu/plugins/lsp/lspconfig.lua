local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
}

function M.config()
	local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

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
		signs = true,
		underline = true,
		update_in_insert = true,
		severity_sort = true,
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

	local on_attach = function(client, bufnr)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
		vim.keymap.set("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, bufopts)
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
		-- Diagnostic
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next({ float = false })
		end, bufopts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev({ float = false })
		end, bufopts)
	end

	local capabilities_ = vim.lsp.protocol.make_client_capabilities()
	capabilities_.textDocument.completion.completionItem.snippetSupport = true
	local capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities_)

	local langservers = {
		"clangd",
		"ts_ls",
		"html",
		"cssls",
	}

	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}

	for _, server in ipairs(langservers) do
		require("lspconfig")[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})
	end

	-- Custom Configs --
	require("lspconfig").lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
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
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
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
