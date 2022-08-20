""Vimrc - Vim config file
let mapleader = ","

"" Plugins
call plug#begin('~/.config/nvim/plugged')
    "" LSP configs
    Plug 'neovim/nvim-lspconfig'
    Plug 'scalameta/nvim-metals'
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
    "" DAP
    Plug 'mfussenegger/nvim-dap'
    "" Fuzzy finder
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    "" Status line
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    "" Comment
    Plug 'numToStr/Comment.nvim'
    "" Colorschemes
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
    """ Display hex colors
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
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
    " ctrl-n completion
    set wildmode=longest,list,full
    " set splitwindows to open on the right
    set splitright splitbelow

"" Terminal
    " turn terminal to normal mode with escape
    tnoremap <Esc> <C-\><C-n>
    " start terminal in insert mode
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif

    " toggle terminal on Alt-t
    nnoremap <A-t> :lua require('terminal').term_toggle(10)<CR>
    tmap <A-t> <ESC>:lua require('terminal').term_toggle(10)<CR>

"" Panel movement
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
    nnoremap <Left> :vertical resize +2<CR>
    nnoremap <Right> :vertical resize -2<CR>
    nnoremap <Up> :resize +2<CR>
    nnoremap <Down> :resize -2<CR>

"" Python
    let g:loaded_python_provider = 0
    let g:python3_host_prog = '/usr/bin/python'

"" Autocommands
    " disable automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " automatically delete whitespaces
    autocmd BufWritePre * %s/\s\+$//e

"" Plugins
    "" hexokinase
    let g:Hexokinase_highlighters = ['backgroundfull']

"" Mappings
    nnoremap <leader>n :noh <CR>
    "" scripts
	map <leader>c :w! \| !compiler "%"<CR>
	map <leader>ct :w! \| lua require('terminal').term_execute("compiler " .. vim.fn.expand("%") .. " \n")<CR>
    map <leader>p :silent ! prev "<c-r>%"<CR><CR>
    "" spellcheck
    map <leader>e :setlocal spell! spelllang=en_us<CR>
    map <leader>i :setlocal spell! spelllang=it<CR>
    map <leader>d :setlocal spell! spelllang=de<CR>
    " hexokinase
    nnoremap <F12> :HexokinaseToggle<CR>
    " lsp
    nnoremap <F8> :LspStart<CR>
    nnoremap <F9> :LspStop<CR>

"" Autocomplete
    "" Insert mode completion (useful for nvim-cmp)
    set completeopt=menu,menuone,noselect

"" LSP
    lua require('lsp.lsp-config')

"" Colorscheme
lua << EOF
    local catppuccin = require("catppuccin")
    catppuccin.setup({
        transparent_background = true,
    })
EOF
    colorscheme catppuccin

