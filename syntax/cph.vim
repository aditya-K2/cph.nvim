if exists("b:current_syntax")
  finish
endif

" KeyWords
syn keyword FIELDS INPUT OUTPUT EXPECTED_OUTPUT
syn keyword PASSED PASSED
syn keyword FAILED FAILED

syn match NUMBERS '\d\+'
syn match NUMBERS '[-+]\d\+'
syn match STRINGS "[a-z\ _A-Z]"

hi FIELDS guibg=#131313 guifg=#ffffff
hi STRINGS guifg=#d09a61 guibg=black
hi FAILED guibg=#cd0e31 guifg=#ffffff
hi PASSED guibg=#397f21 guifg=#ffffff
hi NUMBERS guifg=#b5cea8 guibg=black
