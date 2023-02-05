require("mason").setup()
require("mason-lspconfig").setup()

require'nvim-web-devicons'.setup {}
require("eojysele.plugins.nvim-tree")
require("eojysele.plugins.nvim-lualine")
require("eojysele.plugins.nvim-bufferline")
require("eojysele.plugins.nvim-treesitter")
require("eojysele.plugins.nvim-indent-blankline")
require("gitsigns").setup()

require("symbols-outline").setup {
    auto_close = true,
}

require("dap.ext.vscode").load_launchjs()
require("eojysele.plugins.nvim-lspconfig")
require("eojysele.plugins.nvim-cmp")
require("eojysele.plugins.nvim-telescope")
