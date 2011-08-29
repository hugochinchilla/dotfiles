set encoding=utf-8

syntax on
set smartindent
set nu
set background=dark
set tabstop=4           " number of space characters inserted by a tab key
set shiftwidth=4        " number of space inserted by indentation
set expandtab           " change tabs to spaces
set softtabstop=4       " how many spaces = tab

"""" Search and patterns
set ignorecase          " search case insensitive
set smartcase           " search case sensitive if Caps on
set hlsearch            " highlight matches

"""" Display
set scrolloff=3         " keep 3 lines below and above the cursor

"if has("gui_runnig")
"    colorscheme wombat
"endif

" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M

"""" Editting
set matchpairs+=<:>                     " specially for html

"""" Command Line
set wildmenu                            " Autocomplete features in the status bar
set wildmode=longest,list
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~


"PHP

autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>




"Python improvement

"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF
"
"set tags+=$HOME/.vim/tags/python.ctags

"""" Key bindings

"map <silent><C-Left> <C-T>
"map <silent><C-Right> <C-]>

nnoremap <silent><C-left>   :tabprevious
nnoremap <silent><C-right>  :tabnext

autocmd FileType python set omnifunc=pythoncomplete#Complete "autocompplete
inoremap <Nul> <C-x><C-o>

autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
