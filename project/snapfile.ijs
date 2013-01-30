NB. snapfile (pic)
NB.
NB. format is file,stamp (hhmmss),EAV
NB.
NB. files are stored in their original encoding

pp_today=: 2 }. [: ": [: <. 100 #. 3 {. 6!:0
pp_stamp=: [: ":@, 'r<0>2.0' (8!:2) _3 {. 6!:0
pp_unstamp=: ':' (2 5}"1) 1 1 0 1 1 0 1 1 (#^:_1"1) _6 {.&> ]

NB. =========================================================
NB. x = new data (original encoding)
NB. y = full filename
pic=: 4 : 0
'f p'=. fpathname y
path=. remsep f
d=. snapgetpath path
if. d -: 0 do. return. end.
d=. d,'/p',pp_today''
t=. d,'/',p
dat=. x,(pp_stamp''),EAV
if. _1 -: fread t do.
  if. -. pic_inidir d do. 0 return. end.
  old=. fread y
  if. -. _1 -: old do.
    dat=. old,(6#'0'),EAV,dat
  end.
end.
dat fappend t
)

NB. =========================================================
NB. get file list for given folder
pic_files=: 3 : 0
{."1 [1!:0 (snappath remsep y),'/p','/*',~pp_today''
)

NB. =========================================================
NB. check dir is initialized, return if ok
pic_inidir=: 3 : 0
if. #1!:0 y do. 1 return. end.
h=. (y i: 'p') {. y
n=. {."1 [ 1!:0 h,'p*'
if. #n do.
  direrase h,'plast'
  n=. \:~ n -. <'plast'
  if. #n do.
    if. 1<#n do.
      direrase &> (<h) ,each }.n
    end.
    (h,'plast') frename h,0 pick n
  end.
end.
ss_mkdir y
)

NB. =========================================================
NB. argument is date yymmdd
pic_list=: 3 : 0
t=. y,(0=#y)#pp_today''
p=. (snappath each fpath each FolderTree) ,each <'/p*'
d=. 1!:0 each p
m=. I. 0 < # &> d
if. 0 = #m do. EMPTY return. end.
p=. ;t&pic_list1 each m
s=. >}."1 p
p=. ({."1 p),<'total'
(>p),.' ',.":s,+/s
)

NB. =========================================================
pic_list1=: 4 : 0
fp=. (snappath fpath y pick FolderTree),'/p',x,'/'
d=. 1!:0 fp,'*'
if. 0=#d do. i. 0 3 return. end.
f=. {."1 d
c=. (EAV+/ .=fread) each (<fp) ,each f
s=. 2{"1 d
m=. (<'/',~y pick FolderIds),each f
m,.c,.s
)

NB. =========================================================
NB. y = full filename
NB. reads all records as boxed list
pic_read=: 3 : 0
'f p'=. fpathname y
r=. fread (snappath remsep f),'/p',(pp_today''),'/',p
if. r -: _1 do. '' else. <;._2 r end.
)

NB. =========================================================
NB. y = (full filename);index
NB. reads record at index, removing timestamp
pic_readx=: 3 : 0
'f n'=. y
_6 }. n pick pic_read f
)

