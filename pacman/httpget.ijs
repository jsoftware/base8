NB. httpget

NB. =========================================================
NB. httpget, storing file in temp
NB. y is file[;retries]
NB. retries are set for initial read of revision.txt
NB. result is returncode (0=OK);filename or message
NB. any error message is displayed
httpget=: 3 : 0
'f t'=. 2 {. (boxxopen y),a:
n=. f #~ -. +./\. f e. '=/'
p=. jpath '~temp/',n
q=. jpath '~temp/httpget.log'
t=. ":{.t,3
ferase p;q
fail=. 0
cmd=. HTTPCMD rplc '%O';(dquote p);'%L';(dquote q);'%t';t;'%T';(":TIMEOUT);'%U';f
try.
  if. (UNAME-:'Android') > fexist jpath '~tools/ftp/wget' do.
    rr=. f anddf p
    if. rr >: 0 do.
      r=. 0;p
    else.
      msg=. 'Download failed: ',f,'. returned ',": rr
      log msg
      info 'Connection failed:',LF2,msg
      r=. 1; msg
    end.
    ferase q
    r
    return.
  else.
    e=. shellcmd cmd
  end.
catch. fail=. 1 end.
if. fail +. 0 >: fsize p do.
  if. _1-:msg=. freads q do.
    if. 0=#msg=. e do. msg=. 'Unexpected error' end. end.
  log 'Connection failed: ',msg
  info 'Connection failed:',LF2,msg
  r=. 1;msg
  ferase p;q
else.
  r=. 0;p
  ferase q
end.
r
)

NB. =========================================================
NB. httpget, returning result
httpgetr=: 3 : 0
res=. httpget y
if. 0 = 0 pick res do.
  f=. 1 pick res
  txt=. freads f
  ferase f
  0;txt
end.
)
