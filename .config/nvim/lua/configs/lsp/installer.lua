local deps_ok, mason, mason_lspconfig, lspconfig = pcall(function()
    return require "mason", require "mason-lspconfig", require "lspconfig"
end)
if not deps_ok then
    return
end

local language_servers = {
    "dockerls",
    "docker_compose_language_service",
    "groovyls",
    "lua_ls",
    "pyright",
}


mason.setup()
mason_lspconfig.setup({ ensure_installed = language_servers })

for _, server in pairs(language_servers) do
    local opts = {
        on_attach = require("configs.lsp.handlers").on_attach,
        capabilities = require("configs.lsp.handlers").capabilities,
    }

    if server == "lua_ls" then
        local lua_ls_opts = require("configs.lsp.settings.lua_ls")
        opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require("configs.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    lspconfig[server].setup(opts)
end
