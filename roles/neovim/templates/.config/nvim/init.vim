let mapleader = ' '

call plug#begin()

""""""""Plugins affecting all languages """"""""""

" Common configurations for the language server
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" master is frozen---consider switching to main when
" nvim-treesitter-textobjects has a stable main branch
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'petertriho/cmp-git'

" Test execution
Plug 'vim-test/vim-test'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Code formatting
Plug 'sbdchd/neoformat'

" Git
Plug 'tpope/vim-fugitive'

" Gitlab
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.s.fpint.net']
let g:gitlab_api_keys = {'https://gitlab.s.fpint.net': 'RsTGh3cg6FDA6sBksAca'}

" Helm
Plug 'towolf/vim-helm'

" Nicer keyboard shortcuts
Plug 'tpope/vim-unimpaired'

" Comments
Plug 'tpope/vim-commentary'

" Alignment
Plug 'junegunn/vim-easy-align'

" Surround
Plug 'tpope/vim-surround'

" Tab for tab completion
Plug 'ervandew/supertab'

" Colorize html codes
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
set termguicolors

""""""" Specific Syntax Plugins """""""""""
" Python formatting
Plug 'psf/black', { 'branch': 'stable' }
let g:black_linelength = 79

Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }

" TOML syntax
Plug 'cespare/vim-toml'

" Terraform syntax
Plug 'hashivim/vim-terraform'

" Ansible syntax
Plug 'pearofducks/ansible-vim'

" Monkeyc Settings
Plug 'gcaufield/vim-monkey-c'

""""""""""""" Plugins for writing """""""""""""""

Plug 'junegunn/limelight.vim'

Plug 'junegunn/goyo.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" prevent parentheses from messing up line-wrapping
autocmd BufRead,BufNewFile *.md set nocindent

" PlantUML
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'

" Table mode
" Disabling because it doesn't seem to be working. Might be in conflict with
" another plugin
" Plug 'dhruvasagar/vim-table-mode'


"""""""" Other, non-programming plugins """"""""""

Plug 'machakann/vim-highlightedyank'

Plug 'tyru/open-browser.vim'

" Show dif hints int gutter
Plug 'mhinz/vim-signify'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='zenburn'
let g:airline_solarized_bg='dark'

" Color Schemes
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" initialize plugin system
lua require('plugins.lsp').setup()
lua require('plugins.treesitter').setup()
lua require('plugins.cmp').setup()

""""""""""""" Settings """""""""""
" Enable python3 in neovim
let g:python3_host_prog = '~/.pyenv/versions/neovim/bin/python3'


" Seoul256 color scheme
colorscheme nord
let g:airline_theme='zenburn' " goes with seoul256

" Fix tabs
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal cindent
setlocal smarttab
setlocal number

autocmd Filetype json setlocal tabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2
autocmd Filetype lua setlocal tabstop=2 shiftwidth=2

" Disable folding by default
set nofoldenable

" Set foldmethod to syntax to help with json folding
setlocal foldmethod=syntax

" Enable highlighting while typing sed-style substitutions
set inccommand=split

" Remap `jj` to escape
inoremap jj <esc>

"""""""""" YAML Config """"""""""""
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Automatically strip whitespaces upon save
autocmd BufWritePre <buffer> :%s/\s\+$//e

"""""""" MonkeyC Config """"""""""
autocmd FileType monkeyc setlocal commentstring=//\ %s

"""""""" Additional CoPilot Config """"""""""
augroup DisableCopilotSensitive
  autocmd!
  " Disable Copilot for files created by the 'pass' password manager
  " pass usually creates temp files in /dev/shm or /tmp starting with 'pass.'
  autocmd BufRead,BufNewFile /dev/shm/pass*,/tmp/pass*,*/pass.*/* let b:copilot_enabled = 0

  " Disable Copilot for sensitive file types
  autocmd BufRead,BufNewFile .env,.env.*,*.pem,*.key let b:copilot_enabled = 0
augroup END
