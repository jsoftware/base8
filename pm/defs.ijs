NB. defs

coclass 'jpm'

SIZE=: 1e7                NB. default size
SCREENGLOBALS=: 0         NB. if screen globals have been defined

NB. =========================================================
unpack=: 6!:11            NB. unpack PM data
counter=: 6!:12           NB. increment/decrement counter
stats=: 6!:13             NB. PM stats

NB. =========================================================
NB. start - switch PM on
NB. x = left argument to 6!:10, (default 1=all lines, 0=wrap)
NB. y = data area, or size of data area (if '' use SIZE)
start=: 3 : 0
'' start y
:
reset''
x=. 2 {. x, (#x) }. 1 0
if. (0 < #y) *: 2 = 3!:0 y do.
  y=. ({. y, SIZE) $ ' '
end.
([ [: (6!:12) 1:) x 6!:10 y
)

NB. =========================================================
stop=: 6!:10 bind ($0)     NB. switch PM off

NB. =========================================================
reset=: 3 : 0
4!:55 <'PMTESTDATA'
PM=: $0
PMREAD=: 0
PMENCODE=: PMDECODE=: PMSTATS=: $0
PMNDX=: PMLINES=: PMSPACE=: PMTIME=: $0
PMNAMES=: PMLOCALES=: ''
)

reset''
