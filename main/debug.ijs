NB. debug definitions and utilities

NB. e.g.  dbss 'f 0'   monadic line 0
NB.       dbss 'f :2'  dyadic line 2
NB.       dbss 'f *:*' all lines
NB.
NB. The call stack (dbstk'') is a 9-column boxed matrix:
NB.   0  name
NB.   1  error number, or 0 if this call has no error.
NB.   2  line number
NB.   3  name class
NB.   4  definition
NB.   5  source script
NB.   6  argument list
NB.   7  locals
NB.   8  suspense

cocurrent 'z'

NB.*dbr v reset, set suspension mode (0=disable, 1=enable)
NB.*dbs v display stack
NB.*dbsq v stop query
NB.*dbss v stop set
NB.*dbrun v run again (from current stop)
NB.*dbnxt v run next (skip line and run)
NB.*dbret v exit and return argument
NB.*dbjmp v jump to line number
NB.*dbsig v signal error
NB.*dbrr v re-run with specified arguments
NB.*dbrrx v re-run with specified executed arguments
NB.*dberr v last error number
NB.*dberm v last error message
NB.*dbstk v call stack
NB.*dblxq v latent expression query
NB.*dblxs v latent expression set
NB.*dbtrace v trace control
NB.*dbq v queries suspension mode (set by dbr)
NB.*dbst v returns stack text

dbr=: 13!:0
dbs=: 13!:1
dbsq=: 13!:2
dbss=: 13!:3
dbrun=: 13!:4
dbnxt=: 13!:5
dbret=: 13!:6
dbjmp=: 13!:7
dbsig=: 13!:8
dbrr=: 13!:9
dbrrx=: 13!:10
dberr=: 13!:11
dberm=: 13!:12
dbstk=: 13!:13
dblxq=: 13!:14
dblxs=: 13!:15
dbtrace=: 13!:16
dbq=: 13!:17
dbst=: 13!:18

NB. =========================================================
NB. utilities:
NB. dbctx       display context
NB. dbg         turn debug window on/off
NB. dblocals    display local names on stack
NB. dbstack     display stack
NB. dbstop      add stop definitions
NB. dbstops     set all stop definitions
NB. dbstopme    stop current definition
NB. dbstopnext  stop current definition at next line
NB. dbview      view stack

NB. =========================================================
NB. *dbctx v display context as character matrix
NB.
NB. y is ignored
NB. x is the number of lines before and after the current stop
NB.      default to 3 3
dbctx=: 3 3&$: : (4 : 0)
if. -.13!:17'' do. 0 0$'' return. end.
NB. avoid possible argument error
try.
  'before after'=. 2{. <. , x, 3 3
catch.
  'before after'=. 3 3
end.
if. 0= #d=. 13!:13'' do. 0 0$'' return. end.
if. '*' -.@e. sus=. >{:"1 d do. 0 0$'' return. end.
'name ln nc def src'=. 0 2 3 4 5{(sus i. '*'){d
dyad=. {: ':'&e.;._2 ] 13!:12''
if. (_2{.def) -: LF,')' do.
  def=. }.def [ def0=. {.def=. }:<;._2 def,LF
else.
  def=. ,<def [ def0=: ''
end.
if. def e.~ <,':' do.
  if. dyad do.
    def=. def}.~ >: def i. <,':'
  else.
    def=. def{.~ def i. <,':'
  end.
end.
min=. 0>.ln-before [ max=. (<:#def)<.ln+after
ctx=. ((,.ln=range){' >'),"1 '[',"1 (":,.range) ,"1 ('] ') ,"1 >def{~range=. min + i. >:max-min
> (<'@@ ', name, '[', (dyad#':'), (":ln) ,'] *', (nc{' acv'),' @@ ', src), def0, <"1 ctx
)

NB. NB. =========================================================
NB. NB.*dbg v turn debugging window on/off
NB. dbg=: 3 : 0
NB. if. y do.
NB.   if. _1 = 4!:0 <'jdb_open_jdebug_' do.
NB.     0!:0 <jpath '~system/util/debugs.ijs'
NB.   end.
NB.   jdb_open_jdebug_''
NB.   smfocusact_jijs_''
NB.   13!:0 [ 1
NB. else.
NB.   jdb_close_jdebug_ :: ] ''
NB.   13!:15 ''
NB.   13!:0 [ 0
NB. end.
NB. )

dbg=: 13!:0

NB. =========================================================
NB.*dblocals v display names and locals on stack
NB. form: [namelist] dblocals stack indices (default all)
NB. example:
NB.          dblocals ''     display all local names in stack
NB.  'abc Z' dblocals i.5    display names abc and Z where found
NB.                          in first 5 definitions on stack
dblocals=: _1&$: : (4 : 0)
stk=. }. 13!:13''
if. 0=#y do. y=. a: else. y=. (y e. i.#stk) # y end.
loc=. (<y ; 0 7) { stk
if. -. x-:_1 do.
  t=. ;: ::] x
  f=. ({."1 e. t"_) # ]
  ({."1 loc) ,. f &.> {:"1 loc
end.
)

NB. =========================================================
NB.*dbstack v displays call stack with header
NB. ignores definition and source script (default)
NB. y is the number of lines to display, all if empty
NB. or a name on the stack
NB. limits display to screenwidth
dbstack=: 3 : 0
hdr=. ;:'name en ln nc args locals susp'
stk=. }. 13!:13''
if. #y do.
  if. 2=3!:0 y do.
    stk=. stk #~ (<y)={."1 stk
  else.
    stk=. ((#stk)<.,y){.stk
  end.
end.
stk=. 1 1 1 1 0 0 1 1 1 #"1 stk
stk=. hdr, ": &.> stk
wds=. ({:@$@":@,.)"1 |: stk
len=. 20 >.<.-:({.wcsize'') - +/8, 4 {. wds
tc=. (len+1)&<.@$ {.!.'.' ({.~ len&<.@$)
tc@": each stk
)

NB. =========================================================
NB.*dbstop v set stops on all lines in namelist
NB.
NB. Adds to current set of stops
dbstop=: 3 : 0
if. 0 e. #y -. ' ' do. 13!:3'' return. end.
t=. 13!:2''
if. #t do. t=. <;._2 t, ';' -. {:t end.
t=. ~. t, (;: ^: (L.=0:) y) ,&.> <' *:*'
13!:3 ; t ,&.> ';'
)

NB. =========================================================
NB.*dbstops v set stops on all lines in namelist
NB.
NB. Replaces current set of stops
dbstops=: 3 : 0
13!:3 ; (;: ^: (L.=0:) y) ,&.> <' *:*;'
)

NB. =========================================================
NB.*dbstopme v set stops on current definition if y
NB. does nothing if suspension is off
dbstopme=: 3 : 0
if. y do.
  if. 0 e. $c=. }. 13!:13'' do. return. end.
  c=. (> {. {. c), ' *:*'
  t=. 13!:2''
  if. #t do. t=. <;._2 t, ';' -. {:t end.
  t=. ~. t, <c
  13!:3 }: ; t ,&.> ';'
end.
)

NB. =========================================================
NB.*dbstopnext v set stop on next line of current definition if y
NB. does nothing if suspension is off
dbstopnext=: 3 : 0
if. y do.
  if. 0 e. $c=. }. 13!:13'' do. return. end.
  'd n a'=. 0 2 6 { {. c
  c=. d,' ',(':'#~2=#a),":n+1
  t=. 13!:2''
  if. #t do. t=. <;._2 t, ';' -. {:t end.
  t=. ~. t, <c
  13!:3 }: ; t ,&.> ';'
end.
)

NB. =========================================================
NB.*dbview v view stack
dbview=: 3 : 0
if. _1 = 4!:0 <'jdbview_jdbview_' do.
  'require'~'~addons/ide/qt/dbview.ijs'
end.
jdbview_jdbview_ }. 13!:13''
)

NB. =========================================================
NB.*dbhelp n display help message
dbhelp=: 0 : 0
The call stack (dbstk'') is a 9-column boxed matrix:
  0  name
  1  error number, or 0 if this call has no error.
  2  line number
  3  name class
  4  definition
  5  source script
  6  argument list
  7  locals
  8  suspense

f is the name of a verb
      dbss 'f 0'   monadic line 0
      dbss 'f :2'  dyadic line 2
      dbss 'f *:*' all lines

dbr     reset, set suspension mode (0=disable, 1=enable)
dbs     display stack
dbsq    stop query
dbss    stop set
dbrun   run again (from current stop)
dbnxt   run next (skip line and run)
dbret   exit and return argument
dbjmp   jump to line number
dbsig   signal error
dbrr    re-run with specified arguments
dbrrx   re-run with specified executed arguments
dberr   last error number
dberm   last error message
dbstk   call stack
dblxq   latent expression query
dblxs   latent expression set
dbtrace trace control
dbq     queries suspension mode (set by dbr)
dbst    returns stack text

dbctx       display context
dbg         turn debug window on/off
dblocals    display local names on stack
dbstack     display stack
dbstop      add stop definitions
dbstops     set all stop definitions
dbstopme    stop current definition
dbstopnext  stop current definition at next line
dbview      view stack
)
