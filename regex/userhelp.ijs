NB. regex examples in user help

load 'regex'

pat=. rxcomp '(x+)([[:digit:]]+)'
str=. 'just one xxx1234 match here'
pat rxmatches str

(pat;1 2) rxmatches str   NB. just the 'x's and digits

pat |. rxapply str        NB. reverse the whole match

(pat;,2) |. rxapply str   NB.  reverse just the digits

rxfree pat                NB. free compiled pattern

pat=. '[[:alpha:]][[:alnum:]_]*'  NB. pattern for J name
str=. '3,foo3=.23,j42=.123,123'   NB. a sample string
pat rxmatch str                   NB. find at index 2, length 4

pat=. '([[:alpha:]][[:alnum:]_]*) *=[.;]'   NB. subexp is name in assign
pat rxmatch str         NB. pattern at 2/6; name at 2/4

pat rxmatches str       NB. find all matches

]phandle=. rxcomp pat   NB. compile

rxcomp '[wrong'         NB. a bad pattern

rxerror''

rxhandles ''            NB. just handle 1 defined

rxinfo phandle          NB.  return (1+#subexp);pattern

phandle rxmatches str   NB. use phandle like pattern

phandle rxfirst str     NB. first matching substring

phandle rxall str       NB. all matching substrings

phandle rxindex&> '  foo=.10';'nothing at all'   NB. index of match

phandle rxE str                 NB. mask over matches

'[[:digit:]]*' rxeq '2342342'   NB. test for exact match

'[[:digit:]]*' rxeq '2342 342'  NB. test for exact match

phandle rxmatch str         NB. entire and subexpression match

phandle rxmatches str            NB.  all matches

   (phandle rxmatches str) rxfrom str NB. rxfrom selects substrings using index/length pairs
┌──────┬────┐
│foo3=.│foo3│
├──────┼────┤
│j42=. │j42 │
└──────┴────┘

]m=. (phandle;,0) rxmatches str   NB.  entire matches only

m rxcut str       NB.  return alternating non-match/match boxes

('first';'second') m rxmerge str NB.  replace matches

phandle |. rxapply str        NB.  reverse each match

(phandle;,1) |. rxapply str   NB.   reverse just name part of match
