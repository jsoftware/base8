NB. do string search
NB. =========================================================
NB. return 0-base line number or 0$0 if nothing done
tagss=: 4 : 0
what=. >y [ f=. boxopen x
ind=. 0$0
if. 0=#what do. ind return. end.
if. '0123456789' e. ~{.what do. <: 0". what return. end.  NB. line number

NB. flag to enable UTF-8 support
rxflag=. RX_OPTIONS_UTF8_jregex_
RX_OPTIONS_UTF8_jregex_=: 1

if. 0=tagss_init what do. ind [ RX_OPTIONS_UTF8_jregex_=: rxflag return. end.

termLF=. , ((0 < #) # LF -. {:)
tagmatches=. {.@{."2 @ rxmatches_jregex_
groupndx=. [: <: I. + e.~

txt=. freads f
if. -. txt -: _1 do.
  ndx=. TAGCOMP tagmatches txt
  if. #ndx do.
    ind=. ~. (0,}:I. txt = LF) groupndx ndx
  end.
end.
rxfree_jregex_ :: 0: TAGCOMP
ind [ RX_OPTIONS_UTF8_jregex_=: rxflag
)

NB. =========================================================
tagss_init=: 3 : 0
NB. no magic except anchors, but \ is \\ in tags file for vi compatibility
anchor1=. '^'={.y [ anchor2=. '$'={:y
y=. ('\/';'/') stringreplace ('\\';'\') stringreplace (anchor1#'^'), '\Q', ((-anchor2)}.anchor1}.y), '\E', (anchor2#'$')
TAGCOMP=: rxcomp_jregex_ :: _1: y
if. TAGCOMP -: _1 do.
  rxfree_jregex_ :: 0: TAGCOMP
  0
else.
  1
end.
)
