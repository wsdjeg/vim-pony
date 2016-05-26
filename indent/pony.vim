" Vim indent file
" Language:     Pony
" Maintainer:   Jak Wings
" Last Change:  2016 May 26

if exists('b:did_indent')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


setlocal nolisp
setlocal nocindent
setlocal noautoindent
setlocal nosmartindent
setlocal indentexpr=pony#Indent()
setlocal indentkeys=!^F,o,O,0\|,0(,0),0[,0],0{,0},0==>,0=end,0=then,0=else,0=in,0=do,0=until,0=actor,0=class,0=struct,0=primitive,0=trait,0=interface,0=new,0=be,0=fun,0=type,0=use
setlocal cinkeys=!^F,o,O,0\|,0(,0),0[,0],0{,0},0==>,0=end,0=then,0=else,0=in,0=do,0=until,0=actor,0=class,0=struct,0=primitive,0=trait,0=interface,0=new,0=be,0=fun,0=type,0=use
setlocal cinwords=ifdef,if,match,while,for,repeat,try,with,recover,object,lambda,then,elseif,else,until,do,actor,class,struct,primitive,trait,interface,new,be,fun
augroup pony
autocmd pony CursorHold <buffer> call pony#ClearTrailingSpace(1, 1)
autocmd pony InsertEnter <buffer> call pony#ClearTrailingSpace(0, 0)
autocmd pony InsertLeave <buffer> call pony#ClearTrailingSpace(0, 1)
autocmd pony BufWritePre <buffer> call pony#ClearTrailingSpace(1, 1)
augroup END
let b:undo_indent = 'setlocal lisp< cindent< autoindent< smartindent< indentexpr< indentkeys< cinkeys< cinwords<'
      \ . ' | execute("autocmd! pony") | augroup! pony'


let &cpo = s:cpo_save
unlet s:cpo_save

let b:did_indent = 1
