set nocompatible
set nofoldenable
set mouse-=a


"-ENCODING-
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8


"-TEXT FORMAT-
"--indentation--
set ruler
set preserveindent
set softtabstop=4               "fix backspace for tabs
set tabstop=4                   "4-space tabs"
set expandtab                   "tabs->spaces
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
"set number                      " always show line numbers
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set spell
set hidden
set smarttab
map <F3> mzgg=G`z<CR>
map <F1> :set paste<CR>

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
"set colorcolumn=80

hi Comment term=bold cterm=NONE ctermfg=DarkGray ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
hi Normal term=bold cterm=NONE ctermfg=Gray ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE

"-FUNCTIONS-
"--Add changelog in spec file--
autocmd BufRead *.spec noremap <F7> /%changelog<cr>:r!LC_ALL=C date +"\%a \%b \%d \%Y"<CR>I* <esc>A Mathieu Cinquin <mcinquin@merethis.net><CR>Release <esc>/Version:<cr>$T v$hy/Release <cr>$pa-<esc>/Release:<cr>$T v$hy/Release <cr>$po-<cr>

"--Save cursor position--
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"--Trailing Whitespaces--
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

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

"-VIM-PLUG-
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'w0rp/ale'
  Plug 'scrooloose/nerdtree'
  Plug 'Raimondi/delimitMate'
  Plug 'andymass/vim-matchup'
  Plug 'qwertologe/nextval.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'cespare/vim-toml'
  Plug 'hashivim/vim-terraform'
  Plug 'jvirtanen/vim-hcl'
  Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}  
  Plug 'pearofducks/ansible-vim'
call plug#end()

"-PLUGINS-
"--Solarized--
set t_Co=256
set background=dark
if filereadable(expand("~/.vim/plugged/vim-colors-solarized/colors/solarized.vim"))
  let g:solarized_termcolors=256
  let g:solarized_termtrans=0
  let g:solarized_contrast="normal"
  let g:solarized_visibility="normal"
  color solarized
endif

"--Vim-airline--
  "---Powerline---
  let g:airline_powerline_fonts=1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  
  let g:airline_theme = 'solarized'
  if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='›'  " Slightly fancier than '>'
    let g:airline_right_sep='‹' " Slightly fancier than '<'
  endif

"--ale--
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '✘'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

"--NERDTree--
map <C-n> :NERDTreeToggle<CR>

"--Vim-matchup--
:hi MatchParen ctermfg=red cterm=underline
:hi MatchWord ctermfg=red cterm=underline
:hi MatchParenCur ctermfg=red cterm=underline
:hi MatchWordCur ctermfg=red cterm=underline

"--Vim-nextval--
nmap <silent> <unique> <C-Up> <Plug>nextvalInc
nmap <silent> <unique> <C-Down> <Plug>nextvalDec

"prevent vim to add garbage characters in eof
:set t_RV=
