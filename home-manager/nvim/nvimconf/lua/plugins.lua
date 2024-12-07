require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "json",
                "css",
                "html",
                "markdown",
                "cpp",
                "rust",
                "python",
                "haskell",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require("configs.lspconfig")
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("configs.conform")
        end,
        lazy = false,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("configs.cmp")
        end,
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("configs.lualine")
        end,
    },
    { "windwp/nvim-autopairs", opts = {} },
    {
        "saccarosium/neomarks",
        config = function()
            require("configs.neomark")
        end,
        lazy = false,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {},
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        config = function()
            require("configs.fzf-lua")
        end,
    },
    {
        "lervag/vimtex",
        lazy = false,
        ft = "latex",
        config = function()
            require("configs.vimtex")
        end,
    },
    {
        "RRethy/base16-nvim",
        priority = 1000,
        config = function()
            require("base16")
        end
    },
    {
        "neovimhaskell/haskell-vim",
        ft = { "haskell", "cabal" },
        config = function()
            require("configs.haskell-vim")
        end
    },
}, {})

require("configs.quickfix")
