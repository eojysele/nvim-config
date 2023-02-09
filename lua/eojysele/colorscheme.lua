require("catppuccin").setup({
    flavour = "frappe",
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
    },
    integrations = {
        treesitter = true,
        symbols_outline = true,
        dap = {
            enabled = true,
        }
    },
})

local status, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not status then
    print("Colorscheme not found!") -- print error if colorscheme not installed
    return
end

local signs = {Error = "", Warn = "", Hint = "", Info = ""}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end
