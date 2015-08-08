NB. jal definitions
NB.%jal.ijs - jal utilities
NB.-This script defines jal utilities and is included in the J standard library.
NB.-Definitions are loaded into the z locale.

cocurrent 'z'

NB. =========================================================
NB.*install v install from jal
NB.-Install from jal.
NB.-
NB.-y is either 'qtide' to install the Qt IDE, or 'all' to install all jal packages
NB.-or else calls 'install' jpkg y
install=: 3 : 0
require 'pacman'
do_install_jpacman_ y
)

NB. =========================================================
NB.*getqtbin v get Qt binaries
NB.-Get Qt binaries.
NB.-
NB.-Always downloads the jqt binary.
NB.-
NB.-For the qt library (required for mac and win):
NB.- y is 0 - download if not present
NB.-      1 - always download
NB.-
NB.-For linux:
NB.-y is 'slim' for the slim binaries
NB.-
NB.-For windows:
NB.-y is 'angle' for the ANGLE binaries
getqtbin=: 3 : 0
if. (<UNAME) -.@e. 'Linux';'Darwin';'Win' do. return. end.
if. IFQT+.IFIOS+.'Android'-:UNAME do.
  smoutput 'must run from jconsole' return.
end.
require 'pacman'
do_getqtbin_jpacman_ y
)
