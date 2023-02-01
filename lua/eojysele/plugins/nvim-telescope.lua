require('telescope').setup({
    defaults = {
        path_display = {
            shorten = {
                len = 3, exclude = {1, -1}
            },
            truncate = true
        },
        dynamic_preview_title = true,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

require('telescope').load_extension('fzf')
