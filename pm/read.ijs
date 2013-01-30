NB. read

NB. =========================================================
NB. read PM and turn PM off
NB.
NB. defines:
NB.     PMSTATS     - PM statistics
NB.     PMNDX       - encoded indices: name, locale, valence
NB.     PMLINES     - line numbers
NB.     PMSPACE     - space
NB.     PMTIME      - time
NB.     PMNAMES     - boxed list of verb names (no locale)
NB.     PMLOCALES   - boxed list of locales
NB.     PMENCODE    - encode vector for PMTIME
NB.     PMDECODE    - decode vector for PMTIME
NB.
NB. return success flag

read=: 3 : 0

NB. don't re-read:
if. PMREAD do. 1 return. end.

NB. ---------------------------------------------------------
NB. initially, use PMTIME for all data:
if. 0 = +/ 6!:13'' do.
  smoutput 'There are no PM records'
  0 return.
end.

PMTIME=: 6!:11 ''
PMSTATS=: 6!:13 ''
6!:10 ''

NB. ---------------------------------------------------------
NB. nonce - store a copy in PM
PM=: PMTIME

NB. ---------------------------------------------------------
locndx=. (1;0) {:: PMTIME
PMNAMES=: 6 pick PMTIME
PMLOCALES=: locndx }. PMNAMES
PMNAMES=: locndx {. PMNAMES
PMNDX=: > 3 {. PMTIME

NB. ---------------------------------------------------------
NB. drop __obj off name, and total with calls in same locale
ndx=. I. (1: e. '__'&E.) &> PMNAMES

if. #ndx do.
  nms=. (('__'&E. i. 1:) {. ]) each ndx { PMNAMES
  ndx merge nms
end.

NB. ---------------------------------------------------------
NB. merge foo with foo_loc_ if in the same locale
ndx=. I. ('_'"_ = {:) &> PMNAMES

if. #ndx do.
  namx=. 0 { PMNDX
  locx=. 1 { PMNDX
  nms=. }: each ndx { PMNAMES
  ind=. i:&'_' &> nms
  loc=. (>: ind) }.each nms
  loc=. (<'base') (I. 0=# &> loc) } loc
  nms=. ind {.each nms

NB. ensure locales match:
  lcs=. (namx i. ndx) { locx
  assert loc -: (lcs-locndx) { PMLOCALES

  ndx merge nms
end.

NB. ---------------------------------------------------------
NB. redefine name indices (duplicate names should have same index):
ind=. (0 { PMNDX) { PMNAMES i. PMNAMES
PMNDX=: ind 0 } PMNDX

NB. ---------------------------------------------------------
PMLINES=: 3 pick PMTIME
PMSPACE=: 0, +/\ }: 4 pick PMTIME
PMTIME=: 5 pick PMTIME
PMDECODE=: 0,(#PMLOCALES),2
PMENCODE=: (2 * #PMLOCALES),2 1
PMNDX=: +/ PMENCODE * PMNDX - 0,locndx,1

PMREAD=: 1
)

NB. =========================================================
NB. merge
NB. change name index if already present and locales match
NB. updates PMNAMES, PMNDX
merge=: 4 : 0
ndx=. x
nms=. y
namx=. 0 { PMNDX
locx=. 1 { PMNDX
nmx=. PMNAMES i. nms
msk=. nmx < #PMNAMES

if. 1 e. msk do.
  plc=. (namx i. msk#nmx) { locx
  rlc=. (namx i. msk#ndx) { locx
  b=. plc=rlc
  if. 1 e. b do.
    inx=. b # I. msk
    nwx=. ((inx{ndx), namx) i. namx
    new=. nwx { (inx{nmx), namx
    PMNDX=: new 0 } PMNDX
  end.
end.

PMNAMES=: nms ndx} PMNAMES
)
