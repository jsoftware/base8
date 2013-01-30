NB. main save

cocurrent 'jpsave'
mkdir_j_ jpath '~.Main/release/'
mkdir_j_ jpath '~system/main'

f=. 3 : 0
load '~Main/',y,'/build.ijs'
)

Source=: <;._2 (0 : 0)
compare
config
ctag
defs
jade
main
pacman
pm
pp
project
regex
socket
tar
task
)

f each Source

F=. cutopen 0 : 0
main
jade
compare
)

dat=. ; freads each (<jpath '~.Main/release/') ,each F , each <'.ijs'
dat=. dat, 'cocurrent <''base'''

dat fwritenew jpath '~system/main/stdlib.ijs'

(jpath '~.system/breaker.ijs') fcopynew jpath '~Main/main/breaker.ijs'
