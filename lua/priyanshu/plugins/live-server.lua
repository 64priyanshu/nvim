local M = {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
}

function M.config()
  require("live-server").setup({
    args = { "--port=8080", "--browser=firefox" },
  })
end

return M
