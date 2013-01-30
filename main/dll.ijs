NB. utilities for calling DLLs

cocurrent 'z'

NB.*cd   v call DLL procedure
cd=: 15!:0

NB.*memr v memory read
NB.*memw v memory write
NB.*mema v memory allocate
NB.*memf v memory free
memr=: 15!:1
memw=: 15!:2
mema=: 15!:3
memf=: 15!:4

NB.*cdf v free DLLs
NB.*cder v error information
NB.*cderx v GetLastError information
cdf=: 15!:5
cder=: 15!:10
cderx=: 15!:11

NB.*gh v allocate header
NB.*fh v free header
NB.*symget v get address of locale entry for name
NB.*symget v set array as address
NB.*symdat v get address of data for name
NB. 15!:6  - get address of locale entry for name
NB. 15!:7  - set array as address
NB. 15!:8  - allocate header
NB. 15!:9  - free header
NB. 15!:12 - mmblks return 3 col integer matrix
NB. 15!:14 - get address of data for name
NB. 15!:16 - toggle native front end (nfe) state
NB. 15!:17 - return x callback arguments
NB. 15!:18 - return last jsto output

gh=. 15!:8
fh=. 15!:9
symget=: 15!:6
symset=: 15!:7
symdat=: 15!:14

NB.*cdcb v callback address
cdcb=: 15!:13

NB. =========================================================
JB01=: 1
JCHAR=: 2
JSTR=: _1,JCHAR
JINT=: 4
JPTR=: JINT
JFL=: 8
JCMPX=: 16
JBOXED=: 32
JTYPES=: JB01,JCHAR,JINT,JPTR,JFL,JCMPX,JBOXED
JSIZES=: >IF64{1 1 4 4 8 16 4;1 1 8 8 8 16 8

NB. =========================================================
NB.*ic   v integer conversion
NB. conversions
NB. e.g.
NB.    25185 25699  =  _1 ic 'abcd'
NB.    'abcd'  =  1 ic _1 ic 'abcd'
NB.    1684234849 1751606885  = _2 ic 'abcdefgh'
NB.    'abcdefgh'  =  2 ic _2 ic 'abcdefgh'
ic=: 3!:4

NB.*fc   v float conversion
fc=: 3!:5

NB. *endian   v flip intel bytes (little endian)
endian=: |.^:('a'={.2 ic a.i.'a')

NB. *Endian   v flip powerpc bytes (BIG Endian)
Endian=: |.^:('a'~:{.2 ic a.i.'a')

NB.*bitwise a bitwise operations
NB. (monadic and dyadic)
NB. e.g.  7  =  1 OR 2 OR 4
NB.          =  OR 1 2 4
NB.*AND  v bitwise AND (&)
NB.*OR   v bitwise OR  (|)
NB.*XOR  v bitwise XOR (^)
AND=: $:/ : (17 b.)
OR=: $:/ : (23 b.)
XOR=: $:/ : (22 b.)
