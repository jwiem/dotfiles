" Basic Vim Configuration
" Fallback for when Neovim isn't available

" General Settings
set nocompatible              " Use Vim settings, not Vi
filetype plugin indent on     " Enable file type detection
syntax on                     " Enable syntax highlighting

" UI Configuration
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set cursorline                " Highlight current line
set showmatch                 " Highlight matching brackets
set wildmenu                  " Visual autocomplete for command menu
set wildmode=longest:full,full
set laststatus=2              " Always show status line
set ruler                     " Show cursor position
set showcmd                   " Show command in bottom bar

" Search Settings
set incsearch                 " Search as characters are entered
set hlsearch                  " Highlight search matches
set ignorecase                " Case insensitive searching
set smartcase                 " Case sensitive if uppercase present

" Indentation
set autoindent                " Copy indent from current line
set smartindent               " Smart autoindenting
set tabstop=4                 " Number of visual spaces per TAB
set softtabstop=4             " Number of spaces in tab when editing
set shiftwidth=4              " Number of spaces to use for autoindent
set expandtab                 " Tabs are spaces

" Performance
set lazyredraw                " Redraw only when needed
set ttyfast                   " Faster scrolling

" Backups and Undo
set nobackup                  " No backup files
set nowritebackup             " No backup before overwriting
set noswapfile                " No swap files
set undofile                  " Persistent undo
set undodir=~/.vim/undo       " Undo directory
set undolevels=1000           " Maximum number of undos
set undoreload=10000          " Maximum lines to save for undo

" Split Settings
set splitbelow                " Horizontal splits below
set splitright                " Vertical splits to right

" Folding
set foldmethod=indent         " Fold based on indent
set foldlevel=99              " Open all folds by default

" Misc
set encoding=utf-8            " Use UTF-8 encoding
set backspace=indent,eol,start " Backspace over everything
set hidden                    " Allow hidden buffers
set mouse=a                   " Enable mouse support
set clipboard=unnamed         " Use system clipboard
set scrolloff=8               " Keep 8 lines above/below cursor
set sidescrolloff=8           " Keep 8 columns left/right of cursor

" Key Mappings
let mapleader = " "           " Set leader key to space

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Move lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Create undo directory if it doesn't exist
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p", 0700)
endif

" Auto-commands
augroup AutoSave
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
