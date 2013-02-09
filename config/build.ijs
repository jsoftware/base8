NB. config build

cf=. (jpath '~Main/config/') , ]
ct=. (jpath '~system/config/') , ]
cu=. (jpath '~system/util/') , ]
cc=. (jpath '~.system/user/config/') , ]

mkdir_j_ ct''
mkdir_j_ cu''

t=. jpath '~system/util/boot.ijs'
t fcopynew cf 'boot.ijs'

fl=. cutopen 0 : 0
base.cfg
folders.cfg
version.txt
)

(ct fcopynew cf) each fl

(cu fcopynew cf) each cutopen 0 : 0
scripts.ijs
)

d=. freads cf 'configure.ijs'
d=. d,LF,'configrun$0',LF
d fwritenew cu 'configure.ijs'

(jpath '~bin/profile.ijs') fcopynew cf 'profile.ijs'
(jpath '~bin/profilex_template.ijs') fcopynew cf 'profilex_template.ijs'
