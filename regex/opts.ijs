NB. options

CASELESS=: 16b1
MULTILINE=: 16b2
DOTALL=: 16b4
EXTENDED=: 16b8
ANCHORED=: 16b10
DOLLAR_ENDONLY=: 16b20
EXTRA=: 16b40
NOTBOL=: 16b80
NOTEOL=: 16b100
UNGREEDY=: 16b200
NOTEMPTY=: 16b400
UTF8=: 16b800
NO_AUTO_CAPTURE=: 16b1000
NO_UTF8_CHECK=: 16b2000
AUTO_CALLOUT=: 16b4000
PARTIAL=: 16b8000
DFA_SHORTEST=: 16b10000
DFA_RESTART=: 16b20000
FIRSTLINE=: 16b40000

NB. =========================================================
NB. rxopts v set regex options
NB.
NB.  rxopts ''                set defaults
NB.  rxopts 123               set options by numeric value
NB.  rxopts 'multiline utf8'  set options by character string
rxopts=: 3 : 0
if. 0=#y do.
  r=. MULTILINE + UTF8
elseif. 2=3!:0 y do.
  r=. +/ ". &> ;: toupper y
elseif. do.
  r=. y
end.
RXOPTS_jregex_=: r
)

3 : 0''
if. 0 ~: 4!:0 <'RXOPTS' do. rxopts'' end.
)
