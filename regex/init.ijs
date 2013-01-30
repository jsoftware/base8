NB. Regular expression pattern matching
NB.
NB. PCRE: Perl-compatible regular expression library
NB. with POSIX interface
NB.
NB. =========================================================
NB. main definitions:
NB.   rxmatch          single match
NB.   rxmatches        all matches
NB.
NB.   rxcomp           compile pattern
NB.   rxfree           free pattern handles
NB.   rxhandles        list pattern handles
NB.   rxinfo           info on pattern handles
NB.
NB. regex utilities:
NB.   rxeq             -:
NB.   rxin             e.
NB.   rxindex          i.
NB.   rxE              E.
NB.   rxfirst          {.@{    (first match)
NB.   rxall            {       (all matches)
NB.   rxrplc           search and replace
NB.   rxapply          apply verb to pattern
NB.
NB.   rxerror          last regex error message
NB.
NB. other utilities:
NB.   rxcut            cut string into nomatch/match list
NB.   rxfrom           matches from string
NB.   rxmerge          replace matches in string
NB.
NB. =========================================================
NB. Form:
NB.   here:  pat      = pattern, or pattern handle
NB.          phnd     = pattern handle
NB.          patndx   = pattern;index  or  phnd;index
NB.          str      = character string
NB.          bstr     = boxed list of str
NB.          mat      = result of regex search
NB.          nsub     = #subexpressions in pattern
NB.
NB.  mat=.  pat or patndx   rxmatch   str
NB.  mat=.  pat or patndx   rxmatches str
NB.
NB.  phnd=.                 rxcomp    pat
NB.  empty=.                rxfree    phnd
NB.  phnds=.                rxhandles ''
NB.  'nsub pat'=.           rxinfo    phnd
NB.
NB.  boolean=.        pat   rxeq      str
NB.  index=.          pat   rxindex   str
NB.  mask=.           pat   rxE       str
NB.  bstr=.           pat   rxfirst   str
NB.  bstr=.           pat   rxall     str
NB.  str=.     (patndx;new) rxrplc    str
NB.  str=.     patndx (verb rxapply)  str
NB.
NB.  errormsg=.             rxerror   ''
NB.
NB.  bstr             mat   rxcut     str
NB.  bstr=.           mat   rxfrom    str
NB.  str=.         new (mat rxmerge)  str

NB. =========================================================
NB. following defined in z:
NB.*rxmatch v single match
NB.*rxmatches v all matches
NB.*rxcomp v compile pattern
NB.*rxfree v free pattern handles
NB.*rxhandles v list pattern handles
NB.*rxinfo v info on pattern handles
NB.*rxeq v regex equivalent of -:
NB.*rxin v regex equivalent of e.
NB.*rxindex v regex equivalent of i.
NB.*rxE v regex equivalent of E.
NB.*rxfirst v regex equivalent of {.@{ (first match)
NB.*rxall v regex equivalent of { (all matches)
NB.*rxrplc v search and replace
NB.*rxapply v apply verb to pattern
NB.*rxerror v last regex error message
NB.*rxcut v cut string into nomatch/match list
NB.*rxfrom v matches from string
NB.*rxmerge v replace matches in string
NB.*rxutf8 v set UTF-8 support 1=on(default), 0=off

coclass <'jregex'

NB. =========================================================
NB. flag to enable UTF-8 support
RX_OPTIONS_UTF8=: 1

Rxnna=: '(^|[^[:alnum:]_])'
Rxnnz=: '($|[^[:alnum:]_.:])'
Rxass=: '[[:space:]]*=[.:]'
