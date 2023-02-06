require("catppuccin").setup({
    flavour = "frappe",
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
    },
    integrations = {
        treesitter = true,
        symbols_outline = true,
    },
})

local status, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not status then
    print("Colorscheme not found!") -- print error if colorscheme not installed
    return
end
