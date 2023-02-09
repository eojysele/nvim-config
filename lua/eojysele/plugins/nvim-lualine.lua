require("lualine").setup {
    options = {
        theme = 'catppuccin',
        section_separators = '',
        component_separators = '',
        ignore_focus = { 'NvimTree', },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            { 'filename',
                path = 1,
                symbols = {
                    modified = '',
                    readonly = '',
                    unnamed = '',
                    newfile = 'New File'

                },
            },
        },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}
