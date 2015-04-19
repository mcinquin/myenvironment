set nocompatible
set nofoldenable

"-Encoding-
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

"-Text Format-
"--indentation--
set ruler
set preserveindent
set softtabstop=4               "fix backspace for tabs
set tabstop=4                   "4-space tabs"
set expandtab                   "tabs->spaces
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
"set number                      " always show line numbers
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set spell
set hidden
set smarttab
set pastetoggle=<F1>
map <F3> mzgg=G`z<CR>
map <C-p><C-p> :set paste<CR>

"--searching options--
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch                   " show search matches as you type
set magic                       " magic regexp
set wildignore=*.swp,*.o,*.obj,*.bak,*.exe,*.so,*.dll,*.pyc,.sv,.hg,.bzr,.git

"--visual--
set history=1000                " remember more commands and search history
set showmatch                   " set show matching parenthesis
set undolevels=1000             " use many muchos levels of undo
set title                       " change the terminal's title
set titleold=                   " Don't set the title to 'Thanks for flying Vim' when exiting"
set showmode                    " Display the current mode
set laststatus=2
set colorcolumn=80

"-Pathogen-
execute pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

"-Solarized-
set t_Co=256
set background=dark
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized
endif


"hi Comment term=bold cterm=NONE ctermfg=DarkCyan ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE

"-Add changelog in spec file-
autocmd BufRead *.spec noremap <F7> /%changelog<cr>:r!LC_ALL=C date +"\%a \%b \%d \%Y"<CR>I* <esc>A Mathieu Cinquin <mcinquin@merethis.net><CR>Release <esc>/Version:<cr>$T v$hy/Release <cr>$pa-<esc>/Release:<cr>$T v$hy/Release <cr>$po-<cr>

"-Save cursor position-
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif
endif

"-Trailing Whitespaces-
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
function! StripTrailingWhiteSpaces()
    "Store the current position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Strip white spaces
    %s/\s\+$//e
    " Restore previous search history and cursor position
    let @/=_s
    call cursor(l, c)
endfunction"
map <F2> :call StripTrailingWhiteSpaces()<CR>

"-Powerline-
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"vim-airline {
    let g:airline_theme = 'solarized'
    if !exists('g:airline_powerline_fonts')
       " Use the default set of separators with a few customizations
        let g:airline_left_sep='›'  " Slightly fancier than '>'
        let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
"}

"-NERDTreeToggle-
map <C-n> :NERDTreeToggle<CR>

"-SnipMate-
let g:snippets_dir = "~/.vim/bundle/vim-snippets/snippets/"

"-Syntastic-
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_enable_sh_checker = 1
let g:syntastic_sh_checkers = ['sh']
let g:syntastic_enable_python_checker = 1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '⚠'

"-Python-Mode-
autocmd FileType python setlocal nonumber
autocmd FileType python map <buffer> <F5> :PymodeLint<CR>
autocmd FileType python map <buffer> <F6> :PymodeLintAuto<CR>
let g:pymode_lint_on_fly = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_lint_ignore = "E501,W0401,E128"
let g:pymode_lint_error_symbol = '✘'
let g:pymode_lint_todo_symbol = '⚠'
let g:pymode_lint_docs_symbol = '✍'
let g:pymode_lint_comment_symbol = '♯'
let g:pymode_lint_visual_symbol ='ⓥ'
let g:pymode_lint_info_symbol = '✆'
let g:pymode_lint_pyflakes_symbol = 'Π'
