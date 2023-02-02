require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "java", "vim", "html", "json"},
    sync_install = false,
    highlight = {
        enable = true,
    },
}
