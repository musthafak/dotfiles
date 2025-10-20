return {
  event = { "VeryLazy" },
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "pyright" },
    automatic_enable = false,
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
