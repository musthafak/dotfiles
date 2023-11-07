return {
    "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- import null-ls plugin
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")

        -- for conciseness
        local formatting = null_ls.builtins.formatting -- to setup formatters
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters
        local code_actions = null_ls.builtins.code_actions -- to setup code actions

        -- configure null_ls
        null_ls.setup({
            update_in_insert = false,
            diagnostics_format = "[#{c}] #{m} (#{s})",
            fallback_severity = vim.diagnostic.severity.INFO,
            -- add package.json as identifier for root (for typescript monorepos)
            root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
            -- setup formatters & linters
            sources = {
                --  to disable file types use
                -- Formatting
                formatting.stylua, -- lua formatter
                formatting.black.with({ extra_args = { "--preview" } }),
                formatting.isort,
                formatting.jq.with({ extra_args = { "--indent", "4", "-S" } }),
                -- Diagnostics
                diagnostics.mypy,
                diagnostics.pylint,
                diagnostics.flake8,
                -- Code actions
                code_actions.gitsigns,
            },
            -- configure format on save
            on_attach = function(current_client, bufnr)
                if current_client.supports_method("textDocument/formatting") then
                    vim.keymap.set("n", "<leader>fm", function()
                        vim.lsp.buf.format({
                            filter = function(client)
                                return client.name == "null-ls"
                            end,
                            bufnr = bufnr,
                        })
                    end)
                end
            end,
        })
    end,
}
