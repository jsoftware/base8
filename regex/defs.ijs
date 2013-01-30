NB. defs

NB. =========================================================
NB. rxdll is in bin or tools/regex
3 : 0''
select. UNAME
case. 'Win' do. t=. 'jpcre.dll'
case. 'Darwin' do. t=. 'libjpcre.dylib'
case. do. t=. 'libjpcre.so'
end.
f=. BINPATH,'/',t
if. 0 = 1!:4 :: 0: <f do.
  f=. jpath '~tools/regex/',t
end.

NB. fall back one more time for android
if. 0 = 1!:4 :: 0: <f do.
 f=. (BINPATH i: '/'){. BINPATH
 f=. (f i: '/'){. f
 f=. f,'/lib/', t
end.

rxdll=: '"',f,'" '
)

rxcdm=: 1 : '(rxdll,x)&(15!:0)'

NB. =========================================================
NB. J DLL calls corresponding to the four extended regular expression
NB. functions defined in The Single Unix Specification, Version 2
jregcomp=: 'regcomp + i *x *c i' rxcdm
jregexec=: 'regexec + i *x *c x *i i' rxcdm
jregerror=: 'regerror + x i * *c x' rxcdm
jregfree=: 'regfree + n *x' rxcdm

