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

keep if birth_year>1990
forval i =1/3{
forval j =1/3{
    gen a`i'`j'=(isco_skill_f=="`i'" & isco_skill=="`j'")
	sum a`i'`j' if a`i'`j'==1
	gen b`i'`j'=r(N)
	di b`i'`j'
}
}




clear
set matsize 300
/* Read in the frequencies for tables p and q,
together with the character labels (father and son) 
for columns and rows
*/
input str4 father str4 son p q
"1. w" "1. w" 4 12
"2. f" "1. w" 47 66
"3. s" "1. w" 2  5
"1. w" "2. f" 60 102
"2. f" "2. f" 1210 1883
"3. s" "2. f" 61 99
"1. w" "3. s" 7 35
"2. f" "3. s" 200 373
"3. s" "3. s" 37 64
end

// input str4 father str4 son p q
// "1. w" "1. w" 9 7
// "2. f" "1. w" 67 46
// "3. s" "1. w" 3  4
// "1. w" "2. f" 106 56
// "2. f" "2. f" 2156 937
// "3. s" "2. f" 117 43
// "1. w" "3. s" 29 13
// "2. f" "3. s" 413 160
// "3. s" "3. s" 84 17
// end
/* Change r and s below to reflect the dimensions of
your tables
*/
gen r=3
gen s=3

quietly generate logp=log(p)
quietly generate logq=log(q)
quietly generate logpq=log(p/q)
quietly encode father, gen(F)
quietly encode son, gen(S)
quietly anova logp F S
quietly gen dpi=sqrt(e(rss)*3*r*s)
display "d(P,I)=" dpi

quietly xi: glm p i.father i.son, f(poisson)
quietly gen g2p=e(deviance)
quietly gen g2pdf=e(df)
quietly gen g2probp=1-chi2(g2pdf,g2p)
display "G2=" g2p 
display "degrees of freedom=" g2pdf 
display "probability [H0: d(P,I)=0]=" g2probp
quietly anova logq F S
quietly gen dqi=sqrt(e(rss)*3*r*s)
display "d(Q,I)=" dqi
quietly xi: glm q i.father i.son, f(poisson)
quietly gen g2q=e(deviance)
quietly gen g2qdf=e(df)
quietly gen g2probq=1-chi2(g2qdf,g2q)
display "G2=" g2q 
display "degrees of freedom=" g2qdf 
display "probability [H0: d(Q,I)=0]=" g2probq
quietly anova logpq F S
quietly gen dpq=sqrt(e(rss)*3*r*s)
display "d(P,Q)=" dpq
quietly expand 2
quietly gen pq=p if _n < r*s+1
quietly gen str1 table="p" if _n < r*s+1
quietly replace pq=q if _n > r*s
quietly replace table="q" if _n > r*s
quietly xi: glm pq i.son i.father i.table i.son*i.father i.son*i.table i.father*i.table, f(poisson)
quietly gen g2pq=e(deviance)
quietly gen g2pqdf=e(df)
quietly gen g2probpq=1-chi2(g2pqdf,g2pq)
display "G2=" g2pq 
display "degrees of freedom=" g2pqdf 
display "probability [H0: d(P,Q)=0]=" g2probpq




//----------------------------------------------------------
use  "$Out\occu_edu_mobility.dta",clear

replace edu3=2 if edu==3
replace edu3=3 if edu==4|edu==5|edu==6|edu==7|edu==8

gen edu3_f=1
replace edu3_f=2 if edu_f==3
replace edu3_f=3 if edu_f==4|edu_f==5|edu_f==6|edu_f==7|edu_f==8

gen edu3_m=1
replace edu3_m=2 if edu_m==3
replace edu3_m=3 if edu_m==4|edu_m==5|edu_m==6|edu_m==7|edu_m==8


keep if birth_year>1985
forval i =1/3{
forval j =1/3{
    gen a`i'`j'=(edu3==`i' & edu3_f==`j')
	sum a`i'`j' if a`i'`j'==1
	gen b`i'`j'=r(N)
	di b`i'`j'
}
}

clear
input str4 father str4 son p q
"1. w" "1. w" 2570 7538
"2. f" "1. w" 2063 2707
"3. s" "1. w" 1312 1703
"1. w" "2. f" 225 3790
"2. f" "2. f" 362 2553
"3. s" "2. f" 480 1305
"1. w" "3. s" 111 2608
"2. f" "3. s" 171 709
"3. s" "3. s" 427 913
end
/* Change r and s below to reflect the dimensions of
your tables
*/
gen r=3
gen s=3

quietly generate logp=log(p)
quietly generate logq=log(q)
quietly generate logpq=log(p/q)
quietly encode father, gen(F)
quietly encode son, gen(S)
quietly anova logp F S
quietly gen dpi=sqrt(e(rss)*3*r*s)
display "d(P,I)=" dpi

quietly xi: glm p i.father i.son, f(poisson)
quietly gen g2p=e(deviance)
quietly gen g2pdf=e(df)
quietly gen g2probp=1-chi2(g2pdf,g2p)
display "G2=" g2p 
display "degrees of freedom=" g2pdf 
display "probability [H0: d(P,I)=0]=" g2probp
quietly anova logq F S
quietly gen dqi=sqrt(e(rss)*3*r*s)
display "d(Q,I)=" dqi
quietly xi: glm q i.father i.son, f(poisson)
quietly gen g2q=e(deviance)
quietly gen g2qdf=e(df)
quietly gen g2probq=1-chi2(g2qdf,g2q)
display "G2=" g2q 
display "degrees of freedom=" g2qdf 
display "probability [H0: d(Q,I)=0]=" g2probq
quietly anova logpq F S
quietly gen dpq=sqrt(e(rss)*3*r*s)
display "d(P,Q)=" dpq
quietly expand 2
quietly gen pq=p if _n < r*s+1
quietly gen str1 table="p" if _n < r*s+1
quietly replace pq=q if _n > r*s
quietly replace table="q" if _n > r*s
quietly xi: glm pq i.son i.father i.table i.son*i.father i.son*i.table i.father*i.table, f(poisson)
quietly gen g2pq=e(deviance)
quietly gen g2pqdf=e(df)
quietly gen g2probpq=1-chi2(g2pqdf,g2pq)
display "G2=" g2pq 
display "degrees of freedom=" g2pqdf 
display "probability [H0: d(P,Q)=0]=" g2probpq
