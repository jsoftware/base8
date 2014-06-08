NB. ios
NB.%ios.ijs - ios utilities
NB.-This script defines ios utilities and is included in the J standard library.
NB.-Definitions are loaded into the z locale.

18!:4 <'z'

NB. ---------------------------------------------------------
NB. JVERSION_z_ (for ios)
3 : 0''
if. IFIOS do.
  r=. 'Engine: ',9!:14''
  r=. r,LF,'Library: ',LF -.~ 1!:1<jpath '~system/config/version.txt'
  r=. r,LF,'J/iOS Version: ',VERSION
  r=. r,LF,'Platform: ',UNAME,' ',IF64 pick '32';'64'
  r=. r,LF,'Installer: ',LF -.~ 1!:1 :: ('unknown'"_) <jpath'~bin/installer.txt'
  r=. r,LF,'InstallPath: ',jpath '~install'
  JVERSION=: toJ r
end.
EMPTY
)
