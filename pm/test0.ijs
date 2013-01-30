
cocurrent 'base'
require 'format'

NB. NB. === 0
NB. foo=: 3 : 0
NB. 0 1 start_jpm_ 100$' '
NB. f=: 3 : ' +: y.'
NB. f 3
NB. showtotal_jpm_ ''
NB. )
NB.
NB. NB. === 1
NB. goo=: 3 : 0
NB. y1=: 100$' '
NB. NB. 0 1 crashes too
NB. (1 1) 6!:10 y1
NB. 6!:12 ]1
NB. f=: 3 : '+: y'
NB. f 3
NB. f 3
NB. 6!:11''
NB. )

dbg 1
NB. start_jpm_ ''
foo ''
NB. smoutput 0 0 100 showtotal_jpm_ ''
NB. smoutput ''
NB. smoutput showdetail_jpm_ 'foo'

