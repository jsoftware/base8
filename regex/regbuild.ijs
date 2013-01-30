NB. utilities for building regular expressions
NB.
NB. for a description, see lab: Regular Expressions Builder
NB.
NB. main definitions:
NB.
NB.  droptrail
NB.  mainmask
NB.  singlecomp
NB.  singlepat
NB.  submask
NB.  sub
NB.  surrounds
NB.  trail
NB.
NB. verbs to combine and build regular expressions:
NB.
NB.  any
NB.  anyof
NB.  between
NB.  bkref
NB.  by
NB.  eol
NB.  nb
NB.  not
NB.  of
NB.  optional
NB.  or
NB.  owhite
NB.  plain
NB.  set
NB.  setchars
NB.  sol
NB.  someof
NB.  white

require 'regex'

NB. singlecomp: Enclose the argument in parenthesis if it
NB. is not already a single regular expression component.
NB.    makesingle&.> 'a';'ab';'(ab)';'[ab]';'ab*';'[ab]*'
NB. 'a';'(ab)';'(ab)';'[ab]';'(ab*)';'[ab]*'
NB.
NB. This is accomplished by:
NB.   - Dropping all trailing marks which do not affect
NB.     whether the regex is single:  *  +  ?  {m,n}
NB.   - If the remaining is a single character, it is
NB.     a single component
NB.   - If more than 1 character, it must be enclosed in
NB.     *matching* parens or brackets to be single
NB.     (Note that we must ignore paren or brackets which
NB.     are preceded by a backslash)

NB. singlepat: Enclode the argument in parens if it is a
NB. pattern (ie not pat1|pat2).

NB. droptrail drops all trailing  * + ? and {m,n} components
trail=. 1 : 'x&=@{: *. <:@<:@# enlbs ]'
 q1=. '?' trail
 q2=. '+' trail
 q3=. '*' trail
 q4=. '}'&=@{: * >:@(i.&'{')@|.
 qt=. (q1 >. q2 >. q3 >. q4)@(' '&,)  NB. # of trailing chars to drop
droptrail=. (-@qt }. ])^:_    NB. drop trailing chars repeatedly

NB. surrounds returns 1 if the left arg surrounds the right
enlbs=. -.@(2&|)@(+/)@(*./\)@('\'&=)@|.@{."0 1
eq=. (= *. i.@#@] enlbs ])"0 1
surrounds=. =&{. *. =&{: *. <:@#@] = 0: i.~ +/\@(({.@[ eq ])-({:@[ eq ]))

mainmask=: 0: = +/\@(-/)@(0 _1&(|.!.0"0 1))@('()'&eq) f.
submask=: -.@mainmask f.

issingle=. (onechar +. isset +. issub)@droptrail
  onechar=. 1: = #
  isset=. '[]'&surrounds
  issub=. '()'&surrounds

sub=: '('"_ , ] , ')'"_

singlecomp=: sub^:(-.@issingle) f.
singlepat=: sub^:(+./@('|'&eq)@(#~ mainmask)) f.

NB. Simple verbs to combine and build regular expressions

or=: [ , '|'"_ , ]
set=: '['"_ , ] , ']'"_
not=: '^'&,
someof=: singlecomp , '+'"_
anyof=: singlecomp , '*'"_
optional=: singlecomp , '?'"_
of=: singlecomp@] , '{'"_ , ":@{.@[ , ','"_ , ":@{:@[ , '}'"_
by=: ,&singlepat
bkref=: '\'&,@":
sol=: '^'
eol=: '$'
any=: '.'
plain=: ;@(,~&.> e.&'[](){}$^.*+?|\' #&.> (<'\')"_)
nb=: ] , ({.a.)"_ , 'NB. '"_ , [

up=. 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"_ {~ 'abcdefghijklmnopqrstuvwxyz'&i.

(] ".@, '=:''[:'"_ , ] , ':]'''"_)@>;:'alnum alpha blank cntrl digit graph lower print punct space upper xdigit'
((up@{. , }.) ".@, '=:set '"_ , ])@>;:'alnum alpha blank cntrl digit graph lower print punct space upper xdigit'

white=: someof Blank
owhite=: anyof Blank

between=: ] ;@:(by&.>) #@] {. (<:@#@] # <@[)^:(0&=@L.@[)

NB. setchars=: ] (rxE # ]) a."_
setchars=: ] (rxE # ]) (}.a.)"_
