NB. config

PACMANCFG=: jpath '~config/pacman.cfg'

readconfig=: 3 : 0
ReadCatalog=: 2
0!:0 :: ] <PACMANCFG
)
