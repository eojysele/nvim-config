-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    use ("wbthomason/packer.nvim")
    use { "williamboman/mason.nvim" }

    use 'Mofiqul/dracula.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }  
    use "lukas-reineke/indent-blankline.nvim"
    use {'lewis6991/gitsigns.nvim'}
    use 'simrat39/symbols-outline.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  
    use 'hrsh7th/nvim-cmp'
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-jdtls'
  
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    use {"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
