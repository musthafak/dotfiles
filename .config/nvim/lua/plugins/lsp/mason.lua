return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    -- import mason plugin safely
    local mason = require("mason")

    -- import mason-lspconfig plugin safely
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls plugin safely
    local mason_null_ls = require("mason-null-ls")

    -- enable mason
    mason.setup()

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "jdtls",
        "pyright",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = false, -- not the same as ensure_installed
    })

    mason_null_ls.setup({
      -- list of formatters & linters for mason to install
      ensure_installed = {},
      -- auto-install configured servers (with lspconfig)
      automatic_installation = false,
    })
  end,
}
