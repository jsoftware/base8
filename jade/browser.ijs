NB. browser

NB. =========================================================
dquote=: 3 : 0
if. '"' = {.y do. y else. '"',y,'"' end.
)

NB. =========================================================
NB. browse
NB.
NB. load url/filename in browser
browse=: 3 : 0
if. -. isURL cmd=. dltb y do.
  if. -.fexist cmd do. EMPTY return. end.
end.
if. IFJHS do.
  redirecturl_jijxm_=: (' ';'%20') stringreplace ('file://'&,)^:(-.@isURL) iospath^:IFIOS abspath cmd
  EMPTY return.
elseif. IFIOS do.
  jh '<a href="',(('file://'&,)^:(-.@isURL) iospath abspath cmd),'"</a>'
  EMPTY return.
end.
browser=. Browser_j_
select. UNAME
case. 'Win' do.
  ShellExecute=. 'shell32 ShellExecuteW > i x *w *w *w *w i'&cd
  SW_SHOWNORMAL=. 1
  NULL=. <0
  if. 0 = #browser do.
    r=. ShellExecute 0;(uucp 'open');(uucp cmd);NULL;NULL;SW_SHOWNORMAL
  else.
    r=. ShellExecute 0;(uucp 'open');(uucp browser);(uucp dquote cmd);NULL;SW_SHOWNORMAL
  end.
  if. r<33 do. sminfo 'browse error:',browser,' ',cmd,LF2,1{::cderx'' end.
case. 'Android' do.
  android_exec_host 'android.intent.action.VIEW';(utf8 ('file://'&,)@abspath^:(-.@isURL) cmd);'text/html';16b0004000
case. do.
  if. 0 = #browser do.
    browser=. dfltbrowser''
  end.
  browser=. dquote (browser;Browser_nox_j_){::~ nox=. (UNAME-:'Linux') *. (0;'') e.~ <2!:5 'DISPLAY'
  cmd=. browser,' ',dquote cmd
  try.
    2!:1 cmd, (0=nox)#' >/dev/null 2>&1 &'
  catch.
    msg=. 'Could not run the browser with the command:',LF2
    msg=. msg, cmd,LF2
    if. IFQT do.
      msg=. msg, 'You can change the browser definition in Edit|Configure|Base',LF2
    end.
    sminfo 'Run Browser';msg
  end.
end.
EMPTY
)

NB. =========================================================
NB. dfltbrowser ''
NB.     return default browser, or ''
dfltbrowser=: verb define
select. UNAME
case. 'Win' do. ''
case. 'Darwin' do. 'open'
case. do.
  try.
    2!:0'which google-chrome'
    'google-chrome' return. catch. end.
  try.
    2!:0'which chromium'
    'chromium' return. catch. end.
  try.
    2!:0'which firefox'
    'firefox' return. catch. end.
  try.
    2!:0'which konqueror'
    'konqueror' return. catch. end.
  try.
    2!:0'which netscape'
    'netscape' return. catch. end.
  '' return.
end.
)
