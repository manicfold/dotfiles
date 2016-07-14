" Vim syntax file
" Language: Franca Interface Definition Language
" Maintainer: Philipp Blanke
" Latest Revision: 27 October 2015

if exists("b:current_syntax")
   finish
endif

syn keyword fidlType Boolean String ByteBuffer Enumerations
syn keyword fidlType Int8 UInt8 Int16 UInt16 Int32 UInt32 Int64 UInt64
syn keyword fidlType Float Double

syn keyword fidlConstant version major minor

syn keyword fidlKeyword package nextgroup=fidlIdentifier skipwhite
syn keyword fidlStructure enumeration struct nextgroup=fidlIdentifier skipwhite
syn keyword fidlKeyword attribute interface nextgroup=fidlIdentifier skipwhite
syn keyword fidlMethod method nextgroup=fidlIdentifier skipwhite
syn keyword fidlSignature in out

syn match fidlIdentifier "\S\+" contained

syn keyword fidlTodo contained TODO FIXME XXX NOTE
syn match fidlComment "<\*\*\_.*\*\*>" contains=fidlTodo

syn region fidlBlock start="{" end="}" fold transparent

highlight link fidlType Type
highlight link fidlKeyword Keyword
highlight link fidlMethod Function
highlight link fidlConstant Constant
highlight link fidlComment Comment
highlight link fidlIdentifier Identifier
highlight link fidlStructure Structure
highlight link fidlTodo Todo
highlight link fidlSignature Label

let b:current_syntax = "fidl"
