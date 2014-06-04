set nocompatible
filetype on
filetype indent on
filetype plugin on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'bkad/CamelCaseMotion'
Plugin 'groenewege/vim-less'
"Plugin 'godlygeek/tabular'
Plugin 'koron/nyancat-vim'
Plugin 'pangloss/vim-javascript'

" Syntastic
let g:syntastic_html_tidy_ignore_errors = ['trimming empty <p>', 'trimming empty <dt>', 'trimming empty <span>', 'trimming empty <i>', '<form> lacks "action" attribute', 'unescaped & which should be written as &amp;', '<input> attribute "type" has invalid value "email"', '<img> lacks "src" attribute']

autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead Berksfile set ft=ruby
autocmd BufNewFile,BufRead Gemfile set ft=ruby
autocmd BufNewFile,BufRead Vagrantfile set ft=ruby
autocmd BufNewFile,BufRead Rakefile set ft=ruby
autocmd BufNewFile,BufRead Thorfile set ft=ruby

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

let NERDTreeIgnore = ['\.pyc$']
map <silent> <C-n> :NERDTreeFocus<CR>

set smartindent
inoremap # X<BS>#
set tabstop=4
set shiftwidth=4
set expandtab
set t_Co=256
set hlsearch
syntax on
set number

colorscheme cotingale

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
