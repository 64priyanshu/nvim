local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("gruvbox").setup({
    -- All colors are faithful to Gruvbox and taken from https://github.com/morhetz/gruvbox
    overrides = {
      Search = { fg = "#1d2021", bg = "#d79921", reverse = false },
      IncSearch = { fg = "#1d2021", bg = "#d65d0e", reverse = false },
      -- CurSearch linked to IncSearch, Substitute linked to Search
      SignColumn = { bg = "NONE" },
      FoldColumn = { bg = "NONE" },
      NormalFloat = { bg = "#32302f" },
      FloatBorder = { fg = "#7e7764", bg = "#32302f" },
    },
  })
  -- Enabling colorscheme
  vim.cmd("colorscheme gruvbox")
end

return M
