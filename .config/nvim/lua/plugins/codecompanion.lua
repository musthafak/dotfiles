return {
  "olimorris/codecompanion.nvim",
  event = { "VeryLazy" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim" },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" },
    },
    { "hrsh7th/nvim-cmp" },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        opts = {
          completion_provider = "cmp",
        },
      },
      inline = { adapter = "copilot" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
