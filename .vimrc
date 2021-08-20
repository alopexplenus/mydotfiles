set nocompatible              " be iMproved, required
set shell=/bin/bash
filetype on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'shawncplus/phpcomplete.vim'
"Plugin 'lifepillar/vim-mucomplete'
"Plugin 'vim-scripts/phpfolding.vim'
"
Plugin 'L9'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'sjl/gundo.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'
Plugin 'amadeus/vim-mjml'
Plugin 'mechatroner/rainbow_csv'
Plugin 'rbtnn/vim-game_engine'
Plugin 'rbtnn/vim-mario'

"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
"
"
filetype plugin on    " required
syntax enable
set tabstop=4
set tabpagemax=50
set shiftwidth=4
set expandtab "even if i press the tab button, still use 4 spaces instead
set wrap
set linebreak
set number
set ai
set smartindent
set noswapfile
set nobackup
set incsearch
set ignorecase
set listchars=tab:..
set wildignore=*.o,*.obj,*.bak,*.exe
set visualbell t_vb=
let g:netrw_liststyle = 3

"set ffs=unix,dos,mac
"set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

set pastetoggle=<F12>

nmap :W :w
nmap :цй :wq
nmap :цф :wa
nmap :Цй :wq
nmap :Цф :wa
nmap :ЦЙ :wa
nmap :ЦЙ :wq
nmap :цйф :wqa
nmap :Цйф :wqa
nmap :ЦЙф :wqa
nmap :ц :w
nmap :Ц :w
nmap :Q :q
nmap :й :q
nmap :Й :q
nmap :ефиу :tabe
nmap сц cw
nmap сшц ciw
nmap ншц yiw
nmap пе gt
nmap пЕ gT


"Disable Accidental Ex mode
nmap Q <Nop>


":au FocusLost * :set norelativenumber
":au FocusGained * :set relativenumber
"
"autocmd InsertEnter * :set norelativenumber
"autocmd InsertLeave * :set relativenumber
"
"
function! NumberToggle()
  if(&number == 1)
    set norelativenumber
    set nonumber
  else 
    set number
    set relativenumber
  endif
endfunc


nnoremap <C-N> :call NumberToggle()<cr>

set number
set relativenumber

"nmap <C-N><C-N> :set invnumber<CR>
"nmap <C-J> i <Enter> <Esc>

"imap {<Enter>  { <Enter>} <UP><end><Enter>
"imap (  ()<LEFT>
"imap [  []<LEFT>
" automatically leave insert mode after 'updatetime' milliseconds of inaction
"au CursorHoldI * stopinsert



" Включаем фолдинг для блоков классов/функций
let php_folding = 1

" Не использовать короткие теги PHP для поиска PHP блоков
let php_noShortTags = 1

" Подстветка SQL внутри PHP строк
"let php_sql_query=1

" Подстветка HTML внутри PHP строк
"let php_htmlInStrings=1 

" Подстветка базовых функций PHP
let php_baselib = 1

au! BufNewFile,BufRead *.tpl set filetype=php
au! BufNewFile,BufRead *.cmst set filetype=php
au! BufNewFile,BufRead *.mjml set filetype=xml


" Russian language keyboard mappings (UTF-8)
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х { 
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >
" End of the mapping

colorscheme desert
hi clear CursorLine
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
set ma

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
