require("mason").setup()

require'nvim-web-devicons'.setup {}
require("eojysele.plugins.nvim-tree")
require("lualine").setup {
  options = { theme = 'dracula' },
}
require("eojysele.plugins.nvim-treesitter")
require("indent_blankline").setup {}
require("gitsigns").setup()

require("symbols-outline").setup {
    auto_close = true,
}

require("dap.ext.vscode").load_launchjs()
require("eojysele.plugins.nvim-cmp")
require("eojysele.plugins.nvim-telescope")
