NB. test pacman httpget on code.jsoftware.com

W=: 'www.jsoftware.com'
C=: 'code.jsoftware.com'
F=: 'https://',C,'/index.html'
T=: jpath '~temp/index.html'

NB. =========================================================
NB. this first test should fail on windows j807 installation,
NB. and work on linux and mac:
load 'pacman'
httpget_jpacman_ F;3;T

NB. =========================================================
NB. on windows, rename wget:
'~tools/ftp/wget.OLD' frename '~tools/ftp/wget.exe'
load 'pacman'
httpget_jpacman_ F;3;T

NB. =========================================================
NB. restore wget, rebuild, then overwrite usual pacman and try again:
Note''
'~tools/ftp/wget.exe' frename '~tools/ftp/wget.OLD'
load '~Main/pacman/build.ijs'
dat=: freads '~Main/release/install/system/util/pacman.ijs'
0!:101 dat rplc W;C
cocurrent 'base'
httpget_jpacman_ F;3;T
)
