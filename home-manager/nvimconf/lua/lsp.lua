local opts = { noremap = true, silent = true }

vim.diagnostic.config({
    virtual_text = { prefix = '■' },
    update_in_insert = true,
    underline = false,
    virtual_lines = false,
    signs = true,
    severity_sort = true,
    float = { source = 'always' },
})
vim.keymap.set('n', '<leader>de', function()
    vim.diagnostic.setqflist()
    vim.cmd('wincmd p')
end, opts)
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<C-h>', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    local virtual_lines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({virtual_lines = not virtual_lines})
end, opts)
vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.references()
end, opts)
vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
    vim.cmd.normal('zz')
end, opts)
vim.keymap.set('n', '<C-o>', '<C-t>', opts)
vim.keymap.set('n', '<C-i>', ':silent! tag<cr>', opts)

vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

local julia_cmd = {
    'julia',
    '--startup-file=no',
    '--history-file=no',
    '-e',
    [[
    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
    # with the regular load path as a fallback
    ls_install_path = joinpath(
        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
        "environments", "nvim-lspconfig"
    )
    pushfirst!(LOAD_PATH, ls_install_path)
    using LanguageServer
    popfirst!(LOAD_PATH)
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    project_path = let
        dirname(something(
            ## 1. Finds an explicitly set project (JULIA_PROJECT)
            Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
            )),
            ## 2. Look for a Project.toml file in the current working directory,
            ##    or parent directories, with $HOME as an upper boundary
            Base.current_project(),
            ## 3. First entry in the load path
            get(Base.load_path(), 1, nothing),
            ## 4. Fallback to default global environment,
            ##    this is more or less unreachable
            Base.load_path_expand("@v#.#"),
        ))
    end
    @info "Running language server" VERSION pwd() project_path depot_path
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
  ]],
}

local servers = {
    clangd = {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp' },
        root_markers = { '.clang-format', 'Makefile', 'CMakeLists.txt', '.git' },
    },
    pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'requirements.txt', '.git' },
    },
    rust_analyzer = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', '.git', '.gitignore', 'Cargo.lock' },
    },
    lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { 'stylua.toml', '.git' },
    },
    hls = {
        cmd = { 'haskell-language-server-wrapper', '--lsp' },
        filetypes = { 'haskell', 'lhaskell' },
        root_markers = { '*.cabal', '.git' },
    },
    julia = {
        cmd = julia_cmd,
        filetypes = { 'julia' },
        root_markers = { '.git', 'Project.toml', 'JuliaProject.toml' },
    },
}

local function read_settings_file(path)
    local file = io.open(path, 'r')
    if not file then
        return nil
    end
    local content = file:read('*a')
    file:close()
    local ok, data = pcall(vim.json.decode, content)
    vim.notify("LSP Settings", vim.inspect(data), vim.log.levels.WARN)
    return ok and data or nil
end

for lsp, opts in pairs(servers) do
    local path = vim.fn.expand(vim.fn.getcwd() .. '/.nvim/' .. lsp .. '.json')
    opts.settings = read_settings_file(path)
    vim.lsp.config[lsp] = opts
    vim.lsp.enable(lsp, true)
end
