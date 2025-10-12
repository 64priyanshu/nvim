-- LSP references: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
-- Install LSP from: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = { dynamicRegistration = true, lineFoldingOnly = true }
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- LSPs configuration
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Enabling LSPs
-- Manual (name of server corresponds to name of files under lsp/ directory)
-- vim.lsp.enable({
-- 	"clangd",
-- 	"cssls",
-- 	"emmet_language_server",
-- 	"html",
-- 	"lua_ls",
-- 	"ts_ls",
-- })

-- Automatic
local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  local server_name = vim.fn.fnamemodify(f, ":t:r")
  table.insert(lsp_configs, server_name)
end
vim.lsp.enable(lsp_configs)

-- LspLog window in new tab
vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd(("tabnew " .. vim.lsp.get_log_path()))
end, {})

-- LspInfo -> checkhealth vim.lsp
vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("silent checkhealth vim.lsp")
end, {})
