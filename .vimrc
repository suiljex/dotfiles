" [==================]
" | suiljex | .vimrc |
" [==================]

filetype plugin indent on "Включает определение типа файла, загрузку
                          "соответствующих ему плагинов и файлов отступов
                          
set encoding=utf-8        "Ставит кодировку UTF-8
set nocompatible          "Отключает обратную совместимость с Vi
syntax enable             "Включает подсветку синтаксиса

" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim')) "Если vim-plug не стоит
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

try
  call plug#begin('~/.vim/plugged')

" Project tree
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" ColorScheme
  Plug 'morhetz/gruvbox'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ErichDonGubler/vim-sublime-monokai'

" Search
  Plug 'rking/ag.vim'

" Initialize plugin system
  call plug#end()
catch
endtry

try
  " colorscheme solarized
  " colorscheme gruvbox
  colorscheme sublimemonokai

  set background=dark
catch
endtry


set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set clipboard=unnamed                 " Clipboard support (OSX)
set laststatus=2                      " Show status line on startup
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
set lazyredraw                        " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
set nowrap                            " Don't wrap long lines
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set listchars+=tab:>·                 " Show tabs
set listchars+=trail:·                " Show trailing whitespaces
set nobackup nowritebackup noswapfile " Turn off backup files
set noerrorbells novisualbell         " Turn off visual and audible bells
set autoindent                        " Always set autoindenting on
set copyindent                        " Copy the previous indentation on autoindenting
set expandtab shiftwidth=2 tabstop=2  " Two spaces for tabs everywhere
set history=500
set hlsearch                          " Highlight search results
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection


" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

set number            " Enable line numbers
set scrolloff=5       " Leave 5 lines of buffer when scrolling
set sidescrolloff=10  " Leave 10 characters of horizontal buffer when scrolling

" Showcase comments in italics
highlight Comment cterm=italic gui=italic


set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Spellcheck
" set spell spelllang=ru_ru,en_us
set nospell

" Encodings
set fileencodings=utf-8,windows-1251,iso-8859-15,koi8-r

map <C-n> :NERDTreeToggle<CR>
