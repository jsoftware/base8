NB. standalone.ijs
NB. functions for construction of standalone applications

coclass <'jp'

STANDALONE=: 0 : 0
PATHSEP_j_=: '/'
jhostpath_z_=: PATHSEP_j_ & (I. @ (e.&'/\')@] })
jpath_z_=: jhostpath
load_z_=: require_z_=: script_z_=: ]

jsystemdefs_z_=: 3 : '0!:100 toHOST (y,''_'',tolower UNAME,(IF64#''_64''),''_j_'')~'

)

getstdenv=: 3 : 0
r=. freads jpath'~system/main/stdlib.ijs'
r=. r,freads jpath'~system/main/task.ijs'
r=. r,STANDALONE
hd=. 1 dir'~system/defs/hostdefs*.ijs'
for_h. hd do.
  hn=. '.ijs' taketo >{: fpathname >h
  r=. r,hn,'_j_=: 0 : 0',LF
  r=. r,freads h
  r=. r,')',LF
end.
qt=. freads jpath'~addons/ide/qt/qt.ijs'
r=. r, 'coclass ''jbaselibtag''' taketo qt
)

getlibs=: 3 : 0
libs=. jpath each getscripts_j_ <;._2 y,LF
r=. ''
for_i. libs do.
  r=. r,freads i
end.
r
)

