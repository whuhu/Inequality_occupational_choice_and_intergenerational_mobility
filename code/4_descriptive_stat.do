global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径

set scheme cleanplots, perm

use "$Out\reg_data_ushape.dta",clear
//-----------------------*descriptive statistic------------------------------
local varlist "isei eduy eduy_f eduy_m lninc_perm_pa age gender urban minzu"
eststo rural: quietly estpost summarize ///
    `varlist' if urban == 0
eststo urban: quietly estpost summarize ///
    `varlist' if urban == 1
eststo diff: quietly estpost ttest ///
    `varlist', by(urban) unequal
esttab rural urban diff using "descriptive.rtf", ///
cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) t(pattern(0 0 1) par fmt(2))") ///
label replace


//--------------------*density plot for parental income-------------------------
use "$Out\reg_data_ushape.dta",clear
kdensity pct if eduy3== 3, generate(x1  d1)
kdensity pct if eduy3!= 3, generate(x2  d2)
kdensity pct, generate(x3  d3)

gen zero = 0

twoway (kdensity pct if eduy3== 3, color(red) lpattern(dash))(kdensity pct if eduy3!= 3, color(blue) lpattern(dot) lwidth(medthick))(kdensity pct, lpattern(solid)), ///
xtitle(`"{fontface "宋体":父代收入百分位数}"') ///
ytitle(`"{fontface "宋体":父代收入核密度分布}"') ///
legend(ring(0) pos(10) col(1) order(1 `"{fontface "宋体":高教育水平}"' 2 `"{fontface "宋体":低教育水平}"' 3 `"{fontface "宋体":全样本}"'))    
graph export "C:\Users\huhu\Desktop\重构code\out\fig\kernel.png", as(png) name("Graph") replace


//---------------------------*U shape fig-----------------------
use "$Out\reg_data_ushape.dta",clear

lpoly isei pctile if eduy3==3, bwidth(10) n(100) gen(x_5_t s_5_t) se(se_5_t) nograph
replace x_5_t=ceil(x_5_t)

gen ub_5_t=s_5_t+1.96*se_5_t
gen lb_5_t=s_5_t-1.96*se_5_t

keep  x_5_t s_5_t lb_5_t ub_5_t isei pctile eduy3
order x_5_t s_5_t lb_5_t ub_5_t

twoway (line s_5_t x_5_t)(line lb_5_t x_5_t, lpattern(dash) lc(black))(line ub_5_t x_5_t, lpattern(dash) lc(black)), title(`"{fontface "宋体":高教育水平子代}"') xtitle(`"{fontface "宋体":父代收入百分位数}"') ytitle(`"{fontface "宋体":子代职业社会地位得分}"') legend(ring(0) pos(10)) name(ushape_high_edu, replace)
graph export "C:\Users\huhu\Desktop\重构code\out\fig\ushape.png", as(png) name("ushape_high_edu") replace



	