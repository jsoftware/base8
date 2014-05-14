NB. test0

NB. f=. 3 : 0
NB. smoutput '   ',y
NB. smoutput ". y
NB. )
NB.
NB. S=: '123 ABC abc 10 20 30'
NB.
NB. NB. dbstop 'rxmatches'
NB. f '''bc'' rxmatches S'
NB. f '''[[:upper:]]'' rxmatches S'

load 'convert regex'

TEST=: 0 : 0
RX_OPTIONS_UTF8_jregex_

A=: '今日は良い天気です'
B=: 'は良い'
[C=: 8 u: '.' 1 } 7 u: B

B rxmatch A
C rxmatch A

[x=. hfd 3 u: {. 7 u: C
y=. utf8 4 u: dfh x
y rxmatch A

NB. the \x{...} should match
[D=. '\x{',x,'}'
D rxmatch A
)

NB. =========================================================
rxutf8 1
0!:101 TEST

NB. NB. NB. =========================================================
NB. rxutf8 0
NB. 0!:101 TEST
