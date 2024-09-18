return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "zapling/mason-conform.nvim",
    "rshkarin/mason-nvim-lint",
  },
  config = function()
    -- import mason-lspconfig plugin safely
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason
    require("mason").setup()

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "pyright",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = false, -- not the same as ensure_installed
    })

    require("mason-conform").setup({})
    require("mason-nvim-lint").setup({})
  end,
}
