NB. main

NB. =========================================================
compare=: 4 : 0
if. x -: y do. 'no difference' return. end.
if. 0=#x do. 'empty left argument' return. end.
if. 0=#y do. 'empty right argument' return. end.
a=. conew 'jcompare'
r=. x comp__a y
coerase a
r
)

NB. =========================================================
fcompare=: 3 : 0
('';0) fcomp y
:
(x;0) fcomp y
)

NB. =========================================================
fcompares=: 3 : 0
('';1) fcomp y
:
(x;1) fcomp y
)

