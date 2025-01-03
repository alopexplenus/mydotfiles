set nocompatible              " be iMproved, required
set shell=/bin/bash

set exrc  " read .vimrc in the start directory of vim "

"
" FOR THIS TO WORK INSTALL VUNDLE FIRST !!!!!!!
"
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
"

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
"Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'
Plugin 'amadeus/vim-mjml'
Plugin 'mechatroner/rainbow_csv'
Plugin 'vimwiki/vimwiki'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'michal-h21/vim-zettel'
Plugin 'git@github.com:alopexplenus/vimwiki-sync.git'

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
set visualbell
let g:netrw_liststyle = 3
let g:netrw_sort_sequence = '\.[\/]$,index\.md,[^.][\/]$,\<core\%(\.\d\+\)\=,\.[a-np-z]$,\.h$,\.c$,\.cpp$,*,\.o$,\.obj$,)'


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


function! NumberToggle()
  if(&number == 1)
    set nonumber
  else 
    set number
  endif
endfunc


nnoremap <C-N> :call NumberToggle()<cr>

set number

"nmap <C-N><C-N> :set invnumber<CR>
"nmap <C-J> i <Enter> <Esc>

"imap {<Enter>  { <Enter>} <UP><end><Enter>
"imap (  ()<LEFT>
"imap [  []<LEFT>


let php_folding = 1
let php_noShortTags = 1
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

colorscheme pablo
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

let g:vimwiki_url_maxsave=0
let g:vimwiki_folding='expr'
let g:vimwiki_folding='expr'
let g:vimwiki_list = [{'path':'$HOME/notes', 'syntax':'markdown', 'ext':'.md'}]
let g:vimwiki_listsyms = ' .o~x'
let g:vimwiki_ext2syntax = {'.md':'markdown', '.markdown':'markdown', '.mdown':'markdown'}
let g:vimwiki_conceallevel=0


command -nargs=1 S VimwikiSearch <args>
cmap ln lnext
cmap lp lprevious

au BufNewFile,BufRead,BufReadPost *.md set nonumber
au BufNewFile,BufRead,BufReadPost *.mdown set nonumber
au BufNewFile,BufRead,BufReadPost *.markdown set nonumber

set foldlevel=99
set conceallevel=0 " for everything except markdown files in vimwiki

" automatically leave insert mode after 'updatetime' milliseconds of inaction
set updatetime=15000
au CursorHoldI * stopinsert

function! OpenPreviousFile()
    let current_file = expand('%:t') 
    let match = matchlist(current_file, '\(\d\+\)-KW\(\d\+\)')
    if empty(match[2])
        echo "no week number found"
    else
        let current_yr = match[1]
        let current_week = match[2]
        let previous_week = string((current_week - 1))  " Calculate the previous week number
        let previous_file = current_yr . '-KW' . previous_week . '.md'

        if filereadable(previous_file)
            execute 'edit ' . previous_file
        else
            echo "No previous file found"
        endif
    endif
endfunction

function! OpenNextFile()
    let current_file = expand('%:t') 
    let match = matchlist(current_file, '\(\d\+\)-KW\(\d\+\)')
    if empty(match[2])
        echo "no week number found"
    else
        let current_yr = match[1]
        let current_week = match[2]
        let next_week = string((current_week + 1))  " Calculate the previous week number
        let next_file = current_yr . '-KW' . next_week . '.md'

        if filereadable(next_file)
            execute 'edit ' . next_file
        else
            echo "No next file found. Create " . next_file . "? Y/N"
			let char = getchar()
			if char == 121 " y
				call Newnote(next_file)
			elseif char == 89 " Y
				call Newnote(next_file)
			else
				echo "got " . char . ", Staying in " . current_file
			endif

        endif
    endif
endfunction

function! Newnote(filename)

    let markerfile = '.latest_weekly_note'

    call writefile([a:filename], markerfile, 'w')

    " Remove the extension from the filename
    let l:header = substitute(a:filename, '\.md$', '', '')


    " Create the new markdown file
    execute 'edit' a:filename

    " Insert the header into the file
    call append(0, '# ' . l:header)
endfunction

let mapleader=" "

nnoremap <leader>h :call OpenPreviousFile()<CR>
nnoremap <leader>l :call OpenNextFile()<CR>

" Search for selected text with *
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
