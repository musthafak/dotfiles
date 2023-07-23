-- don't break neovim if treesitter is not installed
local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- treesitter setup
nvim_treesitter.setup {
    ensure_installed = {
        'python',
        'lua',
        'typescript',
        'bash',
        'css',
        'javascript',
        'html',
        'yaml',
        'json'
    },

    highlight = {
        disable = {},
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- Built-in captures.
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    }
}
