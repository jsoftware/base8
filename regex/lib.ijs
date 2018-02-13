NB. lib

NB. =========================================================
NB. compile flags:
PCRE2_NOTBOL=: 16b1
PCRE2_NOTEOL=: 16b2
PCRE2_MULTILINE=: 16b400

NB. info types:
PCRE2_INFO_SIZE=: 22

NB. =========================================================
NB. pcre2 library is in bin or tools/regex
3 : 0''
select. UNAME
case. 'Win' do. t=. 'jpcre2.dll'
case. 'Darwin' do. t=. 'libjpcre2.dylib'
case. 'Linux' do. t=. 'libjpcre2.so'
end.

f=. BINPATH,'/',t
if. 0 = 1!:4 :: 0: <f do.
  f=. jpath '~tools/regex/',t
end.

NB. fall back one more time
if. ('Android'-:UNAME) *. 0 = 1!:4 :: 0: <f do.
  arch=. LF-.~ 2!:0'getprop ro.product.cpu.abi'
  f=. jpath '~bin/../libexec/',arch,'/',t
elseif. 0 = 1!:4 :: 0: <f do.
  f=. t
end.

pcre2dll=: f
)

NB. =========================================================
makefn=: 3 : 0
'name decl'=. y
('j',name)=: ('"',pcre2dll,'" ',name,'_8 ',(IFWIN#'+ '),decl)&(15!:0)
EMPTY
)

makefn 'pcre2_code_free';'n *'
makefn 'pcre2_compile';'* *c i i *i *i *'
makefn 'pcre2_get_error_message';'i i *c i'
makefn 'pcre2_get_ovector_count';'i *'
makefn 'pcre2_get_ovector_pointer';'*i *'
makefn 'pcre2_match';'i * *c i i i * *'
makefn 'pcre2_match_data_create_from_pattern';'* * *'
makefn 'pcre2_match_data_free';'n *'
makefn 'pcre2_pattern_info';'i * i *c'
