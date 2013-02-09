NB. run

NB. coreset''
NB. dbg 1
NB. dbstops''
NB.
NB. pmtest=: 3 : 0
NB. if. y do.
NB.   ferase jpath '~config/pacmancfg.ijs'
NB.   ferase jpath '~system/config/version.txt'
NB.   ferase {."1 dirtree jpath '~addons'
NB. end.
NB. runpacman_jpacman_ ''
NB. )
NB.
NB. runpacman_jpacman_ ''


load 'pacman'
pmview_run_jpacman_''