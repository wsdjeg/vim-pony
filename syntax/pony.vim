" Vim syntax file
" Language:     Pony
" Maintainer:   Jak Wings
" Last Change:  2016 May 26

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn case match

syn sync match ponySync grouphere NONE /\v^\s*%(actor|class|struct|primitive|trait|interface|new|be|fun|let|var|embed|use)>/

syn match   ponyErrNumGroup     /__\+/ contained
hi def link ponyErrNumGroup     Error

syn match   ponyErrIntDec       /\v(%(\d+_*)+)@<=\./
syn match   ponyPrime           /'/ contained nextgroup=ponyPeriod
syn match   ponyPeriod          /\./ contained

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

" for ponyErrIntDec
syn match   ponyNormal          /\v_?[_a-z]\w*/ nextgroup=ponyPrime,ponyPeriod

syn match   ponyNormalType      /\v_?[A-Z]\w*/ nextgroup=ponyTypeOperator,ponyKwOperatorT,@ponyBracketT skipwhite skipempty

syn match   ponyErrUserVariable /\v<%([^_a-z]|_[^a-z])/ contained
hi def link ponyErrUserVariable Error
syn match   ponyUserVariable    /\v[_a-zA-Z]\w*'?/ contained contains=ponyErrUserVariable
hi def link ponyUserVariable    Identifier
syn match   ponyErrUserPackage  /\<[^a-z]\|'/ contained
hi def link ponyErrUserPackage  Error
syn match   ponyUserPackage     /\v[_a-zA-Z]\w*'?/ contained contains=ponyErrUserPackage
hi def link ponyUserPackage     Identifier
"syn match   ponyErrUserType     /\v<%([^_A-Z]|_[^A-Z])|'/ contained
"hi def link ponyErrUserType     Error
"syn match   ponyUserType        /\v[_a-zA-Z]\w*'?/ contained contains=ponyErrUserType nextgroup=ponyTypeOperator,ponyKwOperatorT,@ponyBracketT skipwhite skipempty
syn match   ponyUserType        /\v_?[A-Z]\w*/ contained nextgroup=ponyTypeOperator,ponyKwOperatorT,@ponyBracketT skipwhite skipempty
syn match   ponyErrUserMethod   /\v<%([^_a-z]|_[^a-z])|'/ contained
hi def link ponyErrUserMethod   Error
syn match   ponyUserMethod      /\v[_a-zA-Z]\w*'?/ contained contains=ponyErrUserMethod
hi def link ponyUserMethod      Function
syn match   ponyForeignFunction /\v[_a-zA-Z]\w*'?/ contained nextgroup=ponyBracketTL skipwhite skipempty
hi def link ponyForeignFunction Macro

syn keyword ponyBoolean         true false
hi def link ponyBoolean         Boolean

syn match   ponyBracketTL       /[\[(]/ contained nextgroup=@ponyKeyword,@ponyType skipwhite skipempty
syn match   ponyBracketTR       /[)\]]/ contained nextgroup=ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
syn match   ponyBracket         /[{\[()\]}]/

syn cluster ponyBracketT        contains=ponyBracketTL,ponyBracketTR

syn match   ponyKwRcapSuffix    /[!^]/ nextgroup=ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
hi def link ponyKwRcapSuffix    StorageClass

syn match   ponyTypeOperator    /[|&,]/ contained nextgroup=ponyBracketTL,@ponyKeyword,@ponyType
hi def link ponyTypeOperator    Operator
syn match   ponyNumberOperator  /==\|!=\|<<\|>>\|<=\|>=\|[+\-*/%<>]/
hi def link ponyNumberOperator  Operator
syn keyword ponyKwOperatorT     is contained nextgroup=ponyBracketTL,@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyKwOperatorT     Operator
syn keyword ponyKwOperator      as nextgroup=ponyBracketTL,@ponyKeyword,@ponyType skipwhite skipempty
syn keyword ponyKwOperator      and or xor not is isnt consume addressof digestof
hi def link ponyKwOperator      Operator

syn match   ponySymbol          /=>\|->\|\.\{3}\|[?#]/
syn match   ponySymbol          /@/ nextgroup=ponyForeignFunction skipwhite skipempty
syn match   ponySymbol          /:/ nextgroup=@ponyKeyword,@ponyType,ponyBracketTL skipwhite skipempty
hi def link ponySymbol          Special

syn keyword ponyBuiltinTrait    Integer Real FloatingPoint FormatSpec PrefixSpec nextgroup=ponyTypeOperator,ponyKwOperatorT,@ponyBracketT skipwhite skipempty
hi def link ponyBuiltinTrait    SpecialComment

syn keyword ponyBuiltinType     None Any Env Bool Number AmbientAuth F32 F64 Float
                          \     I8 I16 I32 I64 I128 ILong ISize Signed
                          \     U8 U16 U32 U64 U128 ULong USize Unsigned
                          \     String StringBytes StringRunes ArrayValues ByteSeqIter
                          \     OutStream StdStream Array ArrayPairs ArrayKeys
                          \     Comparable Seq Iterator ReadSeq ReadElement ByteSeq
                          \     DisposableActor Compare Less Equal Greator HasEq Equatable
                          \     AsioEvent AsioEventID AsioEventNotify Stdin StdinNotify
                          \     FormatGeneralLarge Pointer MaybePointer Platform SourceLoc
                          \     FormatExpLarge FormatFix FormatFixLarge FormatGeneral
                          \     FormatDefaultNumber FormatFloat FormatSettingsFloat FormatExp
                          \     FormatHexSmall FormatHexSmallBare FormatInt FormatSettingsInt
                          \     FormatOctal FormatOctalBare FormatHex FormatHexBare
                          \     PrefixDefault FormatUTF32 FormatBinary FormatBinaryBare
                          \     FormatSettingsDefault FormatSettingsHolder FormatDefault
                          \     PrefixSpace PrefixSign PrefixNumber FormatSettings
                          \     Creatable Stringable Align AlignLeft AlignRight AlignCenter
                          \     nextgroup=ponyTypeOperator,ponyKwOperatorT,@ponyBracketT skipwhite skipempty
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

syn keyword ponyKwFunction      new be fun nextgroup=@ponyKeyword,ponyUserMethod skipwhite skipempty
hi def link ponyKwFunction      Keyword

syn keyword ponyKwUse           use nextgroup=ponyString,@ponyKeyword,ponyUserPackage skipwhite skipempty
hi def link ponyKwUse           Include

syn keyword ponyKwTypedef       type nextgroup=@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyKwTypedef       Typedef

syn match   ponyKwCapability    /\v#%(read|send|share|alias|any)/ nextgroup=ponyKwRcapSuffix,ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
syn keyword ponyKwCapability    ref val tag iso box trn nextgroup=ponyKwRcapSuffix,ponyTypeOperator,ponyKwOperatorT skipwhite skipempty
hi def link ponyKwCapability    StorageClass

syn keyword ponyKwClass         actor class struct primitive trait interface nextgroup=@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyKwClass         Structure

syn cluster ponyKeyword         contains=ponyKwClass,ponyKwCapability,ponyKwTypedef,ponyKwUse,ponyKwFunction,ponyKwField,ponyKwAtom,ponyKwControl,ponyKwOperator,ponyBoolean,ponyBuiltinType,ponyBuiltinTrait
syn cluster ponyType            contains=ponyBuiltinTrait,ponyBuiltinType,ponyNormalType,ponyUserType

syn match   ponyErrEscape       /\\\_.\?\_s*/ contained
hi def link ponyErrEscape       Error
syn match   ponyEscape          /\\[abefnrtv"'\\0]/ contained
syn match   ponyEscape          /\v\\x\x{2}/ contained
syn match   ponyEscape          /\v\\u\x{4}/ contained
syn match   ponyEscape          /\v\\U\x{6}/ contained
hi def link ponyEscape          SpecialChar

syn region  ponyCharacter       start=/\w\@<!'/ skip=/\\'/ end=/'/ contains=ponyEscape,ponyErrEscape
hi def link ponyCharacter       Character

syn region  ponyString          start=/"/ skip=/\\"/ end=/"/ contains=ponyEscape,ponyErrEscape
hi def link ponyString          String
syn region  ponyDocumentString  start=/"""/ end=/""""*/
hi def link ponyDocumentString  String

syn keyword ponyCommentShit     XXX contained
hi def link ponyCommentShit     Underlined
syn keyword ponyCommentDamn     FIXME contained
hi def link ponyCommentDamn     Error
syn keyword ponyCommentTodo     TODO contained
hi def link ponyCommentTodo     Todo
syn cluster ponyCommentNote     contains=ponyCommentTodo,ponyCommentDamn,ponyCommentShit

syn match   ponyComment         @//.*$@ contains=@ponyCommentNote
hi def link ponyComment         Comment
syn region  ponyNestedComment   start=@/\*@ end=@\*/@ contains=ponyNestedComment,@ponyCommentNote keepend extend fold
hi def link ponyNestedComment   Comment


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = 'pony'
