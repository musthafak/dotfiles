-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts) -- Explore
keymap("n", "<leader>x", "<cmd>Bdelete<cr>", opts) -- Close buffer
keymap("n", "<leader>fx", "<cmd>Bdelete!<cr>", opts) -- Forced close buffer
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts) -- Quite neovim

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)

-- Navigate buffers
keymap("n", "<Tab>", "<cmd>bnext<cr>", opts)
keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<esc>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", "<cmd>m .+1<cr>==", opts)
keymap("v", "<A-k>", "<cmd>m .-2<cr>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", "<cmd>move '>+1<cr>gv-gv", opts)
keymap("x", "K", "<cmd>move '<-2<cr>gv-gv", opts)
keymap("x", "<A-j>", "<cmd>move '>+1<cr>gv-gv", opts)
keymap("x", "<A-k>", "<cmd>move '<-2<cr>gv-gv", opts)

-- Telescope
keymap("n", "<leader>bb", "<cmd>Telescope buffers <cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files previewer=false<cr>", opts)
keymap("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", opts)
keymap("n", "<leader>cm", "<cmd>Telescope git_commits <cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status <cr>", opts)
keymap("n", "<leader>gr", "<cmd>Telescope live_grep <cr>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles <cr>", opts)

-- Comment code
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

-- Docstring
keymap("n", "<leader>ds", "<cmd>Neogen<cr>", opts)

-- Diagnosis
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded', float = true })<cr>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded', float = true })<cr>", opts)

-- Format code
keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)

-- Code actions
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
