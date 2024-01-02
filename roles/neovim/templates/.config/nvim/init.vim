let mapleader = ' '

call plug#begin('~/.config/nvim/autoload')

""""""""Plugins affecting all languages """"""""""

" Common configurations for the language server
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
source $HOME/.config/nvim/vim/telescope.vim

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

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

" initialize plugin system
call plug#end()

" initialize Lua Configs
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "ansiblels",
        "bashls",
        "dockerls",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "pyright",
        "taplo",
        "terraformls",
        "vimls",
        "yamlls"
    }
}
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end
    -- end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
}

require('nvim-cmp')
EOF


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
