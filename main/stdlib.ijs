NB. standard library
NB.
NB. these definitions are assumed available to other programs

NB. TAB            tab
NB. LF             linefeed
NB. LF2            linefeed,linefeed
NB. FF             formfeed
NB. CR             carriage return
NB. CRLF           CR LF pair
NB. DEL            ascii 127
NB. EAV            ascii 255
NB. noun           0
NB. adverb         1
NB. conjunction    2
NB. verb           3
NB. monad          3
NB. dyad           4

NB. assert         assert value is true
NB. bind           binds argument to a monadic verb
NB. boxdraw
NB. boxopen        box argument if open
NB. boxxopen       box argument if open and 0<#
NB. clear          clear all names in locale
NB. cutopen        cut argument if open
NB. datatype       noun datatype
NB. def            : (explicit definition)
NB. define         : 0 (explicit definition script form)
NB. dfh            decimal from hex
NB. do             do (".)
NB. drop           drop (}.)
NB. each           each (&.>)
NB. echo
NB. empty          return empty result
NB. erase          erase
NB. every          every (&>)
NB. evtloop        dummy event loop (empty)
NB. exit           exit (2!:55)
NB. expand         boolean expand data
NB. fetch          fetch ({::)
NB. fliprgb        flip between argb and abgr byte order
NB. getargs        getopts in the sh/bash shells
NB. getenv         get environment variable
NB. hfd            hex from decimal
NB. inv, inverse   inverse (^:_1)
NB. isatty         test whether a file descriptor refers to a terminal
NB. items          items ("_1)
NB. leaf           leaf (L:0)
NB. list           list data formatted in columns
NB. names          formatted namelist
NB. nameclass      name class
NB. namelist       name list
NB. nc             name class
NB. nl             selective namelist
NB. Note           note in script
NB. on             on @:
NB. pick           pick (>@{)
NB. rows           rows ("1)
NB. script         load script
NB. scriptd        load script with display
NB. sign           sign (*)
NB. sminfo         info box or output to session
NB. smoutput       output to session
NB. sort           sort up
NB. split          split head from tail
NB. stdout
NB. stderr
NB. stdin
NB. table          function table
NB. take           take ({.)
NB. timex          time expressions
NB. timespacex     time and space for expressions
NB. toCRLF         converts character strings to CRLF delimiter
NB. toJ            converts character strings to J delimiter (linefeed)
NB. toHOST         converts character strings to Host delimiter
NB. tolower        convert text to lower case
NB. toupper        convert text to upper case
NB. type           object type
NB. ucp            return code point chars
NB. ucpcount       code point count
NB. usleep         sleep for n microseconds
NB. utf8           return utf8 chars

NB. =========================================================
NB.*TAB n tab character
NB.*LF n linefeed character
NB.*LF2 n LF,LF pair
NB.*FF n formfeed character
NB.*CR n carriage return character
NB.*CRLF n CR,LF pair
NB.*DEL n ascii 127 character
NB.*noun n integer 0
NB.*adverb n integer 1
NB.*conjunction n integer 2
NB.*verb n integer 3
NB.*monad n integer 3
NB.*dyad n integer 4

18!:4 <'z'

NB. =========================================================
'TAB LF FF CR DEL EAV'=: 9 10 12 13 127 255{a.
LF2=: LF,LF
CRLF=: CR,LF
EMPTY=: i.0 0
Debug=: 0
'noun adverb conjunction verb monad dyad'=: 0 1 2 3 3 4

NB. =========================================================
NB.*apply v apply verb x to y
apply=: 128!:2

NB. =========================================================
NB.*def c : (explicit definition)
def=: :

NB.*define a : 0 (explicit definition script form)
define=: : 0

NB.*do v name for ".
do=: ".

NB.*drop v name for }.
drop=: }.

NB.*each a each (&.>)
each=: &.>

NB.*echo
echo=: 0 0&$ @ (1!:2&2)

NB.*exit v 2!:55
exit=: 2!:55

NB.*every a every (&>)
every=: &>

NB.*evtloop
evtloop=: EMPTY"_

NB. *fliprgb v flip between argb and abgr byte order
fliprgb=: 3 : 0
s=. $y
d=. ((#y),4)$2 (3!:4) y=. <.,y
d=. 2 1 0 3{"1 d
s$_2(3!:4),d
)

NB. * getargs v was written by Joey K Tuttle
getargs=: 3 : 0
ARGV getargs y
:
argb=. (]`(([: < 1: {. }.) , [: < 2: }. ])@.('-'"_ = {.))&.> x
NB. The above boxes parms (elements starting with "-" returning name;value
parm=. 32 = ;(3!:0)&.> argb
((-. parm)#argb);(>parm#argb);(". (0 = isatty 0)#'stdin ''''')
)

NB.
getenv=: 2!:5

NB.*inv a inverse (^:_1)
NB.*inverse a inverse (^:_1)
inv=: inverse=: ^:_1

NB.*isatty v test whether a file descriptor refers to a terminal
3 : 0''
if. IFUNIX do.
  isatty=: ((unxlib 'c'),' isatty > i i') & (15!:0)
else.
NB. FILE_TYPE_CHAR=: 2 [ STD_INPUT_HANDLE=: _10 [ STD_OUTPUT_HANDLE=: _11 [ STD_ERROR_HANDLE=: _12
  isatty=: 2: = ('kernel32 GetFileType > i x' & (15!:0)) @ ('kernel32 GetStdHandle > x i'& (15!:0)) @ - @ (10&+)
end.
''
)

NB.*items a ("_1)
items=: "_1

NB.*fetch v name for {::
fetch=: {::

NB.*leaf a leaf (L:0)
leaf=: L:0

NB.*nameclass v name for 4!:0
NB.*nc v name for 4!:0
nameclass=: nc=: 4!:0

NB.*namelist v name for 4!:1
namelist=: 4!:1

NB.*on c name for @:
on=: @:

NB.*pick v pick (>@{)
pick=: >@{

NB.*rows a rows ("1)
rows=: "1

NB.
stdout=: 1!:2&4
stderr=: 1!:2&5
stdin=: 1!:1@3: :. stdout

NB.*sign a sign (*)
sign=: *

NB.*sort v sort up
sort=: /:~ : /:

NB.*take v name for {.
take=: {.

NB. =========================================================
NB.*assert v assert value is true
NB. assertion failure if  0 e. y
NB. e.g. 'invalid age' assert 0 <: age
assert=: 0 0 $ 13!:8^:((0 e. ])`(12"_))

NB. =========================================================
NB.*bind c binds argument to a monadic verb
NB. binds monadic verb to an argument creating a new verb
NB. that ignores its argument.
NB. e.g.  fini=: mbinfo bind 'finished...'
bind=: 2 : 'x@(y"_)'

NB. =========================================================
NB.*boxopen v box argument if open
NB. boxxopen    - box argument if open and # is not zero
NB. e.g. if script=: 0!:0 @ boxopen, then either
NB.   script 'work.ijs'  or  script <'work.ijs'
NB. use cutopen to allow multiple arguments.
boxopen=: <^:(L.=0:)

NB.*boxxopen v box argument if open and 0<#
boxxopen=: <^:(L.<*@#)

NB. NB. =========================================================
NB. NB.*bx v indices of 1's in boolean
NB. bx=: I. NB. added j503, definition retained for compatibility

NB. =========================================================
NB.*clear v clear all names in locale
NB.         returns any names not erased
NB. example: clear 'myloc'
clear=: 3 : 0
". 'do_',(' '-.~y),'_ '' (#~ -.@(4!:55)) (4!:1) 0 1 2 3'''
)

NB. =========================================================
NB.*cut text on LF, removing empties
cutLF=: 3 : 'if. L. y do. y else. a: -.~ <;._2 y,LF end.'

NB. =========================================================
NB.*cutopen v cut argument if open
NB. this allows an open argument to be given where a boxed list is required.
NB. most common situations are handled. it is similar to boxopen, except
NB. allowing multiple arguments in the character string.
NB.
NB. x is optional delimiters, default LF if in y, else blank
NB. y is boxed or an open character array.
NB.
NB. if y is boxed it is returned unchanged, otherwise:
NB. if y has rank 2 or more, the boxed major cells are returned
NB. if y has rank 0 or 1, it is cut on delimiters in given in x, or
NB.   if x not given, LF if in y else blank. Empty items are deleted.
NB.
NB.  e.g. if script=: 0!:0 @ cutopen, then
NB.   script 'work.ijs util.ijs'
NB.
cutopen=: 3 : 0
y cutopen~ (' ',LF) {~ LF e. ,y
:
if. L. y do. y return. end.
if. 1 < #$y do. <"_1 y return. end.
(<'') -.~ (y e.x) <;._2 y=. y,1{.x
)

NB. =========================================================
NB.*datatype v noun datatype
datatype=: 3 : 0
n=. 1 2 4 8 16 32 64 128 1024 2048 4096 8192 16384 32768 65536 131072
t=. '/boolean/literal/integer/floating/complex/boxed/extended/rational'
t=. t,'/sparse boolean/sparse literal/sparse integer/sparse floating'
t=. t,'/sparse complex/sparse boxed/symbol/unicode'
(n i. 3!:0 y) pick <;._1 t
)

NB. =========================================================
NB.*empty v return empty result (i.0 0)
empty=: EMPTY"_

NB. =========================================================
NB.*erase v erase namelist
erase=: [: 4!:55 ;: ::]

NB. =========================================================
NB.*expand v boolean expand
NB. form: boolean expand data
expand=: # inverse

NB. =========================================================
NB.*dfh v decimal from hex
NB.*hfd v hex from decimal
H=. '0123456789ABCDEF'
h=. '0123456789abcdef'
dfh=: 16 #. 16 | (H,h) i. ]
hfd=: h {~ 16 #.^:_1 ]
4!:55 'H';'h'

NB. if character string is valid utf8
isutf8=: 1:@(7&u:) :: 0:

NB. =========================================================
NB.*list v list data formatted in columns
NB. syntax:   {width} list data
NB. accepts data as one of:
NB.   boxed list
NB.   character vector, delimited by CR, LF or CRLF; or by ' '
NB.   character matrix
NB. formats in given width, default screenwidth
list=: 3 : 0
w=. {.wcsize''
w list y
:
if. 0=#y do. i.0 0 return. end.
if. 2>#$y=. >y do.
  d=. (' ',LF) {~ LF e. y=. toJ ": y
  y=. [;._2 y, d #~ d ~: {: y
end.
y=. y-. ' '{.~ c=. {:$ y=. (": y),.' '
(- 1>. <. x % c) ;\ <"1 y
)

NB. =========================================================
NB.*nl v selective namelist
NB. Form:  [mp] nl sel
NB.
NB.   sel:  one or more integer name classes, or a name list.
NB.         if empty use: 0 1 2 3.
NB.   mp:   optional matching pattern. If mp contains '*', list names
NB.         containing mp, otherwise list names starting mp. If mp
NB.         contains '~', list names that do not match.
NB.
NB.  e.g. 'f' nl 3      - list verbs that begin with 'f'
NB.       '*com nl ''   - list names containing 'com'
nl=: 3 : 0
'' nl y
:
if. 0 e. #y do. y=. 0 1 2 3 end.

if. 1 4 8 e.~ 3!:0 y do.
  nms=. (4!:1 y) -. ;: 'x y x. y.'
else.
  nms=. cutopen_z_ y
end.

if. 0 e. #nms do. return. end.

if. #t=. x -. ' ' do.
  'n s'=. '~*' e. t
  t=. t -. '~*'
  b=. t&E. &> nms
  if. s do. b=. +./"1 b
  else. b=. {."1 b end.
  nms=. nms #~ n ~: b
end.
)

NB. =========================================================
NB.*names v formatted namelist
names=: list_z_ @ nl

NB. =========================================================
NB.*Note v notes in script
NB.
NB. Monadic form:
NB.   This enables multi line comments without repeated NB. and
NB.   requires a right parenthesis in the first column of a line to
NB.   close. The right argument may be empty, numeric, text, or any
NB.   noun. Reads and displays the comment text but always returns an
NB.   empty character string so the comment is not duplicated on screen.
NB.
NB. The right argument can number or describe the notes, e.g.
NB.   Note 1     Note 2.2   or    Note 'The special case' etc.
NB.
NB. Dyadic form
NB.   This permits a single consist form of comment for any lines which are
NB.   not tacit definitions. The left argument must be a noun. The function
NB.   code displays the right argument and returns the left argument.
NB.
NB. examples:
NB.
NB. Note 1
NB. ... note text
NB. )
NB.
NB. (2 + 3)=(3 + 2) Note 'addition is commutative'
Note=: 3 : '0 0 $ 0 : 0' : [

NB. =========================================================
NB.*script v load script, cover for 0!:0
NB.*scriptd v load script with display, cover for 0!:1
script=: [: 3 : '0!:0 y [ 4!:55<''y''' jpath_z_ &.: >
scriptd=: [: 3 : '0!:1 y [ 4!:55<''y''' jpath_z_ &.: >

NB. =========================================================
NB.*sminfo v info box or output to session
sminfo=: 3 : 0
if. IFQT do. wdinfo_jqtide_ y
elseif. ('Android'-:UNAME) *. 3=4!:0<'mbinfo_ja_' do. mbinfo_ja_ y
elseif. do. smoutput >_1{.boxopen y end.
)

NB. =========================================================
NB.*smoutput v output to session
NB.*tmoutput v output to stdout
smoutput=: 0 0 $ 1!:2&2
tmoutput=: 0 0 $ 1!:2&4

NB. =========================================================
NB.*split v split head from tail
NB. examples:
NB.    split 'abcde'
NB.    2 split 'abcde'
split=: {. ,&< }.

NB. =========================================================
NB.*table a function table
NB. table   - function table  (adverb)
NB. e.g.   1 2 3 * table 10 11 12 13
NB.        +. table i.13
table=: 1 : 0~
:
(((#~LF-.@e.])5!:5<'u');,.y),.({.;}.)":x,y u/x
)

NB. =========================================================
NB.*timex v time expressions
NB. Form: [repetitions] timex 'expression'
timex=: 6!:2

NB.*timespacex v time and space for expressions
NB. Form: [repetitions] timex 'expression'
NB. Example:
NB.    10 timespacex &> 'q:123456787';'3^10000x'
NB. 0.005 58432
NB. 0.061 52352
timespacex=: 6!:2 , 7!:2@]

NB. =========================================================
NB.*tolower v convert text to lower case
NB.*toupper v convert text to upper case
NB.
NB. earlier defs can fail on unicode data:
NB. 'l u'=. (a.i.'aA') +each <i.26
NB. tolower=: a.&i. { ((l{a.) u} a.)"_
NB. toupper=: a.&i. { ((u{a.) l} a.)"_

tolower=: 3 : 0
x=. I. 26 > n=. ((65+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (97+i.26){a.) x}t
)

toupper=: 3 : 0
x=. I. 26 > n=. ((97+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (65+i.26){a.) x}t
)

NB. =========================================================
NB.*type v object type
t=. <;._1 '/invalid name/not defined/noun/adverb/conjunction/verb/unknown'
type=: {&t@(2&+)@(4!:0)&boxopen

NB. =========================================================
NB.*ucp v convert text to unicode code point
NB. This is 7-bit ascii (if possible) or utf16 (compare uucp)
NB. inverse is utf8
ucp=: 7&u:

NB. =========================================================
NB.*ucpcount v unicode code point count
NB. counts number of unicode code points (glyphs) in a string.
NB. A unicode character has one code point, even though it
NB. may have several bytes in its representation.
ucpcount=: # @ (7&u:)

NB. =========================================================
NB. *usleep v sleep for n microseconds
NB. linux max value around 33 minutes
NB. windows minimum resolution in milliseconds.
3 : 0''
if. IFUNIX do.
  usleep=: 3 : ('''',(unxlib 'c'),' usleep > i i''&(15!:0) >.y')
else.
  usleep=: 3 : '0: ''kernel32 Sleep > n i''&(15!:0) >.y % 1000'
end.
EMPTY
)

NB. =========================================================
NB.*utf8 v convert string to utf8
NB. inverse of ucp
utf8=: 8&u:

NB. =========================================================
NB.*uucp v convert text to unicode code point
NB. This is always utf16 (compare ucp)
uucp=: u:@(7&u:)

NB. =========================================================
NB.*toCRLF v converts character strings to CRLF delimiter
NB.*toHOST v converts character strings to Host delimiter
NB.*toJ v converts character strings to J delimiter (linefeed)

NB. =========================================================
NB. platform-dependent definitions:
3 : 0''
h=. 9!:12''
subs=. 2 : 'x I. @(e.&y)@]} ]'
toJ=: (LF subs CR) @: (#~ -.@(CRLF&E.@,))
toCRLF=: 2&}. @: ; @: (((CR&,)&.>)@<;.1@(LF&,)@toJ)
if. h=5 do.
  toHOST=: ]
else.
  toHOST=: toCRLF
end.
1
)
