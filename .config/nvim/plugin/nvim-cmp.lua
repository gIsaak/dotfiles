-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keywork_lenght = 5},
    },
}

cmp.setup.cmdline(':', {
    sources = {
        { name = 'cmdline' }
    }
})
cmp.setup.cmdline('?', {
    sources = {
        { name = 'buffer' },
    }
})
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    }
})
