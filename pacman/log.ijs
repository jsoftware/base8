NB. log

LOG=: 1 NB. if logging
LOGMAX=: 100 NB. lines

NB. =========================================================
NB. add to log
log=: 3 : 0
if. LOG do. smoutput y end.
)

NB. =========================================================
logstatus=: 3 : 0
if. ONLINE do.
  log checkstatus''
end.
)
