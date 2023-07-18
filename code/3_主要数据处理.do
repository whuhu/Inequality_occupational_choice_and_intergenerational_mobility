global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径

set scheme cleanplots, perm

use "$D\unclean_hu_adj.dta",clear

*adjust income
//*adjusted to 2010 price by CPI, from statistic yearbook of China (NBS)*
replace income=income/(1.054*1.026) if survey_year==2012
replace income=income/(1.054*1.026*1.026*1.02) if survey_year==2014
replace income=income/(1.054*1.026*1.026*1.02*1.014*1.02) if survey_year==2016
replace income=income/(1.054*1.026*1.026*1.02*1.014*1.02*1.016*1.021) if survey_year==2018


//----------------*gen west mid east-----------------------------
gen west=0
gen mid=0
gen east=0

replace west=1 if prov==50|prov==51|prov==52|prov==53|prov==54|prov==61|prov==62|prov==63|prov==64|prov==65
replace mid=1 if prov==14|prov==15|prov==22|prov==23|prov==34|prov==36|prov==41|prov==42|prov==43
replace east=1 if prov==11|prov==12|prov==13|prov==21|prov==31|prov==32|prov==33|prov==35|prov==37|prov==44|prov==45|prov==46


//----------------*gen coast/inland*-----------------------------
g coast=(prov==11|prov==12|prov==13|prov==21|prov==31|prov==32|prov==33|/*
*/ prov==35|prov==37|prov==44|prov==46)
save "unclean_hu_1.dta",replace


//----------------*get father and mother pid*-----------------------------
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
drop if age>64

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
drop if age>64

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


//--------------------*merge offsprings with parents*--------------------------
merge m:1 pid_f survey_year using "father_data.dta"
rename _merge merge_f

merge m:1 pid_m survey_year using "mother_data.dta"
rename _merge merge_m
drop if merge_f==1&merge_m==1
gen pair=merge_f+merge_m

drop index
save "paired.dta", replace

use "paired.dta",clear
//select offspring age
drop if age<16|age>50
local x "income isei edu eduy age gender urban west mid east income_f isei_f edu_f eduy_f age_f income_permanent_f income_m isei_m edu_m eduy_m age_m income_permanent_m"
foreach var of local x{
	replace `var'=. if `var'<0
}
//gen parental income
gen income_pa=.
replace income_pa=income_f+income_m if (income_f~=. & income_m~=.)
replace income_pa=income_f if income_f~=. & income_m ==.
replace income_pa=income_m if income_f==. & income_m ~=.

//gen parental permanent income
gen income_permanent_pa=.
replace income_permanent_pa=income_permanent_f+income_permanent_m if (income_permanent_f~=. & income_permanent_m~=.)
replace income_permanent_pa=income_permanent_f if income_permanent_f~=. & income_permanent_m ==.
replace income_permanent_pa=income_permanent_m if income_permanent_f==. & income_permanent_m ~=.


*drop if income_pa<3000
*drop if income_permanent_pa<3000
drop if income_permanent_pa>200000 & income_permanent_pa~=.
*drop if income_permanent_f<3000|income_permanent_m<3000
*drop if income_permanent_f<3000|income_permanent_m<3000


// local x "income income_f income_permanent_f income_m income_permanent_m income_pa income_permanent_pa"
// foreach var of local x{
// 	winsor2 `var', cuts(1 99) replace
// }

//gen logrithm of income
gen lninc=ln(income)
gen lninc_f=ln(income_f)
gen lninc_m=ln(income_m)
gen lninc_pa=ln(income_pa)
gen lninc_perm_pa=ln(income_permanent_pa)
gen lninc_perm_f=ln(income_permanent_f)
gen lninc_perm_m=ln(income_permanent_m)
gen lninc_perm=ln(income_permanent)
gen lnisei=ln(isei)

gen age2=age^2/100
gen age_f2=age_f^2/100
gen age_m2=age_m^2/100

//gen edu_3
gen edu3=1
replace edu3=2 if edu==4|edu==5
replace edu3=3 if edu==6|edu==7|edu==8

gen eduy3=1
replace eduy3=2 if eduy>9&eduy<16
replace eduy3=3 if eduy>15

rename ethnic minzu
replace minzu=0 if minzu!=1&minzu!=-8
replace minzu=. if minzu<0

sort pid pid_f pid_m -survey_year

//define label
label define xingbie 0 "女性" 1 "男性"
label values gender xingbie

label define minzu_label 0 "少数民族" 1 "汉族"
label values minzu minzu_label

label define chengxiang 0 "农村" 1 "城市"
label values urban chengxiang

label variable isei "子代职业社会地位"
label variable eduy "子代受教育年限"
label variable eduy_f "父亲受教育年限"
label variable eduy_m "母亲受教育年限"
label variable lninc_pa "父代对数收入"
label variable lninc_perm_pa "父代对数永久收入"
label variable age "子代年龄"
label variable gender "性别"
label variable urban "城市"
label variable minzu "汉族"
label variable coast "沿海"


*get offspring birth cohort
gen birth_year=.
replace birth_year=2010-age if survey_year==2010
replace birth_year=2012-age if survey_year==2012
replace birth_year=2014-age if survey_year==2014
replace birth_year=2016-age if survey_year==2016
replace birth_year=2018-age if survey_year==2018
save "$Out\panel.dta",replace


use "$Out\panel.dta",clear
*drop isei==.
drop if isei==.

drop if income_permanent_pa==.
//transform panel data to cross-sectional data
duplicates drop pid,force


// gen rolling cohort decreasing radius weighting
forvalues y=1971/2000 {
	gen cohort`y'=1 if birth_year>=`y'-3 & birth_year<=`y'+3
	fre cohort`y'
	gen weight`y'=1 if birth_year==`y'
	replace weight`y'=0.75 if birth_year==`y'-1 | birth_year==`y'+1
	replace weight`y'=0.50 if birth_year==`y'-2 | birth_year==`y'+2
    replace weight`y'=0.25 if birth_year==`y'-3 | birth_year==`y'+3
}

// gen pct rank within cohort
gen pct=.
gen dummy=1
forvalues y=1971/2000{
	di `y'
	sort income_permanent_pa
	gegen count=count(dummy) [pw=weight`y'] if cohort`y'==1
	gegen rank=rank(income_permanent_pa)[pw=weight`y'] if cohort`y'==1
	gen pct`y'=(rank-1)/(count-1) if birth_year==`y'
	replace pct=pct`y'*100 if birth_year==`y'
	drop pct`y' count rank
}

// father rolling cohort decreasing radius weighting
drop cohort*
drop weight*
forvalues y=1946/1994 {
	gen cohort`y'=1 if fbirth_year>=`y'-3 & fbirth_year<=`y'+3
	fre cohort`y'
	gen weight`y'=1 if fbirth_year==`y'
	replace weight`y'=0.75 if fbirth_year==`y'-1 | fbirth_year==`y'+1
	replace weight`y'=0.50 if fbirth_year==`y'-2 | fbirth_year==`y'+2
    replace weight`y'=0.25 if fbirth_year==`y'-3 | fbirth_year==`y'+3
}

// pct rank within cohort
gen pct_f=.

forvalues y=1946/1994{
	di `y'
	sort income_permanent_f
	gegen count=count(dummy) [pw=weight`y'] if cohort`y'==1&income_permanent_f~=.
	gegen rank=rank(income_permanent_f) [pw=weight`y'] if cohort`y'==1&income_permanent_f~=.
	gen pct`y'=(rank-1)/(count-1) if fbirth_year==`y'&income_permanent_f~=.
	replace pct_f=pct`y'*100 if fbirth_year==`y'&income_permanent_f~=.
	drop pct`y' count rank
}

// mother rolling cohort decreasing radius weighting
drop cohort*
drop weight*
forvalues y=1946/1983 {
	gen cohort`y'=1 if mbirth_year>=`y'-3 & mbirth_year<=`y'+3
	fre cohort`y'
	gen weight`y'=1 if mbirth_year==`y'
	replace weight`y'=0.75 if mbirth_year==`y'-1 | mbirth_year==`y'+1
	replace weight`y'=0.50 if mbirth_year==`y'-2 | mbirth_year==`y'+2
    replace weight`y'=0.25 if mbirth_year==`y'-3 | mbirth_year==`y'+3
}

// pct rank within cohort
gen pct_m=.

forvalues y=1946/1983{
	di `y'
	sort income_permanent_m
	gegen count=count(dummy) [pw=weight`y'] if cohort`y'==1&income_permanent_m~=.
	gegen rank=rank(income_permanent_m) [pw=weight`y'] if cohort`y'==1&income_permanent_m~=.
	gen pct`y'=(rank-1)/(count-1) if mbirth_year==`y'&income_permanent_m~=.
	replace pct_m=pct`y'*100 if mbirth_year==`y'&income_permanent_m~=.
	drop pct`y' count rank
}


// child rolling cohort decreasing radius weighting
drop cohort*
drop weight*
forvalues y=1964/2002 {
	gen cohort`y'=1 if birth_year>=`y'-3 & birth_year<=`y'+3
	fre cohort`y'
	gen weight`y'=1 if birth_year==`y'
	replace weight`y'=0.75 if birth_year==`y'-1 | birth_year==`y'+1
	replace weight`y'=0.50 if birth_year==`y'-2 | birth_year==`y'+2
    replace weight`y'=0.25 if birth_year==`y'-3 | birth_year==`y'+3
}

// pct rank within cohort
gen pct_c=.

forvalues y=1964/2002{
	di `y'
	sort income_permanent
	gegen count=count(dummy) [pw=weight`y'] if cohort`y'==1&income_permanent~=.
	gegen rank=rank(income_permanent) [pw=weight`y'] if cohort`y'==1&income_permanent~=.
	gen pct`y'=(rank-1)/(count-1) if birth_year==`y'&income_permanent~=.
	replace pct_c=pct`y'*100 if birth_year==`y'&income_permanent~=.
	drop pct`y' count rank
}

****************************************************************************
//gen cohort dummy
gen cohort60=0
replace cohort60=1 if birth_year<1970
gen cohort70=0
replace cohort70=1 if birth_year<1980 & birth_year>1969
gen cohort80=0
replace cohort80=1 if birth_year<1990 & birth_year>1979
gen cohort90=0
replace cohort90=1 if birth_year<2000 & birth_year>1989
gen cohort00=0
replace cohort00=1 if birth_year<2010 & birth_year>1999
save "$Out\reg_data_ushape.dta", replace


//create cohort data
foreach num of numlist 1/21{
	use "$Out\reg_data_ushape.dta",clear
	keep if birth_year>=(`num'-1)+1971 & birth_year<=(`num'-1)+1980
	save "reg_data_cohort_`num'.dta",replace
}



*creat data for vcm model
use "$Out\reg_data_ushape.dta", clear
drop if income_permanent_pa<3000
save "$Out\vcm.dta",replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa gender urban mid east age minzu
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data A1\R_vcm.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa eduy gender urban mid east age minzu
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data A2\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa gender urban mid east age minzu
keep if gender==1
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data Son1\R_vcm.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa eduy gender urban mid east age minzu
keep if gender==1
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data Son2\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa gender urban mid east age minzu
keep if gender==0
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data Dau1\R_vcm.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep isei lninc_perm_pa eduy gender urban mid east age minzu
keep if gender==0
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\Standard\R data Dau2\R_vcm_eduy.csv",  nolabel replace

*creat data for R vcm+CA

use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data A1 CA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data A2 CA\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m
keep if gender==1
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data Son1 CA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m
// keep if gender==1
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data Son2 CA\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m
keep if gender==0
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data Dau1 CA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m
// keep if gender==0
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\CA\R data Dau2 CA\R_vcm_eduy.csv",  nolabel replace



*creat data for R vcm+CA+NCA
use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m non_cognitive_f non_cognitive_m
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data A1 NCA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m non_cognitive non_cognitive_f non_cognitive_m
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data A2 NCA\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m non_cognitive_f non_cognitive_m
keep if gender==1
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data Son1 NCA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m non_cognitive non_cognitive_f non_cognitive_m
// keep if gender==1
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data Son2 CA+NCA\R_vcm_eduy.csv",  nolabel replace

use "$Out\vcm.dta", clear
keep if survey_year==2010|survey_year==2014|survey_year==2018
keep isei lninc_perm_pa gender urban mid east age minzu wordtest_std_f wordtest_std_m mathtest_std_f mathtest_std_m non_cognitive_f non_cognitive_m
keep if gender==0
export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data Dau1 NCA\R_vcm.csv",  nolabel replace

// use "$Out\reg_data_ushape.dta", clear
// keep isei lninc_pa eduy gender urban mid east age minzu wordtest_std wordtest_std_f wordtest_std_m mathtest_std mathtest_std_f mathtest_std_m non_cognitive non_cognitive_f non_cognitive_m
// keep if gender==0
// export delimited using "C:\Users\huhu\Desktop\重构code\code\R code\NCA\R data Dau2 CA+NCA\R_vcm_eduy.csv",  nolabel replace
