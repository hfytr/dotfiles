require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        noice = true,
        notify = true,
        telescope = true,
        cmp = true,
    },
    custom_highlights = function(colors)
        return {
            LineNr = { fg = colors.overlay0 },
        }
    end,
})
