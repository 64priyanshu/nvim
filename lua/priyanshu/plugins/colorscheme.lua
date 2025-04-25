local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("gruvbox").setup({
    -- All overrides are faithful to gruvbox.nvim colorscheme and taken from https://github.com/ellisonleao/gruvbox.nvim/blob/main/lua/gruvbox.lua
    overrides = {
      -- Search and Replace
      Search = { fg = "#d5c4a1", bg = "#665c54", reverse = false }, -- fg = light2, bg = dark3
      CurSearch = { fg = "#282828", bg = "#fabd2f", reverse = false }, -- fg = dark0, bg = bright_yellow
      IncSearch = { link = "CurSearch" },
      Substitute = { link = "CurSearch" },
      -- UI/Columns
      SignColumn = { bg = "NONE" },
      FoldColumn = { bg = "NONE" },
      Visual = { bg = "#504945", fg = "NONE" }, -- bg = dark2
      -- Float Window
      NormalFloat = { bg = "#32302f" }, -- bg = dark0_soft
      FloatBorder = { fg = "#7c6f64", bg = "#32302f" }, --fg = dark4, bg = dark0_soft
    },
  })
  -- Enabling colorscheme
  vim.cmd("colorscheme gruvbox")
end

return M
