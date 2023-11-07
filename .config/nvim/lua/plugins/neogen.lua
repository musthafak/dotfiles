return {
  "musthafak/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>ds", "<cmd>Neogen<CR>", { desc = "Generate docstring" } },
  },
  opts = {
    languages = {
      -- support docstrings, https://github.com/danymat/neogen#supported-languages
      python = {
        template = {
          annotation_convention = "reST",
        },
      },
    },
  },
}
