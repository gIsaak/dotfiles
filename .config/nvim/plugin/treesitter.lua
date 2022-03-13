-- Treesitter: highlight, selection, indentation, folding
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "latex",
        "bibtex",
        "python",
        "lua",
    },
    -- Highlight
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    textobjects = { enable = false },
    indent = { enable = false }
}
-- Folding
vim.api.nvim_exec([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]], true)
