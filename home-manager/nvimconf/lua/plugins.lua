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
        'saghen/blink.cmp',
        version = '1.*',
        event = 'InsertEnter',
        config = function()
            require('cmp')
        end,
    },
}, {})

local function on_buf_enter()
    if vim.g.plugins_initialized ~= nil and vim.g.plugins_initialized then
        return
    end
    vim.g.plugins_initialized = true
    require('lsp')
    require('marks')
end
vim.api.nvim_create_autocmd('BufEnter', { callback = on_buf_enter })
