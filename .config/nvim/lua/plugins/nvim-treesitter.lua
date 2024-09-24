return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
          "python",
          "java",
          "groovy",
          "json",
          "javascript",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
        },
        -- auto install above language parsers
        auto_install = true,
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment region" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment region" },

              ["a:"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/field region" },
              ["i:"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/field region" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },

              ["ab"] = { query = "@block.outer", desc = "Select outer part of a block region" },
              ["ib"] = { query = "@block.inner", desc = "Select inner part of a block region" },

              ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
              ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>on"] = "@parameter.inner", -- swap object under cursor with next
            },
            swap_previous = {
              ["<leader>op"] = "@parameter.inner", -- swap object under cursor with previous
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
        },
      })
    end,
  },
}
