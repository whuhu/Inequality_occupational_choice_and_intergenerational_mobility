global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径

set scheme cleanplots, perm

//---------------------------delta IGE-----------------------

use "$Out\reg_data_ushape.dta",clear
fre prov
bys prov: egen x=count(prov)
drop if x<=100
fre prov

g ige = .
g d=(birth_year>1980)
egen subgroup = group (d prov)
levelsof subgroup, local(levels)

xi: reg isei lninc_perm_pa age age2 age_f age_f2 if subgroup==1, r
scalar ige_group1=_b[lninc_perm_pa]

forvalues i =2(1)40 { 
xi: reg isei lninc_perm_pa age age2 age_f age_f2 if subgroup==`i', r
scalar ige_group`i'=_b[lninc_perm_pa]
}

forvalues i =1(1)40 { 
replace ige = ige_group`i' if subgroup==`i'
}

bys subgroup: su ige

****************ige by cohort, province and rural********************
g ige2 = .
egen subgroup2 = group (d prov urban)
levelsof subgroup2, local(levels)

*******log-log IGE********
xi: reg isei lninc_perm_pa age age2 age_f age_f2 if subgroup2==1, r
scalar ige_group1=_b[lninc_perm_pa]

forvalues i =2(1)80 { 
xi: reg isei lninc_perm_pa age age2 age_f age_f2 if subgroup2==`i', r
scalar ige_group`i'=_b[lninc_perm_pa]
}

forvalues i =1(1)80 { 
replace ige2 = ige_group`i' if subgroup2==`i'
}

bys subgroup2: egen nn=count(_n)
drop if nn<30
drop nn

duplicates drop prov d urban,force
br prov d urban ige2


cd "C:\Users\huhu\Desktop\"
import excel using 113.xls, first clear
drop std*
foreach i in ige grp_pc /*
*/share1 share2 share3 urbanization pov_u pov_r edu univ edu_pc pri /*
*/out_rate_1626 {

egen std_`i' = std(`i') 
}
save data_tableD3_part1, replace

*gini_agr pov_u pov_r is reported by rural & urban

reshape wide ige-std_out_rate_1626, i(provcd coast provname) j(d)

foreach i in ige grp_pc /*
*/share1 share2 share3 urbanization pov_u pov_r univ edu_pc pri /*
*/out_rate_1626 {

gen dif_std_`i' = std_`i'1 - std_`i'0

}

**exclude potential outliers**
replace dif_std_pri = . if dif_std_pri>=0.8
replace dif_std_out_rate_1626 = . if dif_std_out_rate_1626<=1.3
replace dif_std_edu_pc = . if dif_std_edu_pc>=2
replace dif_std_share2 = . if dif_std_share2<=-2
replace dif_std_grp_pc = . if dif_std_grp_pc>=3

save data_ggc_part1, replace

cd "C:\Users\huhu\Desktop\"
import excel using 114.xls, first clear

drop std* yy*
foreach i in ige_agr gini_agr pov {

egen std_`i' = std(`i') 
gen xx_`i' = std_`i' if d == 1 
bys provcd agr_hh_rural: egen yy_`i' = sum(xx_`i')

}

bys d: su gini_agr pov std_gini_agr std_pov
drop xx*
save data_tableD3_part2, replace

keep if d==0
drop d

**********************first difference****************************

foreach i in ige_agr gini_agr pov {

gen dif_std_`i' = yy_`i' - std_`i'

}

**exclude potential outliers**
replace dif_std_gini_agr = . if dif_std_gini_agr<=0|dif_std_gini_agr>=2
replace dif_std_pov = . if dif_std_pov <= -0.5

save data_ggc_part2, replace


*****************************************************************
*******************step 4. GGC by province***********************
*****************************************************************

use allpair7, clear

g ige = .
egen subgroup = group (d provcd)
levelsof subgroup, local(levels)

*prov_gini_1990_1999.dta contains gini coefficients by cohort, hukou and province
*the data are directly extracted from Chinese Statistical Yearbooks in 1990 and 1999
*details are presented in Table D2

use ige, clear
merge m:1 provcd d using prov_gini //4/10/96//
drop if _merge==2
ren _merge _m_gini
bys d: su
label var gini1 "Gini_urban"
label var gini2 "Gini_rural"

gen gini_agr = gini1 if agr_hh_rural == 0
replace gini_agr = gini2 if agr_hh_rural == 1
drop gini1 gini2 _m_gini

save allpair9, replace

**** correlates by province ****

use allpair9,clear
drop if subgroup==1|subgroup==2|subgroup==26|subgroup==27 /*obs<100*/

duplicates drop provcd coast d ige, force


merge 1:1 provcd d using correlates
*correlates.dta contains shares of primary, secondary, and tertiary industry, urbanization rate,
*share of private enterprises, per capita GRP, urban and rural poverty rates, educational expenditure per capita,
*university students per 10,000 people by cohort and province
*the data are directly extracted from China Compendium of Statutstics in 1990 and 2000
*details are presented in Table D2

keep if _merge==3 /*5 dropped*/
drop _merge 

merge 1:1 provcd d using outflow_migration /*_m=1/2/3:4/5/41*/ 
*outflow_migration.dta contains outflow migration rate for age cohorts 16-26 by cohort and province
*the data are calculated from Chinese censuses in 1990 and 2000
*details are presented in Table D2
drop if _merge==2 /*5 dropped*/
ren _merge _m_cen

replace grp_pc = grp_pc/1000
lab var grp_pc "gross regional product per capita in the unit of 1000"

lab var edu "education expenditure in the unit of 100 million yuan"
lab var edu_pc "educational expenditure per capita in the unit of yuan"
lab var pri "share of private enterprise"

order provcd coast d provname year subgroup* agr_hh_rural
drop year subgroup subgroup2 agr_hh_rural //year duplicate with d//
drop ige2-abs_mob80_agr gini_agr

foreach i in ige abs_mob abs_mob80 grp_pc /*
*/share1 share2 share3 urbanization pov_u pov_r edu univ edu_pc pri /*
*/out_rate_1626 {

egen std_`i' = std(`i') 
}


save data_tableD3_part1, replace
*gini_agr pov_u pov_r is reported by rural & urban

//--------------------------------------------------------
cd "C:\Users\huhu\Desktop\"
import excel using 113.xls, first clear

reshape wide ige-std_out_rate_1626, i(provcd coast provname) j(d)

foreach i in ige grp_pc /*
*/share1 share2 share3 urbanization pov_u pov_r univ edu_pc pri /*
*/out_rate_1626 {

gen dif_std_`i' = std_`i'1 - std_`i'0

}

**exclude potential outliers**
replace dif_std_pri = . if dif_std_pri>=0.8
replace dif_std_out_rate_1626 = . if dif_std_out_rate_1626<=1.3
replace dif_std_edu_pc = . if dif_std_edu_pc>=2
replace dif_std_share2 = . if dif_std_share2<=-2
replace dif_std_grp_pc = . if dif_std_grp_pc>=3

save data_ggc_part1, replace

***********ige and gini by rural and urban ***************

use allpair9,clear

drop if subgroup2==1|subgroup2==2|subgroup2==3|subgroup2==17| /*
*/subgroup2==19|subgroup2==21|subgroup2==23|subgroup2==25|subgroup2==27|subgroup2==37| /*
*/subgroup2==39|subgroup2==41|subgroup2==43|subgroup2==45|subgroup2==47|subgroup2==51|subgroup2==52| /*
**/subgroup2==53|subgroup2==55|subgroup2==67|subgroup2==69|subgroup2==71| /*
**/subgroup2==73|subgroup2==75|subgroup2==77|subgroup2==87|subgroup2==89| /*
**/subgroup2==93|subgroup2==95|subgroup2==97|subgroup2==4|subgroup2==5|subgroup2==7|subgroup2==11| /*
*/subgroup2==31|subgroup2==33|subgroup2==40|subgroup2==49|subgroup2==54|subgroup2==57| /*
*/subgroup2==61|subgroup2==81|subgroup2==83|subgroup2==90|subgroup2==91|subgroup2==99 
/*obs<100*/

drop if abs_mob_agr<0 //7 drop//
drop if ige2<0 //2 dropped//

save data_ggc, replace

************merge correlates data***************

merge m:1 provcd d using correlates
keep if _merge==3 /*10 dropped*/
drop _merge 

merge m:1 provcd d using outflow_migration /*_m=1/2/3:4/10/45*/ 
drop if _merge==2 /*9 dropped*/
ren _merge _m_cen

replace grp_pc = grp_pc/1000
lab var grp_pc "gross regional product per capita in the unit of 1000"
lab var edu_pc "educational expenditure per capita in the unit of yuan"
lab var pri "share of private enterprise"

ren ige2 ige_agr
ren corr2_ige corr_ige_agr
ren share1 share_p
lab var share_p "share of primary industry"
ren share2 share_s
lab var share_s "share of secondary industry"
ren share3 share_t
lab var share_t "share of third industry"
ren subgroup2 subgroup_agr

keep provcd coast d provname subgroup subgroup_agr agr_hh_rural ige_agr /*
*/corr_ige_agr abs_mob_agr abs_mob80_agr gini_agr pov_u pov_r

save allpair9_agr,replace

use allpair9_agr,clear
gen pov = pov_u if agr_hh_rural == 0
replace pov = pov_r if agr_hh_rural == 1
drop pov_u pov_r

foreach i in ige_agr corr_ige_agr abs_mob_agr abs_mob80_agr gini_agr pov {

egen std_`i' = std(`i') 
gen xx_`i' = std_`i' if d == 1 
bys provcd agr_hh_rural: egen yy_`i' = sum(xx_`i')

}

bys d: su gini_agr pov std_gini_agr std_pov
drop xx*
save data_tableD3_part2, replace

keep if d==0
drop d

**********************first difference****************************

foreach i in ige_agr corr_ige_agr abs_mob_agr abs_mob80_agr gini_agr pov {

gen dif_std_`i' = yy_`i' - std_`i'

}

**exclude potential outliers**
replace dif_std_gini_agr = . if dif_std_gini_agr<=0|dif_std_gini_agr>=2
replace dif_std_pov = . if dif_std_pov <= -0.5

save data_ggc_part2, replace













**************************Table D3**************************
cd "C:\Users\huhu\Desktop\"
import excel using 112.xls, first clear

expand 2, gen(tag)
replace ige = std_ige if tag == 1
replace abs_mob = std_abs_mob if tag == 1
replace abs_mob80 = std_abs_mob80 if tag == 1
replace share1 = std_share1 if tag == 1
replace share2 = std_share2 if tag == 1
replace share3 = std_share3 if tag == 1
replace out_rate_1626 = std_out_rate_1626 if tag == 1
replace urbanization = std_urbanization if tag == 1
replace pri = std_pri if tag == 1
replace grp_pc = std_grp_pc if tag == 1
replace edu_pc = std_edu_pc if tag == 1
replace univ = std_univ if tag == 1
replace gini_agr = std_gini_agr if tag == 1
replace pov = std_pov if tag == 1

label variable ige "Intergenerational income elasticity"
label variable abs_mob "Rank of child with parents from 20th national rank"
label variable abs_mob80 "Rank of child with parents from 80th national rank"
label variable share1 "Share of primary industry"
label variable share2 "Share of secondary industry"
label variable share3 "Share of tertiary industry"
label variable out_rate_1626 "Outflow migration rate"
label variable urbanization "Urbanization rate"
label variable pri "Share of private enterprises"
label variable grp_pc "Per capita GRP (1000 yuan)"
label variable edu_pc "Expenditure on education science culture & public health per capita"
label variable univ "University students per 10000 people"
label variable gini_agr "Gini coefficient"
label variable pov "Poverty rate"

eststo su1: qui estpost su ige abs_mob abs_mob80 gini_agr share1 share2 share3 out_rate_1626 /*
*/urbanization pri grp_pc pov edu_pc univ if d == 0 & tag == 0

eststo su2: qui estpost su ige abs_mob abs_mob80 gini_agr share1 share2 share3 out_rate_1626 /*
*/urbanization pri grp_pc pov edu_pc univ if d == 0 & tag == 1

eststo su3: qui estpost su ige abs_mob abs_mob80 gini_agr share1 share2 share3 out_rate_1626 /*
*/urbanization pri grp_pc pov edu_pc univ if d == 1 & tag == 0

eststo su4: qui estpost su ige abs_mob abs_mob80 gini_agr share1 share2 share3 out_rate_1626 /*
*/urbanization pri grp_pc pov edu_pc univ if d == 1 & tag == 1

esttab su* using Table_D3.csv, cells("mean( fmt(3))" sd(par fmt(3))) mtitles("Non-standardized" "Standardized" "Non-standardized" "Standardized") ///
noobs replace label

**************************Table D4**************************

** column (1) **
use data_ggc_part2, clear
reg dif_std_ige_agr dif_std_gini_agr, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) replace

use data_ggc_part1, clear
reg dif_std_ige dif_std_share1, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_share2 , vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_share3, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_out_rate_1626, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_urbanization, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_pri , vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

reg dif_std_ige dif_std_grp_pc , vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

use data_ggc_part2, clear
reg dif_std_ige_agr dif_std_pov, vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append

use data_ggc_part1, clear
reg dif_std_ige dif_std_edu_pc , vce (bootstrap, reps(100))
outreg2 using tableD4_ige.xls, dec(3) append


************************IGE-INCOME FIG**********
use "$Out\reg_data_ushape.dta",clear








