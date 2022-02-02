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
    " autocompletion ctrl+n to activate
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
    "" LSP
    Plug 'neovim/nvim-lspconfig'
    "" Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"" LSP servers
    "" pyright
    lua require'lspconfig'.pyright.setup{}
    "" texlab
    lua require'lspconfig'.texlab.setup{}

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
