-- TODO: Maybe add this: https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12289384

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", function() vim.ui.input({}, function(input) vim.cmd("'<,'>CodeCompanion /buffer " .. input) end) end, mode = { "n", "v" }, silent = false, desc = "AI Assist", },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
    },
    display = {
      diff = {
        enabled = true,
        layout = "vertical",
        provider = "mini_diff",
      },
    },
  },
}
