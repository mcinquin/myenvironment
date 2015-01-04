"============================================================================
"File:        limbo.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Alex Efros <powerman-asdf@ya.ru>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists("g:loaded_syntastic_limbo_limbo_checker")
    finish
endif
let g:loaded_syntastic_limbo_limbo_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_limbo_limbo_GetLocList() dict
    let include = $INFERNO_HOME != '' ? '-I$INFERNO_HOME ' : ''
    " don't generate .dis in current dir while checking syntax,
    " .dis should be generated by `mk`
    let output = filereadable('mkfile') ? (' ' . syntastic#c#NullOutput()) : ''

    let makeprg = self.makeprgBuild({ 'args_before': include . '-w' . output })

    let errorformat = '%E%f:%l:%m'
    if expand('%', 1) =~# '\m\.m$'
        let errorformat = '%-G%f:%l: near ` EOF ` : no implementation module,' . errorformat
    endif

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'limbo',
    \ 'name': 'limbo' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
