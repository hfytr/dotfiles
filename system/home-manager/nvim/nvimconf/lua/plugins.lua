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
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        transparent_background = true,
        config = function()
            require("configs.catppuccin")
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
    { "echasnovski/mini.files", version = "*", opts = {} },
    {
        "lervag/vimtex",
        lazy = false,
        ft = "tex",
        config = function()
            require("configs.vimtex")
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({ background_colour = "#000000", render = "wrapped-compact" })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("configs.noice")
        end,
    },
}, {})

require("configs.quickfix")
