local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("ibl").setup({
    indent = {
      char = "▏",
      highlight = { "IblWhitespace" },
    },
    exclude = { filetypes = { "markdown", "text" } },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = { "IblScope" },
    },

    -- Highlights
    vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#403e41" }),
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#5b595c" }),
  })
end

return M
