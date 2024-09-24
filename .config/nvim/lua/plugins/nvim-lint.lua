return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
    "rshkarin/mason-nvim-lint",
  },
  event = { "VeryLazy" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      yaml = { "yamllint" },
      yml = { "yamllint" },
      json = { "jsonlint" },
      python = { "flake8", "pylint", "mypy" },
      lua = { "luacheck" },
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
    require("mason-nvim-lint").setup({
      ensure_installed = {
        "eslint_d",
        "yamllint",
        "jsonlint",
        "luacheck",
      },
      automatic_installation = false,
    })
  end,
}
