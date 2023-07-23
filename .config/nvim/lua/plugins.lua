local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "lewis6991/gitsigns.nvim"
    use "kyazdani42/nvim-tree.lua"
    use "famiu/bufdelete.nvim"
    use "akinsho/bufferline.nvim"
    use "akinsho/toggleterm.nvim"
    use "nvim-lualine/lualine.nvim"
    use "kyazdani42/nvim-web-devicons"
    -- colorscheme
    use "folke/tokyonight.nvim" -- TokyoNight colorscheme

    -- cmp plugins
    use {
        "hrsh7th/nvim-cmp", -- The completion plugin
        "hrsh7th/cmp-buffer", -- buffer completions
        "hrsh7th/cmp-path", -- path completions
        "hrsh7th/cmp-cmdline", -- cmdline completions
        "hrsh7th/cmp-nvim-lsp", -- lsp completion
        "hrsh7th/cmp-nvim-lsp-signature-help",
    }

    -- snippets
    use {
        "L3MON4D3/LuaSnip", --snippet engine
        "saadparwaiz1/cmp_luasnip", -- snippet completions
        "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        run = "make install_jsregexp"
    }

    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
    }

    -- Telescope
    use { "nvim-telescope/telescope.nvim" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter",
        requires = { "nvim-treesitter/nvim-treesitter-textobjects" }
    }

    -- Autopairs
    use { "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end }

    -- Comment
    use {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end
    }

    -- Docstring
    use {
        "musthafak/neogen",
        requires = "nvim-treesitter/nvim-treesitter",
    }

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
