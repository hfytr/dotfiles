require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "json",
                "css",
                "cpp",
                "rust",
                "python",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
        },
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
        "stevearc/oil.nvim",
        opts = {
            view_options = { show_hidden = true },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
    },
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
        "numToStr/Comment.nvim",
        opts = {
            toggler = { line = "<leader>/" },
            opleader = { line = "<leader>/" },
        },
        lazy = false,
    },
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                char = {
                    enabled = false,
                },
            },
        },
        event = "VeryLazy",
        keys = {
            {
                "<BS>",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
        },
        lazy = true,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("configs.fzf-lua")
        end,
    },
    {
        "sindrets/diffview.nvim",
        opts = {},
        lazy = true,
    },
}, {})

require("configs.quickfix")
require("configs.marks")
