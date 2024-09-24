return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        python = { "isort", "black" },
        css = { "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "yamlfmt" },
        json = { "prettierd" },
        lua = { "stylua" },
        toml = { "taplo" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
    })

    -- install formatters
    require("mason-conform").setup({
      ignore_install = { "isort", "black" },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
    end, { noremap = true, silent = true, desc = "Format file or range (in visual mode)" })
  end,
}
