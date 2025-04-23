local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("gruvbox").setup({
    overrides = {
      -- Search and Replace (From Gruvbox Material)
      Search = { fg = "#282828", bg = "#a9b665", reverse = false },
      CurSearch = { fg = "#282828", bg = "#ea6962", reverse = false },
      IncSearch = { link = "CurSearch" },
      Substitute = { fg = "#282828", bg = "#d8a657", reverse = false },
      -- -- UI/Columns
      SignColumn = { bg = "NONE" },
      FoldColumn = { bg = "NONE" },
      -- Float Window
      NormalFloat = { bg = "#32302f" },
      FloatBorder = { fg = "#7e7764", bg = "#32302f" },
    },
  })
  -- Enabling colorscheme
  vim.cmd("colorscheme gruvbox")
end

return M
