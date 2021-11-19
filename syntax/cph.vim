if exists("b:current_syntax")
  finish
endif

" KeyWords
syn keyword FIELDS INPUT OUTPUT EXPECTED
syn keyword PASSEd PASSED
syn keyword FAILED FAILED

syn match NUMBERS '\d\+'
syn match NUMBERS '[-+]\d\+'

hi FIELDS guibg=#363636 guifg=#ffffff
hi FAILED guibg=#cd0e31 guifg=#ffffff
hi PASSED guibg=#397f21 guifg=#ffffff
hi NUMBERS guifg=#d09a61
