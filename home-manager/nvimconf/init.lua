vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.o.showmode = false
vim.o.guicursor =
    'n-v-c:block,i-r-ci-cr-sm:block-blinkwait0-blinkon30-blinkoff30'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 15
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 420
vim.o.conceallevel = 0
function _G.my_statusline()
    local statusline = "%#Normal# %f%m%r%=%l:%c | "
    local filetype = vim.bo.filetype == "tex" and vim.g.compiling_latex and "tex (compiling)" or "%{&filetype}"
    return statusline .. filetype
end
vim.o.statusline = "%!v:lua._G.my_statusline()"
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'no'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.colorcolumn = '81'
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.disable_txt_format = true
vim.o.foldtext = 'v:lua.foldtext()'
vim.o.fillchars = 'fold: '
vim.o.winborder = 'rounded'
vim.o.wrap = false
function _G.foldtext()
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local line = vim.fn.getline(vim.v.foldstart)
    local i = 1
    while i <= #line and (line:sub(i, i) == ' ' or line:sub(i, i) == '\t') do
        i = i + 1
    end
    return line:sub(1, i - 1) .. line_count .. ' lines'
end

require('plugins')
require('colors')
require('mappings')
require('autocmd')
require('marks')
