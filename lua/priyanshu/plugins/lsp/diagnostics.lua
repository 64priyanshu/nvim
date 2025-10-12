-- Diagnostics
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
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
})

-- Keymaps and others on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
      return
    end

    -- <C-x><C-o> for built-in completions menu
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    -- Uses tags and acts as go-to-definition
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
    -- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

    -- Inlay Hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
      vim.keymap.set("n", "grh", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
        if not enabled then
          vim.notify("Inlay hints enabled for current buffer.", vim.log.levels.INFO)
        else
          vim.notify("Inlay hints disabled for current buffer.", vim.log.levels.INFO)
        end
      end, { buffer = bufnr })
    end

    -- Keymaps
    local bufopts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set("n", "gS", vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, bufopts)
    -- Defaults
    -- gri -> go-to-implementation
    -- grr -> go-to-references
    -- gra -> code actions
    -- grn -> lsp-rename

    -- Lsp Hover Windows
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, bufopts)
    vim.keymap.set("n", "gK", function()
      vim.lsp.buf.signature_help({
        border = "rounded",
      })
    end, bufopts)
    vim.keymap.set("i", "<C-k>", function()
      vim.lsp.buf.signature_help({
        border = "rounded",
      })
    end, bufopts)

    -- Diagnostic
    vim.keymap.set("n", "grd", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "grq", vim.diagnostic.setqflist, bufopts)
    vim.keymap.set("n", "grg", function()
      local state = vim.diagnostic.is_enabled({ bufnr = bufnr })
      vim.diagnostic.enable(not state, { bufnr = bufnr })

      if not state then
        vim.notify("Diagnostics enabled for current buffer.", vim.log.levels.INFO)
      else
        vim.notify("Diagnostics disabled for current buffer.", vim.log.levels.INFO)
      end
    end, { buffer = bufnr })

    -- Defaults
    -- [d - jump to previous diagnostic of current buffer
    -- ]d - jump to next diagnostic of current buffer
  end,
})
