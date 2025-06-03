-- LSP references
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs

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

-- modified LSP commands taken from https://github.com/neovim/nvim-lspconfig/blob/master/plugin/lspconfig.lua
local complete_client = function(arg)
  return vim
    .iter(vim.lsp.get_clients())
    :map(function(client)
      return client.name
    end)
    :filter(function(name)
      return name:sub(1, #arg) == arg
    end)
    :totable()
end

local complete_config = function(arg)
  return vim
    .iter(vim.api.nvim_get_runtime_file(("lsp/%s*.lua"):format(arg), true))
    :map(function(path)
      local file_name = path:match("[^/]*.lua$")
      return file_name:sub(0, #file_name - 4)
    end)
    :totable()
end

-- LspStart with single argument
vim.api.nvim_create_user_command("LspStart", function(info)
  if vim.lsp.config[info.args] == nil then
    vim.notify(("Invalid server: '%s'"):format(info.args), vim.log.levels.ERROR)
    return
  end
  vim.lsp.enable(info.args)
  vim.notify(("Sucessfully enabled server: '%s'"):format(info.args), vim.log.levels.INFO)
end, {
  nargs = "?",
  complete = complete_config,
})

-- LspStop with multiple arguments
vim.api.nvim_create_user_command("LspStop", function(info)
  for _, name in ipairs(info.fargs) do
    if vim.lsp.config[name] == nil then
      vim.notify(("Invalid server: '%s'"):format(name), vim.log.levels.ERROR)
    else
      vim.lsp.enable(name, false)
      vim.notify(("Sucessfully stopped server: '%s'"):format(name), vim.log.levels.WARN)
    end
  end
end, {
  nargs = "+",
  complete = complete_client,
})

-- LspRestart with arguments
vim.api.nvim_create_user_command("LspRestart", function(info)
  for _, name in ipairs(info.fargs) do
    if vim.lsp.config[name] == nil then
      vim.notify(("Invalid server: '%s'"):format(name), vim.log.levels.ERROR)
      return
    else
      vim.lsp.enable(name, false)
      vim.notify(("Sucessfully stopped server: '%s'"):format(name), vim.log.levels.WARN)
    end
  end

  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    for _, name in ipairs(info.fargs) do
      vim.schedule_wrap(function(x)
        vim.lsp.enable(x)
        vim.notify(("Sucessfully enabled server: '%s'\n"):format(x), vim.log.levels.INFO)
      end)(name)
    end
  end)
end, {
  nargs = "+",
  complete = complete_client,
})

-- LspLog window in new tab
vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd(("tabnew " .. vim.lsp.get_log_path()))
end, {})

-- LspInfo -> checkhealth vim.lsp
vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("silent checkhealth vim.lsp")
end, {})
