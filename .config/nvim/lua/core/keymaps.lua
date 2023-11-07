local keymap = vim.keymap -- for conciseness

local opts = { noremap = true, silent = true }

-- set leader key to space
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", opts)
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", opts)
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts)
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)

-- Navigate buffers
keymap.set("n", "<Tab>", "<cmd>bnext<cr>", opts)
keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", opts)

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Navigate buffers
keymap.set("n", "<Tab>", "<cmd>bnext<cr>", opts)
keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", "<cmd>m .+1<cr>==", opts)
keymap.set("v", "<A-k>", "<cmd>m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
keymap.set("x", "J", "<cmd>move '>+1<cr>gv-gv", opts)
keymap.set("x", "K", "<cmd>move '<-2<cr>gv-gv", opts)
keymap.set("x", "<A-j>", "<cmd>move '>+1<cr>gv-gv", opts)
keymap.set("x", "<A-k>", "<cmd>move '<-2<cr>gv-gv", opts)

-- Diagnosis
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded', float = true })<cr>", opts)
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded', float = true })<cr>", opts)

-- Format code
keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)

-- Code actions
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
