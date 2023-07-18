global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径
set scheme burdjjf

use "$Out\reg_data_ushape.dta",clear
///------------------------Cohort Threshold-------------
*blue print
foreach num of numlist 1/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}
// threshold isei , threshvar(pct) regionvars(lninc_perm_pa gender urban mid east age minzu) nthresh(1) nodots
*thresholdtest income_pa-----------------------------------------------------
foreach num of numlist 18/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)
}

foreach num of numlist 18/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa age age2{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender age age2, q(pct) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)
}

foreach num of numlist 4/6{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}

foreach num of numlist 7/9{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}

foreach num of numlist 10/12{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}


*thresholdtest eduy_f-----------------------------------------------------
use "$Out\reg_data_ushape.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_f{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)


foreach num of numlist 1/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_f{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)
}

foreach num of numlist 4/6{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_f{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)

}

foreach num of numlist 7/9{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_f{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)

}

foreach num of numlist 10/12{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_f{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)

}


*thresholdtest eduy_m-----------------------------------------------------
use "$Out\reg_data_ushape.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_m{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_f) h(1)


foreach num of numlist 1/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_m{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) h(1)

}

foreach num of numlist 4/6{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_m{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) h(1)

}

foreach num of numlist 7/9{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_m{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) h(1)

}

foreach num of numlist 10/12 {
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu eduy_m{
		drop if `var'==.
	}
	thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) trim_per(0.1) rep(5000)
	*thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(eduy_m) h(1)

}


*------------------*thresholdreg income_pa--------------------------------------
foreach num of numlist 1/21{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	*thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}

foreach num of numlist 4/6{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	*thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}

foreach num of numlist 7/9{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	*thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}

foreach num of numlist 10/12{
	use "reg_data_cohort_`num'.dta",clear
foreach var in isei lninc_perm_pa gender urban mid east age minzu{
		drop if `var'==.
	}
	*thresholdtest isei lninc_perm_pa gender urban mid east age minzu, q(pct) trim_per(0.1) rep(5000)
	thresholdreg isei lninc_perm_pa gender urban mid east age minzu, q(pct) h(1)

}



//--------------------------------TABLE 9--------------------------
foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear
gen numb=.
gen ssr=.
gen aic=.
gen bic=.
gen hqic=.
gen thres=.
gen obsl=.
gen obsh=.
threshold isei, threshvar(pct) regionvars(lninc_perm_pa gender urban mid east age minzu) nthresh(1) nodots
replace numb=e(N)
replace ssr=e(ssr)
replace aic=e(aic)
replace bic=e(bic)
replace hqic=e(hqic)
matrix thres1=e(thresholds)
replace thres=thres1[1,2]
matrix obs=e(nobs)
replace obsl=obs[1,1]
replace obsh=obs[1,2]
egen a=mean(isei) if pct<=thres
egen b=mean(isei) if pct>thres
egen low1=min(a)
egen high1=min(b)

gen rank=`num'
keep in 1
keep numb ssr aic bic hqic thres rank obsl obsh low1 high1
save ols`num',replace
}

use ols1,clear
forvalues i=2/21 {
append using ols`i'.dta
}
save ols,replace

export excel using "$Out\table9.xlsx",first(var) replace


//------------------------------------TABlE 10----------------
foreach num of numlist 1/21{
use "reg_data_cohort_`num'.dta",clear
gen high=.
gen low=.
gen highn=.
gen lown=.
threshold isei, threshvar(pct) regionvars(lninc_perm_pa gender urban mid east age minzu) nthresh(1) nodots
matrix obs=e(nobs)
replace lown=obs[1,1]
replace highn=obs[1,2]
matrix coef=e(b)
replace low=coef[1,1]
replace high=coef[1,9]

gen ols=.
gen olsn=.
reg isei lninc_perm_pa gender urban mid east age minzu
local b1=_b[lninc_perm_pa]
replace ols=`b1' 
replace olsn=e(N)

gen rank=`num'
keep in 1
keep high low highn lown rank ols olsn
save high`num',replace
}
use high1,clear
forvalues i=2/21 {
append using high`i'.dta
}
save high,replace


export excel using "$Out\table10.xlsx",first(var) replace



