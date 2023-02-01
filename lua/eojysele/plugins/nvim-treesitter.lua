require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "java", "vim", "html", "json"},
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
