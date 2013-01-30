NB. text

NB. =========================================================
NB.*cutpara v cut text into boxed list of paragraphs
NB. form: cutpara text
cutpara=: 3 : 0
txt=. topara y
txt=. txt,LF -. {:txt
b=. (}.b,0) < b=. txt=LF
b <;._2 txt
)

NB. =========================================================
NB.*foldtext v fold text to given width
NB. form: width foldtext text
foldtext=: 4 : 0
if. 0 e. $y do. '' return. end.
y=. ; x&foldpara each cutpara y
y }.~ - (LF ~: |.y) i. 1
)

NB. =========================================================
NB.*foldpara v fold single paragraph
NB. syntax:   {width} fold data
NB. data is character vector
foldpara=: 4 : 0
if. 0=#y do. LF return. end.
r=. ''
x1=. >: x
txt=. y
while.
  ind=. ' ' i.~ |. x1{.txt
  s=. txt {.~ ndx=. x1 - >: x1 | ind
  s=. (+./\.s ~: ' ') # s
  r=. r, s, LF
  #txt=. (ndx + ind<x1) }. txt
do. end.
r
)

NB. =========================================================
NB.*topara v convert text to paragraphs
NB. form: topara text
NB. replaces single LFs not followed by blanks by spaces,
NB. except for LF's at the beginning
topara=: 3 : 0
if. 0=#y do. '' return. end.
b=. y=LF
c=. b +. y=' '
b=. b > (1,}:b) +. }.c,0
' ' (I. b) } y
)
