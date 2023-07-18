global path "C:\Users\haoliang\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径
set scheme cleanplots
 set scheme s2color
grstyle init
grstyle set plain, horizontal grid noextend
grstyle set ci

//-----------------Fig 1 parental income pct contribution---------------------
use "$Out\reg_data_ushape.dta",clear
// sort x prov
// br x prov
// drop if prov==-9|prov==54|prov==63|prov==46|prov==15|prov==65|prov==11|prov==35|prov==64

foreach var in isei pct_f pct_m age urban{
		drop if `var'==.
	}
	
bys prov:egen x=count(_N)
drop if x<=40
drop x

save "$Out\temp.dta",replace

statsby _b[pct_f] _b[pct_m], by(prov): reg isei pct_f pct_m age urban cohort60-cohort00

ren (_stat_1 _stat_2)(coef_finc coef_minc)

centile coef_minc, centile(1 99) 
replace coef_minc=r(c_1) if coef_minc<r(c_1) // bottom code at 1st percentile
replace coef_minc=r(c_2) if coef_minc>r(c_2) // top code at 99th percentile


centile coef_finc, centile(1 99) 
replace coef_finc=r(c_1) if coef_finc<r(c_1) // bottom code at 1st percentile
replace coef_finc=r(c_2) if coef_finc>r(c_2) // top code at 99th percentile


save "$Out/F1_joint.dta", replace


//-----------------------urban

use "$Out\reg_data_ushape.dta",clear

drop if prov<0
save "$Out\temp.dta",replace
statsby _b[pct_f] _b[pct_m], by(urban): ///
				reg isei pct_f pct_m age i.prov cohort60-cohort00

ren (_stat_1 _stat_2)(coef_finc coef_minc)

centile coef_minc, centile(1 99) 
replace coef_minc=r(c_1) if coef_minc<r(c_1) // bottom code at 1st percentile
replace coef_minc=r(c_2) if coef_minc>r(c_2) // top code at 99th percentile


centile coef_finc, centile(1 99) 
replace coef_finc=r(c_1) if coef_finc<r(c_1) // bottom code at 1st percentile
replace coef_finc=r(c_2) if coef_finc>r(c_2) // top code at 99th percentile


save "$Out/F1_urban.dta", replace

//-----------------------coast

use "$Out\reg_data_ushape.dta",clear
gen coast1=.
replace coast1=3 if coast==1
replace coast1=2 if coast==0
drop if prov<0
drop coast
rename coast1 coast
save "$Out\temp.dta",replace


statsby _b[pct_f] _b[pct_m], by(coast): ///
				reg isei pct_f pct_m age urban cohort60-cohort00

ren (_stat_1 _stat_2)(coef_finc coef_minc)

centile coef_minc, centile(1 99) 
replace coef_minc=r(c_1) if coef_minc<r(c_1) // bottom code at 1st percentile
replace coef_minc=r(c_2) if coef_minc>r(c_2) // top code at 99th percentile


centile coef_finc, centile(1 99) 
replace coef_finc=r(c_1) if coef_finc<r(c_1) // bottom code at 1st percentile
replace coef_finc=r(c_2) if coef_finc>r(c_2) // top code at 99th percentile


save "$Out/F1_coast.dta", replace
//---------------------------Fig 1 END---------------------------------

//----------------------Fig 2/3 linear/threshold reg coef---------------------

use "$Out\reg_data_ushape.dta",clear

foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear
quietly reg isei lninc_perm_pa gender urban mid east age minzu
estimates store m`num'
}
local labels `labels' 1971-80 1972-81 1973-82 1974-83 1975-84 1976-85 1977-86 1978-87 1979-88 1980-89 1981-90 1982-91 1983-92 1984-93 1985-94 1986-95 1987-96 1988-97 1989-98 1990-99 1991-00
coefplot m1||m2||m3||m4||m5||m6||m7||m8||m9||m10||m11||m12||m13||m14||m15||m16||m17||m18||m19||m20||m21, keep(lninc_perm_pa) vertical bycoefs addplot(line @b @at, lp(connected) lcolor(black)) bylabels(`labels') xtitle(`"{fontface "宋体":滚动队列}"') ytitle(`"{fontface "宋体":线性回归系数}"')


foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear

gen ols=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei lninc_perm_pa gender urban mid east age minzu
local b1=_b[lninc_perm_pa]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[lninc_perm_pa]+tc995*_se[lninc_perm_pa]
replace lb_99=_b[lninc_perm_pa]-tc995*_se[lninc_perm_pa] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[lninc_perm_pa]+tc975*_se[lninc_perm_pa]
replace lb_95=_b[lninc_perm_pa]-tc975*_se[lninc_perm_pa]
gen rank=`num'
keep in 1
keep ols ub_99 lb_99 ub_95 lb_95 rank
save ols`num',replace
}

use ols1,clear
forvalues i=2/21 {
append using ols`i'.dta
}
save ols,replace

foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear

gen low=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
threshold isei, threshvar(pct) regionvars(lninc_perm_pa gender urban mid east age minzu) nthresh(1) nodots
matrix b = e(b)
local b1=b[1,1]
di `b1'
replace low=`b1'
matrix se=e(V)

scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=b[1,1]+tc995*se[1,1]
replace lb_99=b[1,1]-tc995*se[1,1]
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=b[1,1]+tc975*se[1,1]
replace lb_95=b[1,1]-tc975*se[1,1]
gen rank=`num'
keep in 1
keep low ub_99 lb_99 ub_95 lb_95 rank
save low`num',replace
}

use low1,clear
forvalues i=2/21 {
append using low`i'.dta
}
save low,replace

foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear

gen high=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
threshold isei, threshvar(pct) regionvars(lninc_perm_pa gender urban mid east age minzu) nthresh(1) nodots
matrix b = e(b)
local b1=b[1,9]
di `b1'
replace high=`b1'
matrix se=e(V)

scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=b[1,9]+tc995*se[9,9]
replace lb_99=b[1,9]-tc995*se[9,9]
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=b[1,9]+tc975*se[9,9]
replace lb_95=b[1,9]-tc975*se[9,9]
gen rank=`num'
keep in 1
keep high ub_99 lb_99 ub_95 lb_95 rank
save high`num',replace
}

use high1,clear
forvalues i=2/21 {
append using high`i'.dta
}
save high,replace

use high,clear
append using ols.dta
append using low.dta

drop if rank==1
*drop if low<0
twoway (connected ols rank,mlabsize(tiny))(connected low rank,mlabsize(tiny))(connected high rank,mlabsize(tiny)), xtitle(`"{fontface "宋体":滚动队列}"') ytitle(`"{fontface "宋体":回归系数}"')  ///
 xlabel(1 "1971-80" 2 "1972-81" 3 "1973-82" 4 "1974-83" 5 "1975-84" 6 "1976-85" 7 "1977-86" 8 "1978-87" 9 "1979-88" 10 "1980-89" 11 "1981-90" 12 "1982-91" 13 "1983-92" 14 "1984-93" 15 "1985-94" 16 "1986-95" 17 "1987-96" 18 "1988-97" 19 "1989-98" 20 "1990-99" 21 "1991-00", labsize(tiny))


 

******************** Table1  quintile transition matrix *********************
use "$Out\reg_data_ushape.dta",clear

gen rank_p1=0
gen rank_p2=0
gen rank_p3=0
gen rank_p4=0
gen rank_p5=0

gen a0=0
egen a1=pctile(isei), p(20)
egen a2=pctile(isei), p(40)
egen a3=pctile(isei), p(60)
egen a4=pctile(isei), p(80)
egen a5=max(isei)

gen rank_c100_c20_p1=(isei<=a1) if pct>0&pct<=20
gen rank_c100_c20_p2=(isei<=a1) if pct>20&pct<=40
gen rank_c100_c20_p3=(isei<=a1) if pct>40&pct<=60
gen rank_c100_c20_p4=(isei<=a1) if pct>60&pct<=80
gen rank_c100_c20_p5=(isei<=a1) if pct>80&pct<=100

gen rank_c100_c40_p1=(isei>a1 & isei<=a2) if pct>0&pct<=20
gen rank_c100_c40_p2=(isei>a1 & isei<=a2) if pct>20&pct<=40
gen rank_c100_c40_p3=(isei>a1 & isei<=a2) if pct>40&pct<=60
gen rank_c100_c40_p4=(isei>a1 & isei<=a2) if pct>60&pct<=80
gen rank_c100_c40_p5=(isei>a1 & isei<=a2) if pct>80&pct<=100

gen rank_c100_c60_p1=(isei>a2 & isei<=a3) if pct>0&pct<=20
gen rank_c100_c60_p2=(isei>a2 & isei<=a3) if pct>20&pct<=40
gen rank_c100_c60_p3=(isei>a2 & isei<=a3) if pct>40&pct<=60
gen rank_c100_c60_p4=(isei>a2 & isei<=a3) if pct>60&pct<=80
gen rank_c100_c60_p5=(isei>a2 & isei<=a3) if pct>80&pct<=100

gen rank_c100_c80_p1=(isei>a3 & isei<=a4) if pct>0&pct<=20
gen rank_c100_c80_p2=(isei>a3 & isei<=a4) if pct>20&pct<=40
gen rank_c100_c80_p3=(isei>a3 & isei<=a4) if pct>40&pct<=60
gen rank_c100_c80_p4=(isei>a3 & isei<=a4) if pct>60&pct<=80
gen rank_c100_c80_p5=(isei>a3 & isei<=a4) if pct>80&pct<=100

gen rank_c100_c100_p1=(isei>a4 & isei<=a5) if pct>0&pct<=20
gen rank_c100_c100_p2=(isei>a4 & isei<=a5) if pct>20&pct<=40
gen rank_c100_c100_p3=(isei>a4 & isei<=a5) if pct>40&pct<=60
gen rank_c100_c100_p4=(isei>a4 & isei<=a5) if pct>60&pct<=80
gen rank_c100_c100_p5=(isei>a4 & isei<=a5) if pct>80&pct<=100


forval i = 1/5 {
	gen Parents_Income_Quintile`i' = .
}

forval j = 20(20)100{
forval i = 1/5 {
	replace Parents_Income_Quintile`i' = rank_c100_c`j'_p`i'
}
eststo output1_`j': qui estpost summarize ///
    Parents_Income_Quintile*
}

esttab output1* using Table3_A.csv, ///
cells("mean( fmt(3))" sd(par fmt(3))) ///
replace label
 
 

//-----------------------FIG 5 top/bottom 20% coef---------------------------
foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear

keep if pct>=80
gen ols=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei lninc_perm_pa gender urban mid east age minzu
local b1=_b[lninc_perm_pa]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[lninc_perm_pa]+tc995*_se[lninc_perm_pa]
replace lb_99=_b[lninc_perm_pa]-tc995*_se[lninc_perm_pa] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[lninc_perm_pa]+tc975*_se[lninc_perm_pa]
replace lb_95=_b[lninc_perm_pa]-tc975*_se[lninc_perm_pa]
gen rank=`num'
keep in 1
keep ols ub_99 lb_99 ub_95 lb_95 rank
save ols`num',replace
}

use ols1,clear
forvalues i=2/21 {
append using ols`i'.dta
}
save ols,replace

foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear

keep if pct<=20
gen ols1=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei lninc_perm_pa gender urban mid east age minzu
local b1=_b[lninc_perm_pa]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[lninc_perm_pa]+tc995*_se[lninc_perm_pa]
replace lb_99=_b[lninc_perm_pa]-tc995*_se[lninc_perm_pa] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[lninc_perm_pa]+tc975*_se[lninc_perm_pa]
replace lb_95=_b[lninc_perm_pa]-tc975*_se[lninc_perm_pa]
gen rank=`num'
keep in 1
keep ols1 ub_99 lb_99 ub_95 lb_95 rank
save ols1`num',replace
}

use ols11,clear
forvalues i=2/21 {
append using ols1`i'.dta
}
save ols1,replace

append using ols

twoway (connected ols rank,mlabsize(tiny))(connected ols1 rank,mlabsize(tiny)), xtitle(`"{fontface "宋体":滚动队列}"') ytitle(`"{fontface "宋体":回归系数}"')  ///
 xlabel(2 "1972-81" 3 "1973-82" 4 "1974-83" 5 "1975-84" 6 "1976-85" 7 "1977-86" 8 "1978-87" 9 "1979-88" 10 "1980-89" 11 "1981-90" 12 "1982-91" 13 "1983-92" 14 "1984-93" 15 "1985-94" 16 "1986-95" 17 "1987-96" 18 "1988-97" 19 "1989-88" 20 "1990-89" 21 "1991-00", labsize(tiny))

graph export "C:\Users\huhu\Desktop\重构code\out\fig\fig5.png", as(png) name("Graph")


//-----------------------FIG 6 isei-income---------------------------
foreach num of numlist 1/10{
use "$Out\reg_data_ushape.dta",clear

keep if pct>=(`num'-1)*10 & pct<(`num')*10
gen ols=.
gen ub_95=.
gen lb_95=.
gen ub_99=.
gen lb_99=.
reg isei lninc_perm_pa gender urban mid east age minzu
local b1=_b[lninc_perm_pa]
replace ols=`b1' 
scalar tc995 = invttail(e(df_r),0.005)
replace ub_99=_b[lninc_perm_pa]+tc995*_se[lninc_perm_pa]
replace lb_99=_b[lninc_perm_pa]-tc995*_se[lninc_perm_pa] 
scalar tc975 = invttail(e(df_r),0.025)
replace ub_95=_b[lninc_perm_pa]+tc975*_se[lninc_perm_pa]
replace lb_95=_b[lninc_perm_pa]-tc975*_se[lninc_perm_pa]
gen rank=`num'
keep in 1
keep ols ub_99 lb_99 ub_95 lb_95 rank
save ols`num',replace
}

use ols1,clear
forvalues i=2/10 {
append using ols`i'.dta
}
save ols,replace

twoway (connected ols rank,mlabsize(tiny)), xtitle(`"{fontface "宋体":父代收入百分位数}"') ytitle(`"{fontface "宋体":回归系数}"')  ///
 xlabel(1 "10" 2 "20" 3 "30" 4 "40" 5 "50" 6 "60" 7 "70" 8 "80" 9 "90" 10 "100")

graph export "C:\Users\huhu\Desktop\重构code\out\fig\fig6.png", as(png) name("Graph")