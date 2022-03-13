""Vimrc - Vim config file
let mapleader = ","

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
    "" Colorschemes
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()

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

"" Autocomplete
    "" Insert mode completion (useful for nvim-cmp)
    set completeopt=menu,menuone,noselect

"" Builtin LSP
    lua require('lsp.lsp-config')

"" Colorscheme
    lua require('colors.catppuccin')
    colorscheme catppuccin
