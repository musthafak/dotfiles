-- cleanup python environment path
local function env_cleanup(venv)
    if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
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
                local venv = os.getenv "CONDA_DEFAULT_ENV"
                if venv then
                    return string.format("  (%s)", env_cleanup(venv))
                end
                venv = os.getenv "VIRTUAL_ENV"
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
            local buf_clients = vim.lsp.buf_get_clients()
            if next(buf_clients) == nil then
                return ""
            end

            local buf_client_names = {}

            -- add client
            local is_null_ls_enabled = false
            for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" then
                    table.insert(buf_client_names, client.name)
                else
                    is_null_ls_enabled = true
                end
            end
            if is_null_ls_enabled then
                local s = require "null-ls.sources"
                local available_sources = s.get_available(vim.bo.filetype)
                for _, source in ipairs(available_sources) do
                    for method in pairs(source.methods) do
                        if method == "NULL_LS_FORMATTING" or method == "NULL_LS_DIAGNOSTICS" then
                            table.insert(buf_client_names, source.name)
                        end
                    end
                end
            end
            if next(buf_client_names) == nil then
                return ""
            end
            return "[" .. table.concat(buf_client_names, ", ") .. "]"
        end
    }
}

-- don't break neovim if lualine package is not installed
local is_installed, lualine = pcall(require, "lualine")
if not is_installed then
    return
end

-- lualine  setup
lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "NvimTree", "Outline" },
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', components.python_env },
        lualine_x = { components.lsp_clients, 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
