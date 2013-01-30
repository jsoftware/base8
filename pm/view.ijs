NB. view
NB. !!! 801 not updated

NB. 3 : 0''
NB. if. 0~: 4!:0 <'jvdet_jpm_' do. jvdet_jpm_=: 0 end.
NB. if. 0~: 4!:0 <'jvtot_jpm_' do. jvtot_jpm_=: 0 end.
NB. ''
NB. )
NB.
NB. NB. =========================================================
NB. jvdetdestroy=: 3 : 0
NB. gtk_widget_destroy_jgtk_ ::0: jvdet
NB. destroy__dgrid''
NB. jvdet=: 0
NB. )
NB.
NB. NB. =========================================================
NB. viewdetail=: 3 : 0
NB. require 'gl2 jzgrid'
NB. 0 viewdetail y
NB. :
NB. if. 0=read '' do. i. 0 0 return. end.
NB. 'DETSPACE DETEXPAND'=: opt=. detailoption x
NB. y=. getnameloc y
NB. sname=. getshortname 2 pick y
NB. pn=. 'PM',(x pick TIMETEXT;SPACETEXT),' - ',sname
NB.
NB. res=. x showdetail2 y
NB. if. 0 = L. res do. return. end.
NB. 'mdat mtxt ddat dtxt tdat ttxt'=. res
NB. if. (#mdat) *. #ddat do.
NB.   txt=. mtxt ,each ' ' ,each dtxt ,each ' ' ,each ttxt
NB.   txt=. mtxt ,each dtxt ,each ttxt
NB. else.
NB.   txt=. mtxt ,each dtxt
NB. end.
NB. data=: > join <"1 each txt
NB.
NB. if. 0~: jvdet do.
NB.   gtk_window_present_with_time_jgtk_ jvdet,GDK_CURRENT_TIME_jgtk_
NB. else.
NB.   jvdet=: gtk_window_new_jgtk_ 0
NB.   gtk_window_set_position_jgtk_ jvdet, GTK_WIN_POS_CENTER
NB.   consig_jgtk_ jvdet;'destroy';'jvdetdestroy';coname''
NB.   dcanvas=: glcanvas_jgl2_ 400 400;coname''
NB.   gtk_container_add_jgtk_ jvdet, dcanvas
NB.   gtk_widget_show_jgtk_ jvdet
NB.   dgrid=: '' conew 'jzgrid'
NB. end.
NB.
NB. hdr=. 'HDRCOL' ,&< 'All';'Here';'Rep';'Lines'
NB. hdr=. hdr , ('CELLALIGN';2 2 2 0) ,: ('CELLEDIT';0)
NB. show__dgrid hdr , ('GRIDPID';'jvdet') ,('GRIDHWNDC';dcanvas) ,('GRIDID';'dgrid') , ('GRIDSORT' ; 1) ,: 'CELLDATA' ;< data
NB. gtk_window_set_title_jgtk_ jvdet ; 'Execution Details for ',sname
NB. )
NB.
NB. NB. =========================================================
NB. tgrid_gridhandler=: 3 : 0
NB. select. y
NB. case. 'dblclick' do.
NB.   if. 0 <: Row__tgrid do.
NB.     if. '['~: {. 0{:: vl=. (<Row__tgrid;0 1) { CELLDATA__tgrid do.
NB.       TOTSPACE viewdetail vl
NB.     end.
NB.   end.
NB.   0
NB. case. do.
NB.   1  NB. Take default action for other events
NB. end.
NB. )
NB.
NB. NB. =========================================================
NB. jvtotdestroy=: 3 : 0
NB. gtk_widget_destroy_jgtk_ ::0: jvtot
NB. destroy__tgrid''
NB. jvtot=: 0
NB. )
NB.
NB. NB. =========================================================
NB. viewtotal=: 3 : 0
NB. require 'gl2 jzgrid'
NB. 0 viewtotal y
NB. :
NB. if. 0=read '' do. i. 0 0 return. end.
NB.
NB. if. 0~: jvtot do.
NB.   gtk_window_present_with_time_jgtk_ jvtot,GDK_CURRENT_TIME_jgtk_ return.
NB. end.
NB.
NB. jvtot=: gtk_window_new_jgtk_ 0
NB. gtk_window_set_position_jgtk_ jvtot, GTK_WIN_POS_CENTER
NB. consig_jgtk_ jvtot;'destroy';'jvtotdestroy';coname''
NB. tcanvas=: glcanvas_jgl2_ 400 400;coname''
NB. gtk_container_add_jgtk_ jvtot, tcanvas
NB. gtk_widget_show_jgtk_ jvtot
NB.
NB. pn=. 'PM',x pick TIMETEXT;SPACETEXT
NB. 'TOTSPACE TOTSUB TOTPCT'=: opt=. totaloption x
NB. dat=. opt showtotal1 y
NB. ftr=. +/ ('[rest]';'[total]') e. _2 {. 0 pick dat
NB. dat=. (> each 2 {. dat), 2 }. dat
NB. dataraw=: |: <"1 &> ,.each ((-ftr)&}.) each dat
NB. dat=. x showtotalfmt dat
NB. data=: |: <"1 &> dat
NB.
NB. tgrid=: '' conew 'jzgrid'
NB.
NB. hdr=. 'HDRCOL' ,&< 'Name';'Locale';'All';'Here';'Here%';'Cum%';'Rep'
NB. hdr=. hdr , ('CELLALIGN';0 0 2 2 2 2 2) ,: ('CELLEDIT';0)
NB. show__tgrid hdr , ('GRIDPID';'jvtot') , ('GRIDHWNDC';tcanvas) , ('GRIDID';'tgrid') , ('GRIDSORT' ; 1) ,: 'CELLDATA' ;< data
NB. gtk_window_set_title_jgtk_ jvtot ; pn
NB. )
NB.