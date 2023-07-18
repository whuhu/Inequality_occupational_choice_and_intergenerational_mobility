global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径
set scheme cleanplots

//-----------------------Occu. mobility cohort trend------------
use "unclean_hu_1.dta",clear
//sort pid -survey_year
//duplicates drop pid,force
keep pid_f survey_year
drop if pid_f==-8
rename pid_f pid
duplicates drop pid survey_year,force
save "pid_f.dta",replace

use "unclean_hu_1.dta",clear
//sort pid -survey_year
//duplicates drop pid,force
keep pid_m survey_year
drop if pid_m==-8
rename pid_m pid
duplicates drop pid survey_year,force
save "pid_m.dta",replace


//----------------*use father id find father income*-----------------------------
use "unclean_hu_1.dta",clear
merge m:1 pid survey_year using "pid_f.dta"
keep if _merge==3
drop _merge
drop index pid_f pid_m
*drop age>64 parents


replace income=. if income<0

**at least two years of nonmissing income
// bys pid: gen xx=_N
// drop if xx==1 

*calculate permanent income
bys pid: egen income_permanent=mean(income) if income>0 & income~=.
bys pid: egen inc_nonmiss=count(income) if income>0 & income~=.
//gen parent age
gen fbirth_year=.
replace fbirth_year=2010-age if survey_year==2010
replace fbirth_year=2012-age if survey_year==2012
replace fbirth_year=2014-age if survey_year==2014
replace fbirth_year=2016-age if survey_year==2016
replace fbirth_year=2018-age if survey_year==2018

save "father_perminc.dta",replace

keep pid income age edu eduy isei survey_year income_permanent party wordtest_std mathtest_std non_cognitive isei_subjective dwr_std ns_w_std isco fbirth_year

rename pid pid_f
rename income income_f
rename age age_f
rename edu edu_f
rename eduy eduy_f
rename isei isei_f
rename income_permanent income_permanent_f
rename party party_f
rename wordtest_std wordtest_std_f
rename mathtest_std mathtest_std_f
rename non_cognitive non_cognitive_f
rename isei_subjective isei_subjective_f
rename dwr_std dwr_std_f
rename ns_w_std ns_w_std_f
rename isco isco_f
save "father_data.dta",replace


//keep father missing income
keep pid_f survey_year income_f income_permanent_f
keep if income_f==0
save "father_miss.dta",replace

//use father former income replace the missing obs
use "father_perminc.dta",clear
keep pid survey_year income_permanent inc_nonmiss
keep if income_permanent~=.
//keep the income for at least two year
drop if inc_nonmiss~=.&inc_nonmiss==1
drop inc_nonmiss
drop survey_year
duplicates drop pid,force
rename pid pid_f
save "father_perminc_done.dta",replace

use "father_miss.dta",clear
merge m:1 pid_f using father_perminc_done.dta
keep if _merge==3 & income_permanent~=.
keep pid_f survey_year income_permanent
save "father_miss_done.dta",replace

use "father_data.dta",clear
merge 1:1 pid_f survey_year using father_miss_done
replace income_permanent_f=income_permanent if _merge==3
drop _merge income_permanent
save "father_data.dta",replace


//----------------*use mother id find father income*-----------------------------
use "unclean_hu_1.dta",clear
merge m:1 pid survey_year using "pid_m.dta"
keep if _merge==3
drop _merge


replace income=. if income<0

**at least two years of nonmissing income
// bys pid: gen xx=_N
// drop if xx==1 

*calculate permanent income
bys pid: egen income_permanent=mean(income) if income>0 & income~=.
bys pid: egen inc_nonmiss=count(income) if income>0 & income~=.

gen mbirth_year=.
replace mbirth_year=2010-age if survey_year==2010
replace mbirth_year=2012-age if survey_year==2012
replace mbirth_year=2014-age if survey_year==2014
replace mbirth_year=2016-age if survey_year==2016
replace mbirth_year=2018-age if survey_year==2018
save "mother_perminc.dta",replace

keep pid income age edu eduy isei survey_year income_permanent party wordtest_std mathtest_std non_cognitive isei_subjective dwr_std ns_w_std isco mbirth_year

rename pid pid_m
rename income income_m
rename age age_m
rename edu edu_m
rename eduy eduy_m
rename isei isei_m
rename income_permanent income_permanent_m
rename party party_m
rename wordtest_std wordtest_std_m
rename mathtest_std mathtest_std_m
rename non_cognitive non_cognitive_m
rename isei_subjective isei_subjective_m
rename dwr_std dwr_std_m
rename ns_w_std ns_w_std_m
rename isco isco_m
save "mother_data.dta",replace

//keep income=0 obs
keep pid_m survey_year income_m income_permanent_m
keep if income_m==0
save "mother_miss.dta",replace

use "mother_perminc.dta",clear
keep pid survey_year income_permanent inc_nonmiss
keep if income_permanent~=.
drop if inc_nonmiss~=.&inc_nonmiss==1
drop inc_nonmiss
drop survey_year
duplicates drop pid,force
rename pid pid_m
save "mother_perminc_done.dta",replace

use "mother_miss.dta",clear
merge m:1 pid_m using mother_perminc_done.dta
keep if _merge==3 & income_permanent~=.
keep pid_m survey_year income_permanent
save "mother_miss_done.dta",replace

use "mother_data.dta",clear
merge 1:1 pid_m survey_year using mother_miss_done
replace income_permanent_m=income_permanent if _merge==3
drop _merge income_permanent
save "mother_data.dta",replace



//--------------------*input offspring income=0 obs*------------------
use "unclean_hu_1.dta",clear

bys pid: egen income_permanent=mean(income) if income>0 & income~=.
bys pid: egen inc_nonmiss=count(income) if income>0 & income~=.
save "c_perminc.dta",replace

keep pid survey_year income income_permanent
keep if income==0
rename income_permanent income_cperm
save "c_miss.dta",replace

use "c_perminc.dta",clear
keep pid survey_year income_permanent inc_nonmiss
keep if income_permanent~=.
drop if inc_nonmiss~=.&inc_nonmiss==1
drop inc_nonmiss
drop survey_year
duplicates drop pid,force
save "c_perminc_done.dta",replace

use "c_miss.dta",clear
merge m:1 pid using c_perminc_done.dta
keep if _merge==3 & income_permanent~=.
keep pid survey_year income_permanent
rename income_permanent income_cperm
save "c_miss_done.dta",replace

use "c_perminc.dta",clear
merge 1:1 pid survey_year using c_miss_done
replace income_permanent=income_cperm if _merge==3
drop _merge income_cperm

merge m:1 pid_f survey_year using "father_data.dta"
rename _merge merge_f

merge m:1 pid_m survey_year using "mother_data.dta"
rename _merge merge_m
drop if merge_f==1&merge_m==1
gen pair=merge_f+merge_m

drop index
save "paired.dta", replace

use "paired.dta",clear
local x "income isei edu eduy age gender urban west mid east income_f isei_f edu_f eduy_f age_f income_permanent_f income_m isei_m edu_m eduy_m age_m income_permanent_m"
foreach var of local x{
	replace `var'=. if `var'<0
}
gen edu3=1
replace edu3=2 if edu==4|edu==5
replace edu3=3 if edu==6|edu==7|edu==8

gen eduy3=1
replace eduy3=2 if eduy>9&eduy<16
replace eduy3=3 if eduy>15

sort pid pid_f pid_m -survey_year

gen birth_year=.
replace birth_year=2010-age if survey_year==2010
replace birth_year=2012-age if survey_year==2012
replace birth_year=2014-age if survey_year==2014
replace birth_year=2016-age if survey_year==2016
replace birth_year=2018-age if survey_year==2018

duplicates drop pid,force
save "$Out\occu_edu_mobility.dta",replace

foreach num of numlist 1/7{
	use "$Out\occu_edu_mobility.dta",clear
	keep if birth_year>=(`num'-1)*5+1970 & birth_year<=(`num'-1)*5+1974
	save "occu_edu_mobility_`num'.dta",replace
}


//----------------------Fig1 isei IGM---------
foreach num of numlist 1/7{
use "occu_edu_mobility_`num'.dta",clear

gen ols=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei isei_f,r
local b1=_b[isei_f]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[isei_f]+tc995*_se[isei_f]
replace lb_99=_b[isei_f]-tc995*_se[isei_f] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[isei_f]+tc975*_se[isei_f]
replace lb_95=_b[isei_f]-tc975*_se[isei_f]
gen rank=`num'
keep in 1
keep ols ub_99 lb_99 ub_95 lb_95 rank
save ols`num',replace
}

use ols1,clear
forvalues i=2/7 {
append using ols`i'.dta
}
save ols,replace

foreach num of numlist 1/7{
use "occu_edu_mobility_`num'.dta",clear

gen ols1=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei isei_m,r
local b1=_b[isei_m]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[isei_m]+tc995*_se[isei_m]
replace lb_99=_b[isei_m]-tc995*_se[isei_m] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[isei_m]+tc975*_se[isei_m]
replace lb_95=_b[isei_m]-tc975*_se[isei_m]
gen rank=`num'
keep in 1
keep ols1 ub_99 lb_99 ub_95 lb_95 rank
save ols1`num',replace
}

use ols11,clear
forvalues i=2/7 {
append using ols1`i'.dta
}
save ols1,replace

append using ols

twoway (connected ols rank,mlabsize(tiny))(connected ols1 rank,mlabsize(tiny)), xtitle(`"{fontface "宋体":子代出生队列}"') ytitle(`"{fontface "宋体":职业社会地位代际传递系数}"')  ///
 xlabel(1 "1970-74" 2 "1975-79" 3 "1980-84" 4 "1985-89" 5 "1990-94" 6 "1995-99" 7 "2000-2002", labsize(vsmall)) legend(label(1 父亲) label(2 母亲) pos(1) ring(0))

graph export "C:\Users\huhu\Desktop\重构code\out\fig\occu_edu_mobility.png", as(png) name("Graph") replace

//--------------------------table1 occu mobility matrix--------------
use  "$Out\occu_edu_mobility.dta",clear
tostring isco,replace
gen isco_1=substr(isco,1,1)
tostring isco_f,replace
gen isco_f_1=substr(isco_f,1,1)
tostring isco_m,replace
gen isco_m_1=substr(isco_m,1,1)

drop if isco_1=="."||isco_1=="-"

forval i =1/9{
gen rank_c100_c`i'_p1=(isco_1=="`i'") if isco_f_1=="1"
gen rank_c100_c`i'_p2=(isco_1=="`i'") if isco_f_1=="2"
gen rank_c100_c`i'_p3=(isco_1=="`i'") if isco_f_1=="3"
gen rank_c100_c`i'_p4=(isco_1=="`i'") if isco_f_1=="4"
gen rank_c100_c`i'_p5=(isco_1=="`i'") if isco_f_1=="5"
gen rank_c100_c`i'_p6=(isco_1=="`i'") if isco_f_1=="6"
gen rank_c100_c`i'_p7=(isco_1=="`i'") if isco_f_1=="7"
gen rank_c100_c`i'_p8=(isco_1=="`i'") if isco_f_1=="8"
gen rank_c100_c`i'_p9=(isco_1=="`i'") if isco_f_1=="9"
}

forval i = 1/9 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/9{
forval i = 1/9 {
	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label

//--------------------------table2 occu mobility matrix--------------
use  "$Out\occu_edu_mobility.dta",clear
tostring isco,replace
gen isco_1=substr(isco,1,1)
tostring isco_f,replace
gen isco_f_1=substr(isco_f,1,1)
tostring isco_m,replace
gen isco_m_1=substr(isco_m,1,1)

gen isco_skill=""
replace isco_skill="1" if isco_1=="9"
replace isco_skill="2" if isco_1=="4"||isco_1=="5"||isco_1=="6"||isco_1=="7"||isco_1=="8"
replace isco_skill="3" if isco_1=="3"
replace isco_skill="4" if isco_1=="2"

gen isco_skill_f=""
replace isco_skill_f="1" if isco_f_1=="9"
replace isco_skill_f="2" if isco_f_1=="4"||isco_f_1=="5"||isco_f_1=="6"||isco_f_1=="7"||isco_f_1=="8"
replace isco_skill_f="3" if isco_f_1=="3"
replace isco_skill_f="4" if isco_f_1=="2"

gen isco_skill_m=""
replace isco_skill_m="1" if isco_m_1=="9"
replace isco_skill_m="2" if isco_m_1=="4"||isco_m_1=="5"||isco_m_1=="6"||isco_m_1=="7"||isco_m_1=="8"
replace isco_skill_m="3" if isco_m_1=="3"
replace isco_skill_m="4" if isco_m_1=="2"

drop if isco_1=="."||isco_1=="-"

forval i =1/4{
gen rank_c100_c`i'_p1=(isco_skill=="`i'") if isco_skill_f=="1"
gen rank_c100_c`i'_p2=(isco_skill=="`i'") if isco_skill_f=="2"
gen rank_c100_c`i'_p3=(isco_skill=="`i'") if isco_skill_f=="3"
gen rank_c100_c`i'_p4=(isco_skill=="`i'") if isco_skill_f=="4"
}

forval i = 1/4 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/4{
forval i = 1/4 {
	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label

//--------------------------table occu mobility matrix--------------
use  "$Out\occu_edu_mobility.dta",clear
tostring isco,replace
gen isco_1=substr(isco,1,1)
tostring isco_f,replace
gen isco_f_1=substr(isco_f,1,1)
tostring isco_m,replace
gen isco_m_1=substr(isco_m,1,1)

gen isco_skill=""
replace isco_skill="1" if isco_1=="9"
replace isco_skill="2" if isco_1=="4"||isco_1=="5"||isco_1=="6"||isco_1=="7"||isco_1=="8"
replace isco_skill="3" if isco_1=="1"||isco_1=="2"||isco_1=="3"

gen isco_skill_f=""
replace isco_skill_f="1" if isco_f_1=="9"
replace isco_skill_f="2" if isco_f_1=="4"||isco_f_1=="5"||isco_f_1=="6"||isco_f_1=="7"||isco_f_1=="8"
replace isco_skill_f="3" if isco_f_1=="1"||isco_f_1=="2"||isco_f_1=="3"

gen isco_skill_m=""
replace isco_skill_m="1" if isco_m_1=="9"
replace isco_skill_m="2" if isco_m_1=="4"||isco_m_1=="5"||isco_m_1=="6"||isco_m_1=="7"||isco_m_1=="8"
replace isco_skill_m="3" if isco_m_1=="1"||isco_m_1=="2"||isco_m_1=="3"

drop if isco_1=="."||isco_1=="-"

forval i =1/3{
gen rank_c100_d0_c`i'_p1=(isco_skill=="`i'") if isco_skill_f=="1" & birth_year<=1985
gen rank_c100_d0_c`i'_p2=(isco_skill=="`i'") if isco_skill_f=="2"& birth_year<=1985
gen rank_c100_d0_c`i'_p3=(isco_skill=="`i'") if isco_skill_f=="3"& birth_year<=1985
}

forval i = 1/3 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d0_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label


forval i =1/3{
gen rank_c100_d1_c`i'_p1=(isco_skill=="`i'") if isco_skill_f=="1"& birth_year>1985
gen rank_c100_d1_c`i'_p2=(isco_skill=="`i'") if isco_skill_f=="2"& birth_year>1985
gen rank_c100_d1_c`i'_p3=(isco_skill=="`i'") if isco_skill_f=="3"& birth_year>1985
}


forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d1_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_B.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label


//diff-----------------
expand 2, gen(cohort)
forval j = 1/3 {
	forval i = 1/3 {
		replace rank_c100_d0_c`j'_p`i' = rank_c100_d1_c`j'_p`i' if cohort == 0
	}
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d0_c`j'_p`i'
}
eststo diff_`j': qui estpost ttest Parents_Income_Quintile*, by(cohort)
}

esttab diff_* using Table3_C.csv, ///
cells("b( fmt(3))" se(par fmt(3))) ///
replace label



//-------full sample
use  "$Out\occu_edu_mobility.dta",clear
tostring isco,replace
gen isco_1=substr(isco,1,1)
tostring isco_f,replace
gen isco_f_1=substr(isco_f,1,1)
tostring isco_m,replace
gen isco_m_1=substr(isco_m,1,1)

gen isco_skill=""
replace isco_skill="1" if isco_1=="9"
replace isco_skill="2" if isco_1=="4"||isco_1=="5"||isco_1=="6"||isco_1=="7"||isco_1=="8"
replace isco_skill="3" if isco_1=="1"||isco_1=="2"||isco_1=="3"

gen isco_skill_f=""
replace isco_skill_f="1" if isco_f_1=="9"
replace isco_skill_f="2" if isco_f_1=="4"||isco_f_1=="5"||isco_f_1=="6"||isco_f_1=="7"||isco_f_1=="8"
replace isco_skill_f="3" if isco_f_1=="1"||isco_f_1=="2"||isco_f_1=="3"

gen isco_skill_m=""
replace isco_skill_m="1" if isco_m_1=="9"
replace isco_skill_m="2" if isco_m_1=="4"||isco_m_1=="5"||isco_m_1=="6"||isco_m_1=="7"||isco_m_1=="8"
replace isco_skill_m="3" if isco_m_1=="1"||isco_m_1=="2"||isco_m_1=="3"

drop if isco_1=="."||isco_1=="-"
forval i =1/3{
gen rank_c100_c`i'_p1=(isco_skill=="`i'") if isco_skill_f=="1"
gen rank_c100_c`i'_p2=(isco_skill=="`i'") if isco_skill_f=="2"
gen rank_c100_c`i'_p3=(isco_skill=="`i'") if isco_skill_f=="3"
}

forval i = 1/3 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label






//--------------------------edu mobility-----------------
foreach num of numlist 1/7{
use "occu_edu_mobility_`num'.dta",clear

gen ols=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg eduy eduy_f,r
local b1=_b[eduy_f]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[eduy_f]+tc995*_se[eduy_f]
replace lb_99=_b[eduy_f]-tc995*_se[eduy_f] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[eduy_f]+tc975*_se[eduy_f]
replace lb_95=_b[eduy_f]-tc975*_se[eduy_f]
gen rank=`num'
keep in 1
keep ols ub_99 lb_99 ub_95 lb_95 rank
save ols`num',replace
}

use ols1,clear
forvalues i=2/7 {
append using ols`i'.dta
}
save ols,replace

foreach num of numlist 1/7{
use "occu_edu_mobility_`num'.dta",clear

gen ols1=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg eduy eduy_m,r
local b1=_b[eduy_m]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[eduy_m]+tc995*_se[eduy_m]
replace lb_99=_b[eduy_m]-tc995*_se[eduy_m] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[eduy_m]+tc975*_se[eduy_m]
replace lb_95=_b[eduy_m]-tc975*_se[eduy_m]
gen rank=`num'
keep in 1
keep ols1 ub_99 lb_99 ub_95 lb_95 rank
save ols1`num',replace
}

use ols11,clear
forvalues i=2/7 {
append using ols1`i'.dta
}
save ols1,replace

append using ols

twoway (connected ols rank,mlabsize(tiny))(connected ols1 rank,mlabsize(tiny)), xtitle(`"{fontface "宋体":子代出生队列}"') ytitle(`"{fontface "宋体":教育代际传递系数}"')  ///
 xlabel(1 "1970-74" 2 "1975-79" 3 "1980-84" 4 "1985-89" 5 "1990-94" 6 "1995-99" 7 "2000-2002", labsize(vsmall)) legend(label(1 父亲) label(2 母亲) pos(1) ring(0))

graph export "C:\Users\huhu\Desktop\重构code\out\fig\edu_mobility.png", as(png) name("Graph") replace


//--------------------------table2 edu mobility matrix--------------
use  "$Out\occu_edu_mobility.dta",clear

replace edu3=2 if edu==3
replace edu3=3 if edu==4|edu==5|edu==6|edu==7|edu==8

gen edu3_f=1
replace edu3_f=2 if edu_f==3
replace edu3_f=3 if edu_f==4|edu_f==5|edu_f==6|edu_f==7|edu_f==8

gen edu3_m=1
replace edu3_m=2 if edu_m==3
replace edu3_m=3 if edu_m==4|edu_m==5|edu_m==6|edu_m==7|edu_m==8

forval i =1/3{
gen rank_c100_c`i'_p1=(edu3==`i') if edu3_f==1
gen rank_c100_c`i'_p2=(edu3==`i') if edu3_f==2
gen rank_c100_c`i'_p3=(edu3==`i') if edu3_f==3
}

forval i = 1/3 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label

//-----------------------by cohort---------------
use "$Out\occu_edu_mobility.dta",clear
replace edu3=2 if edu==3
replace edu3=3 if edu==4|edu==5|edu==6|edu==7|edu==8

gen edu3_f=1
replace edu3_f=2 if edu_f==3
replace edu3_f=3 if edu_f==4|edu_f==5|edu_f==6|edu_f==7|edu_f==8

gen edu3_m=1
replace edu3_m=2 if edu_m==3
replace edu3_m=3 if edu_m==4|edu_m==5|edu_m==6|edu_m==7|edu_m==8

forval i =1/3{
gen rank_c100_d0_c`i'_p1=(edu3==`i') if edu3_f==1 & birth_year<=1985
gen rank_c100_d0_c`i'_p2=(edu3==`i') if edu3_f==2 & birth_year<=1985
gen rank_c100_d0_c`i'_p3=(edu3==`i') if edu3_f==3 & birth_year<=1985
}

forval i = 1/3 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d0_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_A.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label

//-------------------
forval i =1/3{
gen rank_c100_d1_c`i'_p1=(edu3==`i') if edu3_f==1 & birth_year>1985
gen rank_c100_d1_c`i'_p2=(edu3==`i') if edu3_f==2 & birth_year>1985
gen rank_c100_d1_c`i'_p3=(edu3==`i') if edu3_f==3 & birth_year>1985
}


forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d1_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
	sum Parents_Income_Quintile*
}

esttab output1_* using Table3_B.csv, ///
cells("mean(fmt(3))" sd(par fmt(3))) ///
replace label

expand 2, gen(cohort)
forval j = 1/3 {
	forval i = 1/3 {
		replace rank_c100_d0_c`j'_p`i' = rank_c100_d1_c`j'_p`i' if cohort == 0
	}
}

forval j = 1/3{
forval i = 1/3 {
	replace Parents_Income_Quintile`i' = rank_c100_d0_c`j'_p`i'
}
eststo diff_`j': qui estpost ttest Parents_Income_Quintile*, by(cohort)
}

esttab diff_* using Table3_C.csv, ///
cells("b( fmt(3))" se(par fmt(3))) ///
replace label









// use "$Out\reg_data_ushape.dta",clear
//
// gen rank_p1=0
// gen rank_p2=0
// gen rank_p3=0
// gen rank_p4=0
// gen rank_p5=0
//
// gen a0=0
// egen a1=pctile(isei), p(20)
// egen a2=pctile(isei), p(40)
// egen a3=pctile(isei), p(60)
// egen a4=pctile(isei), p(80)
// egen a5=max(isei)
//
// gen b0=0
// egen b1=pctile(isei_f), p(20)
// egen b2=pctile(isei_f), p(40)
// egen b3=pctile(isei_f), p(60)
// egen b4=pctile(isei_f), p(80)
// egen b5=max(isei_f)
//
// gen rank_c100_c20_p1=(isei<=a1) if isei_f>b0&isei_f<=b1
// gen rank_c100_c20_p2=(isei<=a1) if isei_f>b1&isei_f<=b2
// gen rank_c100_c20_p3=(isei<=a1) if isei_f>b2&isei_f<=b3
// gen rank_c100_c20_p4=(isei<=a1) if isei_f>b3&isei_f<=b4
// gen rank_c100_c20_p5=(isei<=a1) if isei_f>b5&isei_f<=b5
//
// gen rank_c100_c40_p1=(isei>a1 & isei<=a2) if isei_f>b0&isei_f<=b1
// gen rank_c100_c40_p2=(isei>a1 & isei<=a2) if isei_f>b1&isei_f<=b2
// gen rank_c100_c40_p3=(isei>a1 & isei<=a2) if isei_f>b2&isei_f<=b3
// gen rank_c100_c40_p4=(isei>a1 & isei<=a2) if isei_f>b3&isei_f<=b4
// gen rank_c100_c40_p5=(isei>a1 & isei<=a2) if isei_f>b5&isei_f<=b5
//
// gen rank_c100_c60_p1=(isei>a2 & isei<=a3) if isei_f>b0&isei_f<=b1
// gen rank_c100_c60_p2=(isei>a2 & isei<=a3) if isei_f>b1&isei_f<=b2
// gen rank_c100_c60_p3=(isei>a2 & isei<=a3) if isei_f>b2&isei_f<=b3
// gen rank_c100_c60_p4=(isei>a2 & isei<=a3) if isei_f>b3&isei_f<=b4
// gen rank_c100_c60_p5=(isei>a2 & isei<=a3) if isei_f>b5&isei_f<=b5
//
// gen rank_c100_c80_p1=(isei>a3 & isei<=a4) if isei_f>b0&isei_f<=b1
// gen rank_c100_c80_p2=(isei>a3 & isei<=a4) if isei_f>b1&isei_f<=b2
// gen rank_c100_c80_p3=(isei>a3 & isei<=a4) if isei_f>b2&isei_f<=b3
// gen rank_c100_c80_p4=(isei>a3 & isei<=a4) if isei_f>b3&isei_f<=b4
// gen rank_c100_c80_p5=(isei>a3 & isei<=a4) if isei_f>b5&isei_f<=b5
//
// gen rank_c100_c100_p1=(isei>a4 & isei<=a5) if isei_f>b0&isei_f<=b1
// gen rank_c100_c100_p2=(isei>a4 & isei<=a5) if isei_f>b1&isei_f<=b2
// gen rank_c100_c100_p3=(isei>a4 & isei<=a5) if isei_f>b2&isei_f<=b3
// gen rank_c100_c100_p4=(isei>a4 & isei<=a5) if isei_f>b3&isei_f<=b4
// gen rank_c100_c100_p5=(isei>a4 & isei<=a5) if isei_f>b5&isei_f<=b5
//
//
// forval i = 1/5 {
// 	gen Parents_Income_Quintile`i' = .
// }
//
// forval j = 20(20)100{
// forval i = 1/5 {
// 	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
// }
// eststo output1_`j': qui estpost summarize ///
//     Parents_Income_Quintile*
// }
//
// esttab output1* using Table3_A.csv, ///
// cells("mean( fmt(3))" sd(par fmt(3))) ///
// replace label