return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim" },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "codecompanion" },
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
        tools = {
          opts = {
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
          ["cmd_runner"] = {
            opts = {
              requires_approval = false,
            },
          },
        },
      },
      inline = { adapter = "copilot" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
