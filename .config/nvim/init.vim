""Vimrc - Vim config file
let mapleader = ","

"" General
    " set tab width in spaces
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    " convert tabs to spaces
    set expandtab
    " autoindent
    set autoindent
    " show line number - relative to current line
    set number relativenumber
    " highlights search
    set hlsearch
    " search incrementally
    set incsearch
    " system clipbaord (xclip)
    set clipboard+=unnamedplus
    " Vi-compatible off (enables more features)
    set nocompatible
    " syntax highliting
    syntax on
    " encoding
    set encoding=utf-8
    " ctrl+n completion
    set wildmode=longest,list,full
    " set splitwindows to open on the right
    set splitbelow splitright

"" Python
    let g:loaded_python_provider = 0
    let g:python3_host_prog = '/usr/bin/python'

"" Autocommands
    " disable automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " automatically delete whitespaces
    autocmd BufWritePre * %s/\s\+$//e

"" Scripts
    " compile
	map <leader>c :w! \| !compiler "%"<CR>
    " preview
    map <leader>p :silent ! prev "<c-r>%"<CR><CR>

"" Spellcheck
    " english
    map <leader>e :setlocal spell! spelllang=en_us<CR>
    map <leader>i :setlocal spell! spelllang=it<CR>

"" Plugins
call plug#begin('~/.config/nvim/plugged')
    "" LSP configs
    Plug 'neovim/nvim-lspconfig'
    "" Autocomplete
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    "" Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    "" Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"" Autocomplete
set completeopt=menu,menuone,noselect
lua << EOF
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

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Builtin LSP
    -- Lsp mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    local on_attach = function(client, bufnr)
    -- Mappings
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
     -- Setup lspconfig.
    local lspconfig = require('lspconfig')
    local servers = {'pylsp', 'texlab'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end
EOF

"" Treesitter highlights, indentation and folding
lua << EOF
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained", -- only mantained parsers
      highlight = {
        enable = false,
      },
  indent = {
      enable = false,
      }
    }
    --vim.opt.foldmethod=expr
    --vim.opt.foldexpr=nvim_treesitter#foldexpr()
EOF
