NB. run

coreset''
dbg 1
dbstops''

pmtest=: 3 : 0
if. y do.
  ferase jpath '~config/pacmancfg.ijs'
  ferase jpath '~system/config/version.txt'
  ferase {."1 dirtree jpath '~addons'
end.
runpacman_jpacman_ ''
)

runpacman_jpacman_ ''
