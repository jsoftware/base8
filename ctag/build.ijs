NB. build

writesource_jp_ '~Main/ctag';'~system/main/ctag.ijs'

cf=. (jpath '~Main/ctag/') , ]
cu=. (jpath '~system/util/') , ]

mkdir_j_ cu''

(cu fcopynew cf) each cutopen 0 : 0
jadetag.ijs
)
