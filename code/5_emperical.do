global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径

set scheme cleanplots, perm


//------------------------*reduced-form reg---------------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov==-9

reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu i.prov,r
outreg2 using xxx.doc, replace bdec(3) tdec(2) ctitle(isei) ///
keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) addtext(Cohort FE, NO) label

*reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban mid east age minzu
reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu i.prov  cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu i.prov,r
outreg2 using xxx.doc, append  bdec(3) tdec(2) ctitle(eduy) keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) addtext(Cohort FE, NO )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )
		
reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban i.prov age minzu,r
outreg2 using xxx.doc, append  bdec(3) tdec(2) ctitle(lninc) keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) addtext(Cohort FE, NO )

reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )
*



///------------------------------SEM---------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov<0

gsem (isei<- eduy lninc_perm isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov) (eduy<- isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov) (lninc_perm <- eduy isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov),vce(r)
outreg2 using xxx.doc, replace  bdec(3) tdec(2) ///
keep(isei eduy lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) addtext(Cohort FE, NO)


gsem (isei<- eduy lninc_perm isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (eduy<- isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (lninc_perm <- eduy isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00),vce(r)
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ///
		keep(isei eduy lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

		
///---------------------COG AND Non_COG ABILITY-----------------
*-----cog and non-cog		
 

		

///---------------------------SEM subjective isei--------------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov==-9
gsem (isei_subjective <- eduy lninc_perm isei_subjective_f isei_subjective_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (eduy<- isei_subjective_f isei_subjective_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (lninc_perm <- eduy isei_subjective_f isei_subjective_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00),vce(r)
outreg2 using xxx.doc, replace          ///
         bdec(3) tdec(2) ///
		keep(isei_subjective eduy lninc_perm lninc_perm_pa eduy_f eduy_m isei_subjective_f isei_subjective_m gender urban age minzu) ///
        addtext(Cohort FE, YES )


// gsem (isei<- eduy lninc_perm isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (eduy<- isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) (lninc_perm <- eduy isei_f isei_m eduy_f eduy_m lninc_perm_pa gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00) if pctile<50
// outreg2 using xxx.doc, replace          ///
//          bdec(3) tdec(2) ///
// 		keep(isei_subjective eduy lninc_perm lninc_perm_pa eduy_f eduy_m isei_subjective_f isei_subjective_m gender urban age minzu) ///
//         addtext(Cohort FE, YES )
		
		

*异质性分析
//--------------------------*父亲-母亲----------------------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov==-9
*reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban mid east age minzu
reg isei lninc_perm_f eduy_f isei_f gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, replace          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_f eduy_f isei_f gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_f eduy_f isei_f gender urban age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_f eduy_f isei_f gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_f eduy_f isei_f gender urban i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_f eduy_f isei_f gender urban age minzu) ///
        addtext(Cohort FE, YES )


*母亲
reg isei lninc_perm_m eduy_m isei_m gender urban age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_m eduy_m isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_m eduy_m isei_m gender urban age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_m eduy_m isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_m eduy_m isei_m gender urban i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_m eduy_m isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

//--------------------------*城市-乡村----------------------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov==-9
*reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban mid east age minzu
reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00 if urban==1,r
outreg2 using xxx.doc, replace          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00 if urban==1,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00 if urban==1,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00 if urban==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00 if urban==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00 if urban==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )


//--------------------------*沿海-内陆----------------------------------
use "$Out\reg_data_ushape.dta",clear
drop if prov==-9
*reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban mid east age minzu
reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00 if coast==1,r
outreg2 using xxx.doc, replace          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender urban age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00 if coast==1,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00 if coast==1,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu i.prov cohort60 cohort70 cohort80 cohort90 cohort00 if coast==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(isei) ///
		keep(isei lninc_perm_pa eduy_f eduy_m isei_f isei_m gender coast age minzu) ///
        addtext(Cohort FE, YES )

reg eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age i.prov minzu cohort60 cohort70 cohort80 cohort90 cohort00 if coast==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(eduy) ///
		keep(eduy lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )

reg lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender i.prov age minzu cohort60 cohort70 cohort80 cohort90 cohort00 if coast==0,r
outreg2 using xxx.doc, append          ///
         bdec(3) tdec(2) ctitle(lninc) ///
		keep(lninc_perm lninc_perm_pa eduy_f eduy_m isei_f isei_m gender age minzu) ///
        addtext(Cohort FE, YES )
		
//---------------------------END--------------------------------	
	