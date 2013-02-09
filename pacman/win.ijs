NB. view form

BASELIB=: 'base library'
DATAMASK=: 0
PKGDATA=: 0 7$a:
IFSECTION=: 0
SECTION=: ,<'All'
SELNDX=: 0 0

NB. =========================================================
STATUS=: cutopen 0 : 0
All
Not installed
Installed, updateable
All installed
)

j=. 'cellalign cellcolors celledit cellmark celltype colminwidth colscale'
j=. j,' gridborder gridid gridmargin gridpid gridrowmode'
GRIDNAMES=: j,' hdrcol hdrcolalign'

NB. menu prelib "&Switch Library..." "" "" "";
NB. menusep;

NB. =========================================================
Dat=: 0 : 0
0 api/expat 1.0.0 1.0.0 libexpat
0 api/glx 1.0.2 1.0.2 "OpenGL GLX API"
1 "base library" 7.1.78 7.1.80 "base library scripts"
0 "data/jdb" 1.0.24 1.0.25 JDB
0 "debug/dissect" "" 1.03 "Run a sentence and produce a grid display of results"
0 "debug/lint" 1.10.0 1.10.0 "Load a script and check its syntax"
)

Dat=: ; 5#<Dat

NB. =========================================================
table=: 3 : 0
wd 'pc table'
wd 'cc pac table'
wd 'setp pac coltypes 1 0 0 0 0'
wd 'setp pac colnames "" Package Installed Latest Caption'
wd 'set pac *',Dat
wd 'pmovex 100 10 600 250'
wd 'pshow'
)

NB. =========================================================
PMVIEW=: 0 : 0
pc pmview closeok;
menupop "&File";
menu exit "&Quit" "Ctrl+Q";
menupopz;
menupop "&Tools";
menu pupcat "&Update Catalog from Server";
menusep;
menu prebuild "&Rebuild all Repository Catalogs";
menusep;
menu pprefs "&Preferences..." "" "" "";
menupopz;
splith 0 1 100 150;
cc sel listbox;
bin h;
cc bstatus radiobutton;cn "Status";
cc bsection radiobutton group;cn "Category";
bin z;
cc g0 groupbox;cn "Selections";
cc bclear button;cn "Clear All";
cc bupdate button;cn "Updates";
cc bnotins button;cn "Not Installed";
cc bselall button;cn "Select All";
cc apply button;cn "Install";
splitsep;
splitv 1 0 400 150;
cc pac table;
setp pac coltypes 1 0 0 0 0;
setp pac colnames "" Package Installed Latest Caption;
splitsep;
cc edlog editm;
bin h;
cc bsummary radiobutton;cn "Summary";
cc bhistory radiobutton group;cn "History";
cc bmanifest radiobutton group;cn "Manifest";
cc blog radiobutton leftmove topmove rightmove bottommove group;cn "Log";
cc agrid isigraph rightmove bottommove;
cc binfo button;cn "Wiki";
splitend;
splitend;
)

NB. =========================================================
pmview_run=: 3 : 0
wd PMVIEW
wd 'set sel one two three'
wd 'set pac *',Dat
wd 'pmovex 100 10 900 700'
wd 'pshow'

return.
wd 'pn *',SYSNAME
wd 'setfont adesc ',TEXTFONT
HWNDP=: wd 'qhwndp'
AHWNDC=: wd 'qhwndc agrid'
wpset 'pmview'
sel_view 0
pmview_gridinit''
pmview_show''
wd 'pshow'
)

NB. =========================================================
agrid_gridhandler=: 3 : 0
select. y
case. 'mark' do.
  row=. {.CELLMARK__agrid
  wd 'set adesc *',(<row;5) pick VIEWDATA
  a=. '~addons/',(<row;1){:: VIEWDATA
  wd 'set edhis *',}.^:(_1&-:) fread jpath a,'/history.txt'
  wd 'set edman *',}.^:(_1&-:) fread jpath a,'/manifest.ijs'
  if. 0".blog do. sel_view 0 end.
end.
1
)

NB. =========================================================
sel_view=: 3 : 0
if. #y do.
  'bsummary bhistory bmanifest blog'=: <;._1 ' ',":|._4{.#:2^y
  wd 'set bsummary ',bsummary
  wd 'set bhistory ',bhistory
  wd 'set bmanifest ',bmanifest
  wd 'set blog ',blog
end.
wd 'setshow adesc ',bsummary
wd 'setshow edhis ',bhistory
wd 'setshow edman ',bmanifest
wd 'setshow edlog ',blog
)

NB. =========================================================
addon_info=: 3 : 0
if. 0=#VIEWDATA do. return.end.
row=. {.CELLMARK__agrid
a=. (<row;1){:: VIEWDATA
if. 'base library'-:a do. a=. 'JAL' else. a=. 'Addons/',a end.
a=. 'http://www.jsoftware.com/jwiki/',a
browser_view a
)

NB. =========================================================
browser_view=: 3 : 0
require '~system/util/browser.ijs'
launch_jbrowser_ y
)

NB. =========================================================
pmview_apply_button=: 3 : 0
dat=. pmview_selected''
if. 0 = #dat do.
  info 'No packages selected for installation.' return.
end.
if. -. ONLINE do.
  if. -. getonline 'Install Packages';CHECKONLINE do. return. end.
end.
install dat
)

NB. =========================================================
pmview_bclear_button=: 3 : 0
pmview_read''
setshowall 0
pmview_show''
)

NB. =========================================================
pmview_bnotins_button=: 3 : 0
pmview_read''
setshownew 1
pmview_show''
)

NB. =========================================================
pmview_bselall_button=: 3 : 0
pmview_read''
setshowall 1
pmview_show''
)

NB. =========================================================
pmview_bupdate_button=: 3 : 0
pmview_read''
setshowups 1
pmview_show''
)

NB. =========================================================
pmview_prebuild_button=: 3 : 0
if. -. ONLINE do.
  getonline 'Read Catalog from Server';CHECKASK
end.
if. ONLINE do.
  log 'Updating server catalog...'
  refreshjal''
end.
log 'Rebuilding local file list...'
refreshaddins''
readlocal''
log 'Done.'
pacman_init''
)

NB. =========================================================
pmview_pupcat_button=: 3 : 0
if. -. ONLINE do.
  if. 0 = getonline 'Read Catalog from Server';CHECKASK do. return. end.
end.
log 'Updating server catalog...'
if. refreshweb'' do.
  log 'Done.'
end.
pacman_init''
)

NB. =========================================================
pmview_sel_select=: 3 : 0
pmview_read ''
pmview_show''
)

NB. =========================================================
pmview_applycounts=: 3 : 0
dat=. y
if. 0=#dat do. 0 0 return. end.
'lib dat'=. splitlib dat
cnt=. 0 < #lib
siz=. cnt * 2 pick LIB
ind=. ({."1 ZIPS) i. 1 {"1 dat
(cnt + #ind),siz + +/>(<ind;4){ZIPS
)

NB. =========================================================
pmview_getmask=: 3 : 0
ndx=. IFSECTION { SELNDX
if. IFSECTION do.
  sel=. ndx pick SECTION
  select. sel
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. BASELIB do.
    DATAMASK=: (1 {"1 PKGDATA) = <BASELIB
  case. do.
    DATAMASK=: (<sel,'/') = (1+#sel) {.each 1 {"1 PKGDATA
  end.
else.
  select. ndx pick STATUS
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. 'Not installed' do.
    DATAMASK=: pkgnew''
  case. 'Installed, updateable' do.
    DATAMASK=: pkgups''
  case. 'All installed' do.
    DATAMASK=: -. pkgnew''
  end.
end.
)

NB. =========================================================
pmview_gridinit=: 3 : 0
agrid=: '' conew 'jzgrid'
cellcolors=. CELLCOLORS__agrid
cellcolors=. 248 (<0;3 4 5) } cellcolors
cellalign=. 0
celledit=. 1 0 0 0 0
cellmark=. 0 0
celltype=. 100 0 0 0 0
colminwidth=. 10 20 20 20 20
colscale=. 0 0 0 0 1
gridborder=. 1
gridmargin=. 3 6 1 0
gridrowmode=: 1
gridid=. 'agrid'
gridpid=. 'pmview'
hdrcol=. '';'Package';'Installed';'Latest';'Caption'
hdrcolalign=: 1 0 0 0 0
setnames__agrid pack GRIDNAMES
)

NB. =========================================================
pmview_postinit=: 3 : 0
pmview_setmenu''
pmview_show''
logstatus''
)

NB. =========================================================
pmview_read=: 3 : 0
SELNDX=: (0 ". sel_select) IFSECTION } SELNDX
IFSECTION=: 0 ". bsection
new=. CELLDATA__agrid,._2 {."1 VIEWDATA
PKGDATA=: new (I.DATAMASK) } PKGDATA
)

NB. =========================================================
pmview_refresh=: 3 : 0
pmview_read''
pmview_show''
)

NB. =========================================================
pmview_selected=: 3 : 0
pmview_read''
PKGDATA #~ > {."1 PKGDATA
)

NB. =========================================================
pmview_setmenu=: 3 : 0
glsel AHWNDC
nms=. ;: 'stable current beta'
msk=. nms e. 1 {"1 LIBS
sel=. 1 e. (}.msk,0) *. nms = <LIBTREE
NB. disabled for nonce
NB. wd 'setenable prelib ',":ONLINE *. sel
)

NB. =========================================================
pmview_show=: 3 : 0
pmview_getmask ''
glsel AHWNDC
wd 'set bstatus ',":-. IFSECTION
wd 'set bsection ',":IFSECTION
sel=. IFSECTION pick STATUS;<SECTION
wd 'set sel ',todel sel
wd 'setselect sel ',":IFSECTION { SELNDX
wd 'setenable apply ',":ONLINE
sel_view''
pmview_showdata DATAMASK # PKGDATA
)

NB. =========================================================
pmview_showdata=: 3 : 0
VIEWDATA=: y
CELLDATA__agrid=: _2 }."1 VIEWDATA
show__agrid ''
if. #y do.
  row=. {.CELLMARK__agrid
  wd 'set adesc *',(<row;5) pick VIEWDATA
end.
)

NB. =========================================================
NB. pmview_cancel=: pmview_close=: destroy
pmview_cancel=: pmview_close=: wd bind 'pclose'
pmview_bsection_button=: pmview_refresh
pmview_bstatus_button=: pmview_refresh
pmview_pprefs_button=: pmprefs_run
pmview_exit_button=: pmview_close
pmview_prelib_button=: prelib

pmview_bsummary_button=: pmview_refresh
pmview_bhistory_button=: pmview_refresh
pmview_bmanifest_button=: pmview_refresh
pmview_blog_button=: pmview_refresh
pmview_binfo_button=: addon_info
