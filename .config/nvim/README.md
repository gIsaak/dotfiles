# About my Neovim config

Neovim (and also vim for that matter) has grown into a complex
multi-layered project, resulting in even more layered
documentation and nested man-pages, especially for newer features.

This file serves as a journal of my configuration, mainly
as a reminder for myself of the features that I have already
implemented and the ones that I want to look into in the future.
As a side, I also gather here the most useful documentation
pages and guides, they can always come in handy (again).
Needless to say, this configuration is work in progress,
but you are never really done configuring vim.

## Config
- System clipboard
- Python2 disabled
- Python3 set up: pynvim installed with pacman

## Plugins
Remember to have [vim plug](https://github.com/junegunn/vim-plug) installed
before adding any plugins

- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter): parsing library that allows better highlighting,
indentation, folding etc.
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): LSP support. See [avaliable servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

### LSP servers
The following are used in this configuration, install with pacman if possible:

+ [pylsp](https://github.com/python-lsp/python-lsp-server)
    - [pyflakes](https://github.com/PyCQA/pyflakes): error detection
+ [texlab](https://github.com/latex-lsp/texlab)

## TODO
- [Go full Lua](https://github.com/nanotee/nvim-lua-guide)
- Consider switching to [packer](https://github.com/wbthomason/packer.nvim)
