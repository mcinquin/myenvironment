"----------------------------------------------
" General settings
"----------------------------------------------
set nocompatible
set nofoldenable
set mouse-=a

"-ENCODING-
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

"-TEXT FORMAT-
"--indentation--
syntax on           " Enable syntax highlighting
filetype off          " Reset filetype detection first ...
filetype plugin indent on     " ... and enable filetype detection
set ruler
set sts=2 ts=2 sw=2 expandtab   " preserveindent, copyindent, softtabstop=2, shiftwidth=2, tabstop=2 expandtab"
set wrap linebreak nolist				" Word wrap without line breaks
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set smartindent                 " enable smart indentation
"set number                     " always show line numbers
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
set wildignore=*.swp,*.o,*.obj,*.bak,*.exe,*.so,*.dll,*.pyc,.sv,.hg,.bzr,.git,.svn,__pycache__,

"--visual--
set history=1000                " remember more commands and search history
set showmatch                   " set show matching parenthesis
set undolevels=1000             " use many muchos levels of undo
set title                       " change the terminal's title
set titleold=                   " Don't set the title to 'Thanks for flying Vim' when exiting"
set showmode                    " Display the current mode
set laststatus=2
"set colorcolumn=80
set noswapfile                    " disable swapfile usage
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!

"----------------------------------------------
" Functions
"----------------------------------------------
"-Add changelog in spec file-
autocmd BufRead *.spec noremap <F7> /%changelog<cr>:r!LC_ALL=C date +"\%a \%b \%d \%Y"<CR>I* <esc>A Mathieu Cinquin <mcinquin@merethis.net><CR>Release <esc>/Version:<cr>$T v$hy/Release <cr>$pa-<esc>/Release:<cr>$T v$hy/Release <cr>$po-<cr>

"make vim save and load the folding of the document each time it loads"
"also places the cursor in the last place that it was left."
au BufWinLeave * mkview
au BufWinEnter * silent loadview

"-Trailing Whitespaces-
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

"-Kubernetes-
augroup kubernetes
  au!
  au BufRead,BufNewFile */.kube/config set filetype=yaml
  au BufRead,BufNewFile */templates/*.yaml,*/deployment/*.yaml,*/templates/*.tpl,*/deployment/*.tpl set filetype=yaml.gotexttmpl
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
  au FileType yaml nmap <F5> :AsyncRun! kubeval '%:p'<CR>
  au FileType yaml nmap <F6> :cclose <CR>
augroup END

"----------------------------------------------
" Plugin management
"----------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" General
  Plug 'scrooloose/nerdtree'
  Plug 'Raimondi/delimitMate'
  Plug 'andymass/vim-matchup'
  Plug 'qwertologe/nextval.vim'
  Plug 'skywind3000/asyncrun.vim'

" Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

" Syntax/Lint
  Plug 'dense-analysis/ale'
  Plug 'ntpeters/vim-better-whitespace'

" Colorschemes
  Plug 'altercation/vim-colors-solarized'

" Language support
  Plug 'plasticboy/vim-markdown'
  Plug 'hashivim/vim-terraform'
  Plug 'jvirtanen/vim-hcl'
  Plug 'ekalinin/dockerfile.vim'
  Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
call plug#end()


"----------------------------------------------
" Plugin: altercation/vim-colors-solarized
"----------------------------------------------
set t_Co=256
set background=dark
if filereadable(expand("~/.vim/plugged/vim-colors-solarized/colors/solarized.vim"))
  let g:solarized_termcolors=256
  let g:solarized_termtrans=0
  let g:solarized_contrast="normal"
  let g:solarized_visibility="normal"
  color solarized
endif

hi Comment term=bold cterm=NONE ctermfg=242 ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
hi Normal term=bold cterm=NONE ctermfg=245 ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE

"----------------------------------------------
" Plugin: vim-airline/vim-airline
"----------------------------------------------
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

"----------------------------------------------
" Plugin: dense-analysis/ale
"----------------------------------------------
let g:airline#extensions#ale#enabled = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_linters = {'python': ['flake8'], 'ansible': ['ansible-lint'], 'dockerfile': ['hadolint'], 'terraform': ['terraform'], 'json': ['jsonlint']}
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '✘'
let g:ale_lint_on_enter = 1
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_yaml_yamllint_options = 'indentation: {spaces: 2, indent-sequences: consistent}'

"----------------------------------------------
" Plugin: ntpeters/vim-better-whitespace
"----------------------------------------------
let g:better_whitespace_enabled=1
let g:better_whitespace_ctermcolor='red'

"----------------------------------------------
" Plugin: pearofducks/ansible-vim
"----------------------------------------------
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'ob'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }

"----------------------------------------------
" Plugin: scrooloose/nerdtree
"----------------------------------------------
map <C-n> :NERDTreeToggle<CR>

"----------------------------------------------
" Plugin: skywind3000/asyncrun.vim
"----------------------------------------------
:let g:asyncrun_open = 8

"----------------------------------------------
" Plugin: andymass/vim-matchup
"----------------------------------------------
:hi MatchParen ctermfg=red cterm=underline
:hi MatchWord ctermfg=red cterm=underline
:hi MatchParenCur ctermfg=red cterm=underline
:hi MatchWordCur ctermfg=red cterm=underline

"----------------------------------------------
" Plugin: qwertologe/nextval.vim
"----------------------------------------------
nmap <silent> <unique> <C-Up> <Plug>nextvalInc
nmap <silent> <unique> <C-Down> <Plug>nextvalDec

"----------------------------------------------
" Plugin: aimondi/delimitMate
"----------------------------------------------
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

"----------------------------------------------
" Plugin: plasticboy/vim-markdown
"----------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

"prevent vim to add garbage characters in eof
:set t_RV=
