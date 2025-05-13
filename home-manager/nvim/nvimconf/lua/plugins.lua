require('lazy').setup({
    {
        'RRethy/base16-nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('base16')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'lua',
                'cpp',
                'c',
                'rust',
                'python',
            },
        },
    },
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('configs.conform')
        end,
        lazy = false,
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        config = function()
            require('configs.cmp')
            require('configs.lspconfig')
        end,
    },
    { 'windwp/nvim-autopairs', opts = {} },
    {
        'lervag/vimtex',
        lazy = true,
        ft = 'tex',
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_view_general_viewer = 'zathura'
            vim.g.vimtex_compiler_latexmk =
                { aux_dir = 'latex_aux', out_dir = 'latex_out' }
        end,
    },
    {
        'neovimhaskell/haskell-vim',
        lazy = true,
        ft = { 'haskell', 'cabal' },
        config = function()
            require('configs.haskell-vim')
        end,
    },
    {
        'BartSte/nvim-project-marks',
        lazy = false,
        branch = '4-issues-dynamically-changing-shada-file',
        config = function()
            require('configs.marks')
        end,
    },
}, {})
