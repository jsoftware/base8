NB. defs

NB. =========================================================
NB. rxdll is in bin or tools/regex
3 : 0''
select. UNAME
case. 'Win' do. t=. 'jpcre.dll'
case. 'Darwin' do. t=. 'libjpcre.dylib'
fcase. 'Linux' do.
  if. 2 0-:('libpcreposix.so.3 dummyfunction n')&(15!:0) ::(15!:10) '' do.
    rxdll=: 'libpcreposix.so.3'
    jregcomp=: ('"',rxdll,'" pcreposix_regcomp + i *x *c i')&(15!:0)
    jregexec=: ('"',rxdll,'" pcreposix_regexec + i *x *c x *i i')&(15!:0)
    jregerror=: ('"',rxdll,'" pcreposix_regerror + x i * *c x')&(15!:0)
    jregfree=: ('"',rxdll,'" pcreposix_regfree + n *x')&(15!:0)
    '' return.
  end.
case. do. t=. 'libjpcre.so'
end.

f=. BINPATH,'/',t
if. 0 = 1!:4 :: 0: <f do.
  f=. jpath '~tools/regex/',t
end.

NB. fall back one more time
if. ('Android'-:UNAME) *. 0 = 1!:4 :: 0: <f do.
  f=. AndroidLibPath,'/',t
elseif. 0 = 1!:4 :: 0: <f do.
  f=. t
end.

rxdll=: f

NB. =========================================================
NB. J DLL calls corresponding to the four extended regular expression
NB. functions defined in The Single Unix Specification, Version 2
jregcomp=: ('"',rxdll,'" regcomp + i *x *c i')&(15!:0)
jregexec=: ('"',rxdll,'" regexec + i *x *c x *i i')&(15!:0)
jregerror=: ('"',rxdll,'" regerror + x i * *c x')&(15!:0)
jregfree=: ('"',rxdll,'" regfree + n *x')&(15!:0)
''
)
