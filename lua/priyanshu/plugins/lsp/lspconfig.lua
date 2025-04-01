-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = true,
}
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSPs configuration
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Enabling LSPs
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"ts_ls",
	"html",
	"cssls",
	"emmet_language_server",
})

-- LSP commands

-- LspStop with arguments
vim.api.nvim_create_user_command("LspStop", function(opts)
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		if opts.args == "" or opts.args == client.name then
			client:stop(false)
			vim.notify(client.name .. ": stopped", vim.log.levels.WARN)
		end
	end
end, {
	nargs = "?",
	complete = function(_, _, _)
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		local client_names = {}
		for _, client in ipairs(clients) do
			table.insert(client_names, client.name)
		end
		return client_names
	end,
})

-- LspRestart to restart all clients
vim.api.nvim_create_user_command("LspRestart", function()
	local detach_clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		client:stop(false)
		if vim.tbl_count(client.attached_buffers) > 0 then
			detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
		end
	end
	local timer = vim.uv.new_timer()
	if not timer then
		return vim.notify("Servers are stopped but haven't been restarted.", vim.log.levels.WARN)
	end
	timer:start(
		100,
		50,
		vim.schedule_wrap(function()
			for name, client in pairs(detach_clients) do
				local client_id = vim.lsp.start(client[1].config, { attach = false })
				if client_id then
					for _, buf in ipairs(client[2]) do
						vim.lsp.buf_attach_client(buf, client_id)
					end
					vim.notify(name .. ": restarted", vim.log.levels.INFO)
				end
				detach_clients[name] = nil
			end
			if next(detach_clients) == nil and not timer:is_closing() then
				timer:close()
			end
		end)
	)
end, { nargs = 0 })

-- LspLog in right vertical split window
vim.api.nvim_create_user_command("LspLog", function()
	vim.cmd("rightbelow vsplit " .. vim.lsp.log.get_filename())
end, {})

-- LspInfo -> checkhealth vim.lsp
vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd("silent checkhealth vim.lsp")
end, {})
