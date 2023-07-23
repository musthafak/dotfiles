local deps_ok, nvim_tree = pcall(require, "nvim-tree")
if not deps_ok then
    return
end

nvim_tree.setup {
    disable_netrw = true,
    update_cwd = true,
    diagnostics = {
        enable = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    view = {
        width = 40,
    },
}
