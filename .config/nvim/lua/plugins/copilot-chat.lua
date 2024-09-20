local build_dependencies = function()
  if vim.fn.has("win32") == 0 and vim.fn.has("win64") == 0 then
    return "make tiktoken"
  end
  return ""
end

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
  build = build_dependencies(),
  config = function()
    require("CopilotChat").setup({
      debug = true, -- Enable debugging
    })
    local keymap = vim.keymap
    keymap.set({ "n", "v" }, "<leader>ccq", function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end, { desc = "CopilotChat - Quick chat", noremap = true, silent = true })
    keymap.set({ "n", "v" }, "<leader>cch", function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    end, { desc = "CopilotChat - Telescope Help Actions", noremap = true, silent = true })
    -- Show prompts actions with telescope
    keymap.set({ "n", "v" }, "<leader>ccp", function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end, { desc = "CopilotChat - Telescope Prompt Actions", noremap = true, silent = true })
  end,
}
