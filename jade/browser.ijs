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
cmd=. dlb@dtb y
isURL=. 1 e. '://'&E.
if. IFBROADWAY do.
  sminfo 'browse error: not yet implemented'
  EMPTY return.
end.
if. IFJHS do.
  cmd=. '/' (I. cmd='\') } cmd
  if. -. isURL cmd do.
    if. -.fexist cmd do. EMPTY return. end.
    cmd=. 'file://',cmd
  end.
  redirecturl_jijxm_=: (' ';'%20') stringreplace cmd
  EMPTY return.
end.
browser=. Browser_j_
select. UNAME
case. 'Win' do.
  ShellExecute=. 'shell32 ShellExecuteW > i x *w *w *w *w i'&cd
  SW_SHOWNORMAL=. 1
  NULL=. <0
  cmd=. '/' (I. cmd='\') } cmd
  if. -. isURL cmd do.
    if. -.fexist cmd do. EMPTY return. end.
    cmd=. 'file://',cmd
  end.
  if. 0 = #browser do.
    r=. ShellExecute 0;(uucp 'open');(uucp cmd);NULL;NULL;SW_SHOWNORMAL
  else.
    r=. ShellExecute 0;(uucp 'open');(uucp browser);(uucp dquote cmd);NULL;SW_SHOWNORMAL
  end.
  if. r<33 do. sminfo 'browse error:',browser,' ',cmd,LF2,1{::cderx'' end.
case. do.
  if. (UNAME-:'Android') > isatty 0 do.
    cmd=. '/' (I. cmd='\') } cmd
    if. -. isURL cmd do.
      cmd=. 'file://',cmd
    end.
    android_exec_host 'android.intent.action.VIEW';(utf8 cmd);''
  else.
    if. 0 = #browser do.
      browser=. dfltbrowser''
    end.
    browser=. dquote (browser;Browser_nox_j_){::~ nox=. IFUNIX *. (0;'') e.~ <2!:5 'DISPLAY'
    cmd=. '/' (I. cmd='\') } cmd
    if. -. isURL cmd do.
      cmd=. 'file://',cmd
    end.
    cmd=. browser,' ',dquote cmd
    try.
      2!:1 cmd, (0=nox)#' >/dev/null 2>&1 &'
    catch.
      msg=. 'Could not run the browser with the command:',LF2
      msg=. msg, cmd,LF2
      if. IFGTK+.IFQT do.
        msg=. msg, 'You can change the browser definition in Edit|Configure|Base',LF2
      end.
      sminfo 'Run Browser';msg
    end.
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
