NB. build regular expressions for J code
NB.
NB. builds the script: regj.ijs
NB.
NB. modify and re-run as required
NB.
NB. see also the last part of the lab: Regular Expression Builder

'regbuild' load '~system/packages/regex/regbuild.ijs'

TXT_regbuild_=: 0 : 0
NB. regj.ijs   - nouns for applying regular expressions to J code
NB.             (built from file: system/packages/regex/regjbld.ijs)
NB.
NB.   Jname        name
NB.   Jnumitem     numeric item
NB.   Jnum         number or blank
NB.   Jcharitem    character item
NB.   Jchar        character
NB.   Jconst       constant
NB.
NB.   Jlassign     local assign
NB.   Jgassign     global assign
NB.   Jassign      any assign
NB.
NB.   Jlpar        left paren
NB.   Jrpar        right paren
NB.
NB.   Jsol         start of line
NB.   Jeol         end of line
)

run_regbuild_=: 3 : 0
Q=.''''
quote=: (Q&,@(,&Q))@ (#~ >:@(=&Q))
def=. 3 : ('y,''=: '',(quote ".y),'''',LF')

Jname=: (Alpha,anyof set alnum,'_') or ;or&.>/ plain&.> ;:'x y m n u v'
Jnumitem=: (set digit,'_'),anyof set alnum,'_.'
Jnum=: optional sub Jnumitem or Blank
Jcharitem=: Q,(sub (Q,Q) or set not Q),Q
Jchar=: Q,(anyof (Q,Q) or set not Q),Q
Jconst=: Jnum or Jchar or 'a:' or plain 'a.'

Jlassign=: plain '=.'
Jgassign=: plain '=:'
Jassign=: '=' by set '.:'

Jlpar=: plain '('
Jrpar=: plain ')'

Jsol=: sol , owhite
Jeol=: owhite , (optional (plain 'NB.'),anyof '.') , eol

j=. 'Jname Jnumitem Jnum Jcharitem Jchar Jconst Jlassign Jgassign'
nms=. ;: j,' Jassign Jlpar Jrpar Jsol Jeol'
txt=. TXT,LF, ; def each nms

txt=. toHOST txt
txt 1!:2 <jpath '~system/packages/regex/regj.ijs'
)

run_regbuild_''
clear 'regbuild'
