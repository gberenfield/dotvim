" Vim syntax file
" Language: Me very own adr format
" Maintainer: Grge Berenfield
" Latest Revision: 17 September 2013

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "adr"
syn case ignore 

syn match Name "Name:"
syn match mytitle "Title:"
syn match Company "Company:"
syn match Category "Category:"
syn match Address "Address.*:"
syn match phone 'Phone.*:'
syn match Email 'Email.*:'
syn match Notes "Notes:"
syn match Jabber "Jabber:"
syn match XMPP "xmpp:"
syn match Nickname "Nickname:"
syn match Skype "Skype:"
syn match Url "URL.*:"
syn match Birthday "Birthday:"

syn region adrblock start="\n^Name" end="###" fold contains=ALL

highlight def link Name Keyword
highlight def link mytitle Identifier
highlight def link Company  Identifier
highlight def link Category  Identifier
highlight def link Address  Identifier
highlight def link phone  Identifier
highlight def link Email Identifier
highlight def link Nickname Identifier
highlight def link Jabber Identifier
highlight def link XMPP Identifier
highlight def link Birthday Identifier
highlight def link Skype Identifier
highlight def link URL Identifier
highlight def link Notes Identifier
