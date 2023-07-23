local is_installed, neogen = pcall(require, "neogen")
if not is_installed then
    return
end

neogen.setup {
    languages = {
        -- support docstrings, https://github.com/danymat/neogen#supported-languages
        python = {
            template = {
                annotation_convention = "reST"
            }
        }
    }
}
