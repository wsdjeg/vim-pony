" Vim syntax file
" Language:     Pony
" Maintainer:   Jak Wings
" Last Change:  2016 November 4

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn case match

syn sync match ponySync grouphere NONE /\v^\s*%(actor|class|struct|primitive|trait|interface|new|be|fun|let|var|embed|use)>/

syn match   ponyErrPrime        /'/
hi def link ponyErrPrime        Error

syn match   ponyErrNumGroup     /__\+/ contained
hi def link ponyErrNumGroup     Error

syn match   ponyPeriodComma     /[.,]/
hi def link ponyPeriodComma     Operator

syn match   ponyInteger         /\v%(\d+_*)+/ contains=ponyErrNumGroup
syn match   ponyErrIntDec       /\v(0[xX])@<=[_.g-zG-Z]/
syn match   ponyErrIntHex       /[.g-zG-Z]/ contained
syn match   ponyInteger         /\v0[xX]%(\x+_*)+/ contains=ponyErrNumGroup nextgroup=ponyErrIntHex
syn match   ponyErrIntDec       /\v(0[bB])@<=[_2-9a-zA-Z]/
syn match   ponyErrIntBin       /[2-9.a-zA-Z]/ contained
syn match   ponyInteger         /\v0[bB]%([01]+_*)+/ contains=ponyErrNumGroup nextgroup=ponyErrIntBin
hi def link ponyErrIntDec       Error
hi def link ponyErrIntHex       Error
hi def link ponyErrIntBin       Error
hi def link ponyInteger         Number

syn match   ponyFloat           /\v%(\d+_*)+[eE][-+]?%(\d+_*)+/ contains=ponyErrNumGroup
syn match   ponyFloat           /\v%(\d+_*)+\.%(\d+_*)+%([eE][-+]?%(\d+_*)+)?/ contains=ponyErrNumGroup
hi def link ponyFloat           Float

syn match   ponyErrUserVariable /\v_>|<%([^_a-z]|_[^a-z])/ contained
hi def link ponyErrUserVariable Error
syn match   ponyUserVariable    /\v[_a-zA-Z]\w*'?/ contained contains=ponyErrUserVariable
hi def link ponyUserVariable    Identifier
syn match   ponyErrUserPackage  /\<[^a-z]/ contained
hi def link ponyErrUserPackage  Error
syn match   ponyUserPackage     /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserPackage
hi def link ponyUserPackage     Identifier
syn match   ponyErrUserType     /\v_>|<%([^_A-Z]|_[^A-Z])/ contained
hi def link ponyErrUserType     Error
" XXX: ponyTypeOperator:, no check: fun work(job: String, done: Bool)
syn match   ponyUserType2       /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserType nextgroup=ponyArgument,ponyTypeOperator,ponyKwOperatorT,ponyBracketT skipwhite skipempty
syn match   ponyUserType        /\v_?[A-Z]\w*/ contained contains=ponyErrUserType nextgroup=ponyArgument,ponyTypeOperator,ponyKwOperatorT,ponyBracketT skipwhite skipempty
syn match   ponyErrUserMethod   /\v_>|<%([^_a-z]|_[^a-z])/ contained
hi def link ponyErrUserMethod   Error
syn match   ponyUserMethod      /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserMethod nextgroup=ponyMethodArguments skipwhite skipempty
hi def link ponyUserMethod      Function
syn match   ponyForeignFunction /\v[_a-zA-Z]\w*/ contained nextgroup=ponyBracketT skipwhite skipempty
hi def link ponyForeignFunction Macro

syn keyword ponyBoolean         true false
hi def link ponyBoolean         Boolean

syn match   ponyDefaultAssign   /=/ contained nextgroup=@ponyValue skipwhite skipempty

syn region  ponyMethodArguments matchgroup=ponyBracket start=/(/ end=/)/ contained contains=@ponyComments,@ponyKeyword,ponyBracketT,ponySymbol,ponyPeriodComma,ponyDefaultAssign

syn region  ponyBracketT        matchgroup=ponyBracket start=/(/ end=/)/ contained contains=@ponyComments,@ponyKeyword,@ponyType2,ponyBracketT,ponySymbol,ponyPeriodComma nextgroup=ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
syn region  ponyBracketT        matchgroup=ponyBracket start=/\[/ end=/\]/ contained contains=@ponyComments,@ponyKeyword,@ponyType2,ponyBracketT,ponySymbol,ponyPeriodComma nextgroup=ponyTypeOperator,ponyKwOperatorT skipwhite skipempty

syn region  ponyArgument        matchgroup=ponyBracket start=/(/ end=/)/ contained contains=@ponyValue,ponyPeriodComma

syn match   ponyBracket         /[{[()\]}]/

syn match   ponyKwRcapSuffix    /[!^]/ nextgroup=ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
hi def link ponyKwRcapSuffix    StorageClass

syn match   ponyTypeOperator    /\v\&|\|%(.*\=\>)@!/ contained nextgroup=ponyBracketT,@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyTypeOperator    Operator

syn match   ponyNumberOperator  /==\|!=\|<<\|>>\|<=\|>=\|[+\-*/%<>]/
hi def link ponyNumberOperator  Operator

syn keyword ponyKwOperatorT     is contained nextgroup=ponyBracketT,@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyKwOperatorT     Operator

syn keyword ponyKwOperator      as nextgroup=ponyBracketT,@ponyKeyword,@ponyType2 skipwhite skipempty
syn keyword ponyKwOperator      and or xor not is isnt consume addressof digestof
hi def link ponyKwOperator      Operator

syn match   ponySymbol          /=>\|->\|\.\{3}\|[?#]/
syn match   ponySymbol          /@/ nextgroup=ponyForeignFunction skipwhite skipempty
syn match   ponySymbol          /:/ nextgroup=@ponyKeyword,@ponyType2,ponyBracketT skipwhite skipempty
hi def link ponySymbol          Special

" $scripts/gen_id.sh $packages/builtin
syn keyword ponyBuiltinType     AmbientAuth Any Array ArrayKeys ArrayPairs
                          \     ArrayValues AsioEvent AsioEventID
                          \     AsioEventNotify Bool ByteSeq ByteSeqIter
                          \     Comparable Compare DisposableActor
                          \     DoNotOptimise Env Equal Equatable F32 F64
                          \     Float FloatingPoint Greater HasEq I128 I16 I32
                          \     I64 I8 ILong ISize Int Integer Iterator Less
                          \     MaybePointer None Number OutStream Platform
                          \     Pointer ReadElement ReadSeq Real Seq Signed
                          \     SourceLoc StdStream Stdin StdinNotify String
                          \     StringBytes StringRunes Stringable U128 U16
                          \     U32 U64 U8 ULong USize Unsigned
                          \     nextgroup=ponyArgument,ponyTypeOperator,ponyKwOperatorT,ponyBracketT skipwhite skipempty
hi def link ponyBuiltinType     Type

syn keyword ponyKwControl       end else do then elseif match while for in repeat until
                        \       ifdef try with recover return break continue error
                        \       compile_intrinsic compile_error
hi def link ponyKwControl       Keyword

syn match   ponyKwControl       /\<if\>/
syn match   ponyKwControl       /|/
syn match   ponyCaseGuard       /\v(\|.{-})@<=<if>(.{-}\=\>)@=/
hi def link ponyCaseGuard       Keyword

syn keyword ponyKwAtom          this object lambda __loc
hi def link ponyKwAtom          Keyword

syn keyword ponyKwField         let var embed nextgroup=@ponyKeyword,ponyUserVariable skipwhite skipempty
hi def link ponyKwField         Keyword

syn keyword ponyKwUse           use nextgroup=ponyString,@ponyKeyword,ponyUserPackage skipwhite skipempty
hi def link ponyKwUse           Include

syn keyword ponyKwWhere         where
hi def link ponyKwWhere         Keyword

syn keyword ponyKwTypedef       type nextgroup=@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyKwTypedef       Typedef

syn match   ponyKwCapability    /\v#%(read|send|share|alias|any)>/ nextgroup=ponyKwRcapSuffix,ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
syn keyword ponyKwCapability    ref val tag iso box trn nextgroup=ponyKwRcapSuffix,ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
hi def link ponyKwCapability    StorageClass

syn keyword ponyKwClass         actor class struct primitive trait interface nextgroup=@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyKwClass         Structure

syn keyword ponyKwFnCapability  ref val tag iso box trn contained nextgroup=@ponyKeyword,ponyUserMethod skipwhite skipempty
hi def link ponyKwFnCapability  StorageClass
syn keyword ponyKwFunction      new be fun nextgroup=ponyKwFnCapability,@ponyKeyword,ponyUserMethod skipwhite skipempty
hi def link ponyKwFunction      Keyword

syn cluster ponyKeyword         contains=ponyKwClass,ponyKwCapability,ponyKwTypedef,ponyKwWhere,ponyKwUse,ponyKwFunction,ponyKwField,ponyKwAtom,ponyKwControl,ponyKwOperator,ponyBoolean,ponyBuiltinType
syn cluster ponyType            contains=ponyBuiltinType,ponyUserType
syn cluster ponyType2           contains=ponyBuiltinType,ponyUserType2
syn cluster ponyValue           contains=ponyDocumentString,ponyString,ponyCharacter,ponyBoolean,ponyFloat,ponyInteger,ponyArgument
syn cluster ponyComments        contains=ponyNestedComment,ponyComment

syn match   ponyErrEscape       /\\\_.\?\_s*/ contained
hi def link ponyErrEscape       Error
syn match   ponyEscape          /\\[abefnrtv"'\\0]/ contained
syn match   ponyEscape          /\v\\x\x{2}/ contained
syn match   ponyEscape          /\v\\u\x{4}/ contained
syn match   ponyEscape          /\v\\U\x{6}/ contained
hi def link ponyEscape          SpecialChar

syn region  ponyCharacter       matchgroup=ponyCharacterX start=/\w\@<!'/ skip=/\\./ end=/'/ contains=ponyEscape,ponyErrEscape
hi def link ponyCharacter       Character

syn region  ponyString          matchgroup=ponyStringX start=/"/ skip=/\\./ end=/"/ contains=ponyEscape,ponyErrEscape
hi def link ponyString          String
syn region  ponyDocumentString  matchgroup=ponyDocumentStringX start=/"\ze""/ end=/"""*\zs"/
hi def link ponyDocumentString  String

syn keyword ponyCommentShit     XXX contained
hi def link ponyCommentShit     Underlined
syn keyword ponyCommentDamn     FIXME contained
hi def link ponyCommentDamn     Error
syn keyword ponyCommentTodo     TODO contained
hi def link ponyCommentTodo     Todo
syn cluster ponyCommentNote     contains=ponyCommentTodo,ponyCommentDamn,ponyCommentShit

syn match   ponyComment         @//.*$@ contains=@ponyCommentNote,ponyCommentX
hi def link ponyComment         Comment
syn region  ponyNestedComment   matchgroup=ponyNestedCommentX start=@/\ze\*@ end=@\*\zs/@ contains=ponyNestedComment,@ponyCommentNote keepend extend fold
hi def link ponyNestedComment   Comment

" for indent check
syn match   ponyCommentX        @/\ze/.*$@ contained transparent
hi def link ponyNestedCommentX  Comment
hi def link ponyCharacterX      Character
hi def link ponyStringX         String
hi def link ponyDocumentStringX String


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = 'pony'
