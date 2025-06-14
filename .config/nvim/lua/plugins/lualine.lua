-- cleanup python environment path
local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch("([^/]+)") do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

-- lualine custom components
local components = {
  python_env = {
    function()
      if vim.bo.filetype == "python" then
        local venv = os.getenv("CONDA_DEFAULT_ENV")
        if venv then
          return string.format("  (%s)", env_cleanup(venv))
        end
        venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return string.format("  (%s)", env_cleanup(venv))
        end
        return ""
      end
      return ""
    end,
  },
  lsp_clients = {
    function()
      local buf_client_names = {}
      -- lsp clients
      local buf_clients = vim.lsp.get_clients()
      for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
      end
      -- nvim-lint linters
      local lint_status, lint = pcall(require, "lint")
      if lint_status then
        local linters = lint.linters_by_ft[vim.bo.filetype]
        for _, value in ipairs(linters) do
          table.insert(buf_client_names, value)
        end
      end
      -- conform formatters
      local conform_status, conform = pcall(require, "conform")
      if conform_status then
        local formatters = conform.list_formatters_for_buffer()
        for _, formatter in ipairs(formatters) do
          table.insert(buf_client_names, formatter)
        end
      end
      if next(buf_client_names) == nil then
        return ""
      end
      return "[" .. table.concat(buf_client_names, ", ") .. "]"
    end,
  },
}

return {
  "nvim-lualine/lualine.nvim",
  event = { "VeryLazy" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "NvimTree", "Outline" },
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 2000,
        tabline = 2000,
        winbar = 2000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename", components.python_env },
      lualine_x = { components.lsp_clients, "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  },
}
