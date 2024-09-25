return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
  event = { "VeryLazy" },
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
        sh = { "shfmt" },
        cucumber = { "reformat-gherkin" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      notify_on_error = true,
      default_format_opts = {
        lsp_format = "never",
        timeout_ms = 2000,
      },
      formatters = {
        ["reformat-gherkin"] = {
          command = "reformat-gherkin",
          args = { "-" },
        },
      },
    })

    -- install formatters
    require("mason-conform").setup({
      ignore_install = { "isort", "black" },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local available_formatters = conform.list_formatters(bufnr)
      local formatters_for_buffer = conform.list_formatters_for_buffer(bufnr)
      for _, buf_formatter in ipairs(formatters_for_buffer) do
        local found = false
        for _, formatter in ipairs(available_formatters) do
          if formatter.name == buf_formatter and formatter.available then
            found = true
          end
        end
        if not found then
          vim.api.nvim_err_writeln(buf_formatter .. " formatter is not available")
        end
      end
      conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
    end, { noremap = true, silent = true, desc = "Format file or range (in visual mode)" })
  end,
}
