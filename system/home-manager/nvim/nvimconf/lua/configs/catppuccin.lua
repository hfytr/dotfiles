require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        noice = true,
        notify = true,
        telescope = true,
        cmp = true,
        fidget = true,
    },
    custom_highlights = function(colors)
        return {
            LineNrAbove = { fg = colors.mauve, bold = true },
            LineNrBelow = { fg = colors.mauve, bold = true },
            LineNr = { fg = colors.rosewater, bold = true },
        }
    end,
})
