-- Install: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#emmet_language_server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/emmet_language_server.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/emmet_language_server.lua#L2
return {
  cmd = { "emmet-language-server", "--stdio" },
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
    "htmlangular",
  },
  root_markers = { ".git" },
  single_file_support = true,
}
