local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
}

function M.config()
	local on_attach = function(client, bufnr)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, bufopts)
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, bufopts)
	end

	local capabilities_ = vim.lsp.protocol.make_client_capabilities()
	capabilities_.textDocument.completion.completionItem.snippetSupport = true
	local capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities_)

	local langservers = {
		"html",
		"cssls",
		"clangd",
		"ts_ls",
		"pyright",
		"csharp_ls",
		"intelephense",
	}
	for _, server in ipairs(langservers) do
		require("lspconfig")[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	-- Custom Configs --
	require("lspconfig").lua_ls.setup({
		on_attach = on_attach,
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
		on_attach = on_attach,
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
