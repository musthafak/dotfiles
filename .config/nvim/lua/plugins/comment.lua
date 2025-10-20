return {
  "numToStr/Comment.nvim",
  keys = {
    -- Normal mode: toggle comment with <leader>/
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      mode = "n",
      desc = "Toggle line comment (normal)",
    },
    -- Visual mode: toggle comment for selected lines with <leader>/
    {
      "<leader>/",
      function()
        -- In visual mode we want to exit visual mode then toggle
        local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
        vim.api.nvim_feedkeys(esc, "nx", false)
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end,
      mode = "x",
      desc = "Toggle line comment (visual)",
    },
  },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx and jsx files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
