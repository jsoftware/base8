NB. regshow

NB. =========================================================
NB. utility to show rxmatches
regshow=: 4 : 0
m=. x rxmatches y
r=. ,:y
if. 0 = # m do. return. end.
for_i. i. 1 { $ m do.
  a=. i {"2 m
  x=. ;({."1 a) (+i.) each {:"1 a
  r=. r, '^' x } (#y) # ' '
end.
)

NB. smoutput 'a(bc)' regshow '123 abc zabcde'
