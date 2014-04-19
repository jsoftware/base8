NB. snapshot

ss_today=: 's' , 2 }. [: ": [: <. 100 #. 3 {. 6!:0
SnapTrees=: ''

NB. =========================================================
snapfcopy=: 3 : 0
'source dest'=. y
if. IFWIN do.
  0 pick 'kernel32 CopyFileW i *w *w i' cd (uucp source);(uucp dest);0
else.
  if. 0 = fpathcreate fpath dest do. 0 return. end.
  if. _1 -: dat=. fread source do. 0 return. end.
  -. _1 -: dat fwrite dest
end.
)

NB. =========================================================
snapgetpath=: 3 : 0
p=. snappath y
if. 0 = #1!:0 p do.
  if. -. ss_mkdir p do. 0 return. end.
  y fwrite p,'/dir.txt'
end.
p
)

NB. =========================================================
NB. return snap path for directory path
NB. !!! 802
snappath=: 3 : 0
NB. jpath '~snap/.snp/',getsha1_jgtk_ y
)

NB. =========================================================
NB. y=0 auto snap
NB.   1 force snap
snapshot=: 3 : 0
if. Snapshots=0 do. return. end.
snapshot1 y;(ss_today'');ProjectPath
)

NB. =========================================================
NB. auto snapshot folder tree
snapshot_tree=: 3 : 0
if. Snapshots=0 do. return. end.
if. (<Folder_j_) e. SnapTrees do. return. end.
snapshot1 &> (<0;ss_today'') (,<@fpath) each y
empty SnapTrees_jp_=: SnapTrees,<Folder_j_
)

NB. =========================================================
NB. return 1 if snapshot completed
snapshot1=: 3 : 0
'force today path'=. y
p=. snapgetpath path
if. p = 0 do. return. end.

NB. ---------------------------------------------------------
NB. make a snapshot if none
p=. p,'/'
d=. 1!:0 p,'s*'
pfx=. p,today
if. 0=#d do. path ss_make pfx,'001' return. end.

NB. ---------------------------------------------------------
d=. \:~ {."1 d #~ 'd' = 4{"1 > 4{"1 d
last=. 0 pick d
iftoday=. today -: 7 {. last

NB. ---------------------------------------------------------
NB. force snap
if. force do.
  if. (p,last) ss_match ProjectPath do.
    ss_info 'Last snapshot matches current project.'
    0 return.
  end.
  if. iftoday do.
    f=. pfx,_3 {. '00',": 1 + 0 ". _3 {. last
  else.
    f=. pfx,'001'
  end.
  path ss_make f
  ss_info 'New snapshot: ',1 pick fpathname f
  
NB. ---------------------------------------------------------
NB. auto snap
else.
  if. iftoday do. 0 return. end.
  if. (p,last) ss_match path do. 0 return. end.
  path ss_make pfx,'001'
end.

NB. ---------------------------------------------------------
NB. only get here if new snapshot
d=. (Snapshots-1) }. d
for_s. d do.
  f=. p,(>s),'/'
  1!:55 f&, each {."1 [ 1!:0 f,'*'
  1!:55 <f
end.

1
)

NB. =========================================================
ss_cleanup=: 3 : 0
if. 1~:#y do.
  r=. ''
  r=. r,'0 = list invalid snapshot directories',LF
  r=. r,'1 = list non-existent projects with snapshots',LF
  r=. r,'100 = remove invalid snapshot directories',LF
  r=. r,'101 = remove snapshots for non-existent projects'
  smoutput r return.
end.
'd r n'=. ss_dirs''
select. y
case. 0 do.
  d #~ n=2
case. 1 do.
  r #~ n=1
case. 100 do.
  ; {. &> rmdir_j_ each d #~ n=2
case. 101 do.
  ; {. &> rmdir_j_ each d #~ n=1
end.
)

NB. =========================================================
NB. return pair
NB.   all snapshot directories
NB.   corresponding project names or '' if invalid
ss_dir=: 3 : 0
p=. jpath '~snap/.snp/'
d=. 1!:0 p,'*'
d=. ('d' = 4 {"1 > 4 {"1 d) # {."1 d
d=. (<p) ,each d
d;<(1!:1 :: (''"_))@< each d ,each <'/dir.txt'
)

NB. =========================================================
NB. return 3 lists:
NB.   all snapshot directories
NB.   corresponding project names or '' if invalid
NB.   numeric list:
NB.     0 project snapshot
NB.     1 non-project snapshot
NB.     2 invalid snapshot
ss_dirs=: 3 : 0
'd r'=. ss_dir''
s=. /:r
r=. s{r
d=. s{d
m=. 0 < #&> r
n=. 2 * -. m
r=. m#r
p=. (*./\.@:~:&'/' # ]) each r
p=. r ,each '/' ,each p ,each <ProjExt
n=. (-. fexist &> p) (I.m) } n
r=. (tofoldername_j_ each r) (I.m) } (#d) # <''
d;r;n
)

NB. =========================================================
NB. ss_files get directory list of files
NB. ignores exclusion list and hidden files
ss_files=: 3 : 0
t=. 1!:0 y,'*'
if. 0=#t do. return. end.
att=. > 4{"1 t
msk=. ('h' = 1{"1 att) +: 'd' = 4{"1 att
t=. /:~ msk # t
if. _1 = 4!:0 <'ss_exclude' do.
  exs=. '.' ,each SnapshotX_j_
  ss_exclude_jp_=: [: +./ exs & ((1 e. E.) &>/)
end.
t #~ -. ss_exclude {."1 t
)

NB. =========================================================
ss_find=: 3 : 0
y=. y,(0=#y)#ProjectPath
'd r'=. ss_dir''
ndx=. r i. <jpath remsep_j_ y
ndx pick d,<'not found: ',y
)

NB. =========================================================
ss_info=: 3 : 0
sminfo 'Snapshot';y
)

NB. =========================================================
NB. ss_list v list of snapshots
NB. argument is projectname
ss_list=: 3 : 0
if. 0=#y do. '' return. end.
p=. snappath projname2path y
d=. 1!:0 p,'/s*'
if. #d do.
  d=. d #~ 'd' = 4 {"1 > 4 {"1 d
  \:~ {."1 d
else.
  ''
end.
)

NB. =========================================================
NB. ss_make - make a snapshot
ss_make=: 4 : 0
fm=. x,'/'
to=. y,'/'
if. 0 = ss_mkdir to do. 0 return. end.
f=. {."1 ss_files fm
fm=. (<fm) ,each f
to=. (<to) ,each f
res=. snapfcopy"1 fm ,. to
if. 0 e. res do.
  txt=. 'Unable to copy:',LF2,tolist (res=0)#fm
  ss_info txt
end.
*./ res
)

NB. =========================================================
NB. ss_mkdir - make snapshot directory
ss_mkdir=: 3 : 0

NB. ---------------------------------------------------------
if. 0 -: fpathcreate y do.
  if. 1 = # 1!:0 y do. 1 return. end.
  ss_info 'Unable to create snapshot directory: ',y
  0 return.
end.

NB. ---------------------------------------------------------
arw=. 'rw' 0 1 } 1!:7 <y
if. 0 -: arw 1!:7 :: 0: <y do.
  ss_info 'Unable to set read/write attributes for snapshot directory.'
  0 return.
end.

NB. ---------------------------------------------------------
if. -.IFUNIX do.
  ph=. 'h' 1 } 1!:6 <y
  if. 0 -: ph 1!:6 :: 0: <y do.
    ss_info 'Unable to set hidden attribute for snapshot directory.'
  end.
end.

1
)

NB. =========================================================
NB. ss_match match directories
ss_match=: 4 : 0
x=. termsep x
y=. termsep y
a=. ss_files x
b=. ss_files y
ra=. #a
rb=. #b
if. 0 e. ra,rb do.
  ra = rb return.
end.
fa=. {."1 a
fb=. {."1 b
if. -. fa -: fb do. 0 return. end.
if. -. (2 {"1 a) -: (2 {"1 b) do. 0 return. end.
fx=. x&, each fa
fy=. y&, each fa
(<@(1!:1) fy) -: <@(1!:1) fx
)

NB. =========================================================
NB. remove all snapshots from folder tree
ss_removesnaps=: 3 : 0
direrase each snappath each fpath each FolderTree
)

NB. =========================================================
ss_state=: 3 : 0
'd r n'=. ss_dirs''
r=. 'valid existent, valid nonexistent, invalid:',LF
r=. r,":+/ n =/ 0 1 2
)
