NB. regex

NB. =========================================================
NB. Global definitions used by the regex script functions
rxmp=: 50 NB. Allocation granule size for compiled patterns.
rxms=: 50 NB. Maximum number of sub-expressions per pattern.
rxszi=: IF64{4 8
rxregxsz=: 3 NB. J ints for pcre regex_t
re_nsub_off=: 1
rxlastrc=: 0
rxlastxrp=: rxregxsz$2-2
NB. rxpatterns defined only if not already defined
rxpatterns_jregex_=: (3 0 $ _1 ; rxlastxrp ; '') [^:(0:=#@]) ". 'rxpatterns_jregex_'

NB. =========================================================
NB. rxmatch
rxmatch=: 4 : 0
if. lb=. 32 = 3!:0 x do. ph=. >0{x else. ph=. x end.
if. cx=. 2 = 3!:0 ph do. hx=. rxcomp ph
else. rxlastxrp=: > 1{((hx=. ph) - 1) ({"1) rxpatterns end.
nsub=. rxnsub rxlastxrp
rxlastrc=: >0{rv=. jregexec rxlastxrp ; (,y) ; rxms ; ((2*rxms)$_1 0) ; 0
if. cx do. rxfree hx end.
m=. (nsub,2)$>4{rv
t=. (0{"1 m)
m=. t,.-~/"1 m
m=. _1 0 ((t=_1)#i.#t)} m
if. lb do. (>1{x){ m else. m end.
)

NB. =========================================================
NB. rxmatches
rxmatches=: 4 : 0
if. lb=. 32 = 3!:0 x do.
  ph=. >0{x else. ph=. x end.
if. cx=. 2 = 3!:0 ph do.
  hx=. rxcomp ph else.	NB. rxcomp sets rxlastxrp
  rxlastxrp=: > 1{((hx=. ph) - 1) ({"1) rxpatterns end.
nsub=. rxnsub rxlastxrp
o=. 0
rxm=. (0, nsub, 2)$0
while. 1 do.
  m=. hx rxmatch o}.y
  if. 0 e. $m do. break. end.
  if. _1 = 0{0{m do. break. end.
  m=. m+ ($m)$o,0
  rxm=. rxm , m
NB. Advance the offset o beyond this match.
NB. The match length can be zero (with the *? operators),
NB. so take special care to advance at least to the next
NB. position.  If that reaches beyond the end, exit the loop.
  o=. (>:o) >. +/0{m
  if. o >: #y do. break. end.
end.
if. cx do. rxfree hx end.
if. lb do. (>1{x){"2 rxm else. rxm end.
)

NB. =========================================================
NB. rxcomp
NB.
NB. options rxcomp pattern
rxcomp=: 3 : 0
'rxlastrc rxlastxrp'=: 2 {. jregcomp (rxregxsz$2-2); (,y); 2 + RX_OPTIONS_UTF8*16b40
if. rxlastrc do. (rxerror'') 13!:8 [12 end.
if. ({:$rxpatterns) = hx=. (<_1) i.~ 0 { rxpatterns do.
  rxpatterns=: rxpatterns ,. (rxmp$<_1),(rxmp$<rxregxsz$2-2), ,:rxmp$<''
end.
rxpatterns=: ((hx+1);rxlastxrp;y) (<a:;hx)} rxpatterns
hx + 1
)

NB. =========================================================
rxnsub=: [: >: 1&{   NB. Number of main+sub-expressions from Perl regex_t

NB. =========================================================
NB. rxerror
rxerror=: 3 : 0
r=. >3{jregerror rxlastrc;rxlastxrp;(80#' ');80
({.~ i.&(0{a.)) r
)

NB. =========================================================
rxfree=: 3 : 0
hx=. ,y - 1
while. 0<#hx do.
  ix=. 0{hx
  jregfree 1{ix ({"_1) rxpatterns
  rxpatterns=: ((<_1),(<rxregxsz$2-2),<'') (<(<$0);ix)} rxpatterns
  hx=. }.hx
end.
i.0 0
)

NB. =========================================================
NB. rxhandles
rxhandles=: 3 : 0
h=. >0{rxpatterns
(h~:_1)#h
)

NB. =========================================================
NB. rxinfo
rxinfo=: 3 : 0
i=. (y-1){"1 rxpatterns
|:(<"_1 rxnsub >1{i) ,: 2{i
)

NB. =========================================================
NB. rxfrom=: <@({~ (+ i.)/)"1~
rxfrom=: ,."1@[ <;.0 ]
rxeq=: {.@rxmatch -: 0: , #@]
rxin=: _1: ~: {.@{.@rxmatch
rxindex=: #@] [^:(<&0@]) {.@{.@rxmatch
rxE=: i.@#@] e. {.@{."2 @ rxmatches
rxfirst=: {.@rxmatch >@rxfrom ]
rxall=: {."2@rxmatches rxfrom ]

NB. =========================================================
rxapply=: 1 : 0
:
if. L. x do. 'pat ndx'=. x else. pat=. x [ ndx=. ,0 end.
if. 1 ~: #$ ndx do. 13!:8[3 end.
mat=. ({.ndx) {"2 pat rxmatches y
r=. u&.> mat rxfrom y
r mat rxmerge y
)

NB. =========================================================
rxcut=: 4 : 0
if. 0 e. #x do. <y return. end.
'beg len'=. |: ,. x
if. 1<#beg do.
  whilst. 0 e. d do.
    d=. 1,<:/\ (}:len) <: 2 -~/\ beg
    beg=. d#beg
    len=. d#len
  end.
end.
a=. 0, , beg ,. beg+len
b=. 2 -~/\ a, #y
f=. < @ (({. + i.@{:)@[ { ] )
(}: , {: -. a:"_) (a,.b) f"1 y
)

NB. =========================================================
rxmerge=: 1 : 0
:
p=. _2 ]\ m rxcut y
;, ({."1 p),.(#p){.(#m)$x
)

NB. =========================================================
rxrplc=: 4 : 0
pat=. >{.x
new=. {:x
if. L. pat do. 'pat ndx'=. pat else. ndx=. ,0 end.
if. 1 ~: #$ ndx do. 13!:8[3 end.
mat=. ({.ndx) {"2 pat rxmatches y
new mat rxmerge y
)

NB. =========================================================
NB. set UTF-8 support on/off
NB. result is previous setting
rxutf8=: 3 : 0
(RX_OPTIONS_UTF8=: y) ] RX_OPTIONS_UTF8
)
