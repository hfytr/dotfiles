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
                'json',
                'css',
                'html',
                'markdown',
                'cpp',
                'rust',
                'python',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('configs.lspconfig')
        end,
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
        version = 'v0.*',
        lazy = true,
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = {
                    auto_show = true,
                    border = 'rounded',
                    auto_show_delay = 0,
                },
                menu = { border = 'rounded' },
            },
            sources = { default = { 'lsp', 'path', 'buffer' } },
        },
        opts_extend = { 'sources.default' },
    },
    { 'windwp/nvim-autopairs', opts = {} },
    {
        'saccarosium/neomarks',
        config = function()
            require('configs.neomark')
        end,
        lazy = false,
    },
    { 'brenoprata10/nvim-highlight-colors', opts = {} },
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false,
        config = function()
            require('configs.fzf-lua')
        end,
    },
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
}, {})
