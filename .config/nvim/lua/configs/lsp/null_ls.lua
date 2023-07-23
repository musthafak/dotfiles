-- don't break neovim if null-ls is not installed
local is_installed, null_ls = pcall(require, 'null-ls')
if not is_installed then
    return
end

-- null-ls setup
null_ls.setup({
    update_in_insert = false,
    diagnostics_format = "[#{c}] #{m} (#{s})",
    fallback_severity = vim.diagnostic.severity.INFO,
    sources = {
        -- Formatting
        require("null-ls").builtins.formatting.black.with(
            { extra_args = { "--preview" } }
        ),
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.jq.with(
            { extra_args = { "--indent", "4", "-S" } }
        ),
        -- Diagnostics
        require("null-ls").builtins.diagnostics.mypy,
        require("null-ls").builtins.diagnostics.pylint,
        require("null-ls").builtins.diagnostics.flake8,
        -- Code actions
        require("null-ls").builtins.code_actions.gitsigns,
    },
})
