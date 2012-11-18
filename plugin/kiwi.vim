" kiwi.vim - Folding and abbreviations for Objective-C's Kiwi lib.
" Maintainer: Jason Felice <jason.m.felice@gmail.com>
" Version:    0.1

if exists('g:loaded_kiwi') || &cp
  finish
endif
let g:loaded_kiwi = 1

" Kiwi specs
augroup Kiwi
  autocmd!
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm iabbrev <buffer> It });<ESC>Oit(@"", ^{<ESC>^f"a<C-R>=<SID>Eatchar('\s')<CR>
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm iabbrev <buffer> Describe });<ESC>Odescribe(@"", ^{<ESC>^f"a<C-R>=<SID>Eatchar('\s')<CR>
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm iabbrev <buffer> Context });<ESC>Ocontext(@"", ^{<ESC>^f"a<C-R>=<SID>Eatchar('\s')<CR>
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm iabbrev <buffer> Pending });<ESC>Opending(@"", ^{<ESC>^f"a<C-R>=<SID>Eatchar('\s')<CR>
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm set foldmethod=expr foldexpr=KiwiFoldLevel(v:lnum)
augroup END

function! s:Eatchar(pat)
  let c= nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

function! KiwiFoldLevel(lnum)
  let line=getline(a:lnum)
  if line=~'^\s\s*\(context\|describe\|it\|pending\)\s*('
    return ">" . (indent(a:lnum) / (&sts ? &sts : &ts))
  elseif line=~'^\s\s*});\s*$' && getline(a:lnum+1)!~'^\s*$'
    return "<" . (indent(a:lnum) / (&sts ? &sts : &ts))
  elseif line=~'^\s*$' && getline(a:lnum-1)=~'^\s\s*});\s*$'
    return "<" . (indent(a:lnum-1) / (&sts ? &sts : &ts))
  elseif line=~'{{'.'{[0-9][0-9]*'
    return ">" . substitute(line, '^.*{{'.'{\([0-9]*\).*$', '\1', '')
  elseif line=~('{{'.'{')
    return 'a1'
  elseif line=~'[0-9][0-9]*}'.'}}'
    return "<" . substitute(line, '^.*\([0-9][0-9]*\)}'.'}}.*$', '\1', '')
  elseif line=~'}'.'}}'
    return 's1'
  else
    return '='
  endif
endfunction
