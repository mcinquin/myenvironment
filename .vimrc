"----------------------------------------------
" General settings
"----------------------------------------------
set nocompatible
set nofoldenable
set mouse-=a
set clipboard+=unnamedplus

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
set noswapfile                  " disable swapfile usage
set noerrorbells                " No bells!
set novisualbell                " I said, no bells!
set signcolumn=auto             " Protect copy

"----------------------------------------------
" Functions
"----------------------------------------------
"-Add changelog in spec file-
autocmd BufRead *.spec noremap <F7> /%changelog<cr>:r!LC_ALL=C date +"\%a \%b \%d \%Y"<CR>I* <esc>A Mathieu Cinquin <mcinquin@merethis.net><CR>Release <esc>/Version:<cr>$T v$hy/Release <cr>$pa-<esc>/Release:<cr>$T v$hy/Release <cr>$po-<cr>

"make vim save and load the folding of the document each time it loads"
"also places the cursor in the last place that it was left."
au BufWrite * mkview
au BufRead * silent! loadview

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
  au BufRead,BufNewFile *.yaml
    \  if getline(1) =~? '^\(kind\|apiVersion\): ' || getline(2) =~? '^\(kind\|apiVersion\): ' || getline(3) =~? '^\(kind\|apiVersion\): ' || getline(4) =~? '^\(kind\|apiVersion\): ' || getline(5) =~? '^\(kind\|apiVersion\): '
    \|   set filetype=yaml.kubernetes syntax=yaml
    \| else
    \|   set filetype=yaml
    \| endif
  au BufRead,BufNewFile */templates/*.yaml,*/deployment/*.yaml,*/templates/*.tpl,*/deployment/*.tpl set filetype=yaml.gotexttmpl
  au FileType yaml,kubernetes setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
  au FileType yaml,kubernetes nmap <F5> :AsyncRun! kubeval '%:p'<CR>
  au FileType yaml,kubernetes nmap <F6> :cclose <CR>
augroup END

"----------------------------------------------
" Plugin management
"----------------------------------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"call plug#begin('~/.vim/plugged')
call plug#begin(stdpath('data') . '/plugged')
" General
  Plug 'scrooloose/nerdtree'
  Plug 'Raimondi/delimitMate'
  Plug 'andymass/vim-matchup'
  Plug 'qwertologe/nextval.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'SirVer/ultisnips'

" Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

" Syntax/Lint
  Plug 'dense-analysis/ale'
  Plug 'ntpeters/vim-better-whitespace'

" Colorschemes
  Plug 'altercation/vim-colors-solarized'
  "Plug 'rakr/vim-one'

" Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

" Language support
  Plug 'plasticboy/vim-markdown'
  Plug 'hashivim/vim-terraform'
  Plug 'jvirtanen/vim-hcl'
  Plug 'ekalinin/dockerfile.vim'
  Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
  Plug 'stephpy/vim-yaml'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()


"----------------------------------------------
" Plugin: rakr/vim-one
"----------------------------------------------
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif
"colorscheme one
"set background=dark
"let g:one_allow_italics = 1
"call one#highlight('vimLineComment', '8C8A8A', '', 'italic')

"----------------------------------------------
" Plugin: altercation/vim-colors-solarized
"----------------------------------------------
let autoload_plug_path = stdpath('data') . '/plugged/vim-colors-solarized/colors/solarized.vim'
if filereadable(autoload_plug_path)
  set t_Co=256
  set background=dark
  let g:solarized_termcolors=256
  let g:solarized_termtrans=0
  let g:solarized_contrast="normal"
  let g:solarized_visibility="normal"
  colorscheme solarized
  hi Comment term=bold cterm=NONE ctermfg=244 ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
  hi Normal term=bold cterm=NONE ctermfg=248 ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
endif

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
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
let g:airline#extensions#tabline#enabled = 1

"----------------------------------------------
" Plugin: dense-analysis/ale
"----------------------------------------------
let g:airline#extensions#ale#enabled = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_linters = {'python': ['flake8'], 'ansible': ['ansible-lint'], 'dockerfile': ['hadolint'], 'terraform': ['terraform', "terraform-lsp"], 'json': ['jsonlint']}
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '✘'
let g:ale_lint_on_enter = 1
let g:ale_sign_priority = 30
let g:ale_disable_lsp = 1
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

"----------------------------------------------
" Plugin: airblade/vim-gitgutter
"----------------------------------------------
set updatetime=100
let g:gitgutter_sign_priority=9
highlight clear SignColumn
"call gitgutter#highlight#define_highlights()

"----------------------------------------------
" Plugin: stephpy/vim-yaml
"----------------------------------------------
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setl indentkeys-=<:>

"----------------------------------------------
" Plugin: hashivim/vim-terraform
"----------------------------------------------
autocmd BufNewFile,BufRead *.tf     set filetype=terraform
autocmd BufNewFile,BufRead *.tfvars set filetype=terraform
autocmd BufNewFile,BufRead *.tfstate set filetype=json
let g:terraform_align=1
let g:terraform_fmt_on_save=1

"----------------------------------------------
" Plugin: SirVer/ultisnips
"----------------------------------------------
let g:UltiSnipsExpandTrigger="<c-g>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"----------------------------------------------
" Plugin: neoclide/coc.nvim
"----------------------------------------------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"----------------------------------------------
" Plugin: neoclide/coc-snippets
"----------------------------------------------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


"prevent vim to add garbage characters in eof
:set t_RV=
