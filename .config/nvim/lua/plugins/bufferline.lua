return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
  version = "*",
  opts = {
    options = {
      close_command = "Bdelete %d",
      right_mouse_command = "Bdelete %d",
      max_name_length = 30,
      max_prefix_length = 30,
      tab_size = 21,
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    },
  },
}
