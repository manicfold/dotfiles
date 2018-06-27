" Vim syntax file
" Language:    	   	FIDL (FRANCA Interface Description Language)
" Maintainer:  	   	Gabriel Almeida <gabrielmarchesan AT gmail DOT com>
" Latest Revision:   	Sat Jun 18 2016
" History:
" 0.1 (2015-06-30): Gabriel Almeida - first proposal
" 0.2 (2016-06-18): Oleksandr Kravchuk - cleanups and small improvements
" 0.3 (2017-12-05): Philipp Blanke - 

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

" Keywords codelanguage-def[Franca]
syn keyword fidlBoolean    true false  skipwhite

syn keyword fidlType       Boolean String ByteBuffer Enumerations skipwhite
syn keyword fidlType       Int8 UInt8 Int16 UInt16 Int32 UInt32 Int64 UInt64 skipwhite
syn keyword fidlType       Float Double skipwhite

syn keyword fidlStructure  typedef  skipwhite
syn keyword fidlStructure  enumeration union struct nextgroup=fidlIdentifier skipwhite

syn keyword fidlMethod     method nextgroup=fidlIdentifier skipwhite

syn keyword fidlSignature  in out

syn keyword fidlKeyword    package nextgroup=fidlIdentifier skipwhite
syn keyword fidlKeyword    attribute interface nextgroup=fidlIdentifier skipwhite
syn keyword fidlKeyword    typeCollection broadcast error  skipempty skipwhite 
syn keyword fidlKeyword    readonly noSubscriptions fireAndForget selective manages array of  skipempty skipwhite
syn keyword fidlKeyword    is map to extends polymorphic  skipempty skipwhite
syn keyword fidlKeyword    contract PSM vars state transition initial call respond signal set update  skipempty skipwhite

syn keyword fidlConstant   version major minor const  skipempty skipwhite


syn match fidlIdentifier "\S\+" contained
syn region fidlComment start='<\*\*' end='\*\*>'
syn region cComment start='/\*' end='\*/'
syn keyword fidlTodo       TODO FIXME XXX NOTE skipwhite containedin=fidlComment

syn region fidlBlock start="{" end="}" fold transparent

highlight link fidlType       Type
highlight link fidlKeyword    Keyword
highlight link fidlMethod     Function
highlight link fidlConstant   Constant
highlight link fidlComment    SpecialComment
highlight link fidlIdentifier Identifier
highlight link fidlStructure  Structure
highlight link fidlTodo       Todo
highlight link fidlSignature  Label

highlight link cComment       Comment

let b:current_syntax = "fidl"
