global path "C:\Users\huhu\Desktop\重构code\"
global D    "$path\data"      //数据文件
global Out  "$path\out"       //结果：图形和表格
cd "$D"                       //设定当前工作路径
set scheme s1mono


//use cfps code to execute 1 2
//1.	2012年的个人库生成ISCO及职业威望变量
//2.	2014年的个人库生成ISCO及职业威望变量
//3.	2016年的个人库匹配将个人与其父母的pid匹配起来
/*
使用家庭关系库merge

    Result                           # of obs.
    -----------------------------------------
    not matched                        21,287
        from master                         0  (_merge==1)
        from using                     21,287  (_merge==2)

    matched                            36,892  (_merge==3)
-----------------------------------------
*/
*补齐2012民族变量


//---------------------------generate isco88 code---------------------------

use 2012,clear
//
gen isco88=.
replace isco88=1100 if job2012mn_occu==10000
replace isco88=1100 if job2012mn_occu==10100
replace isco88=1100 if job2012mn_occu==10101
replace isco88=1100 if job2012mn_occu==10200
replace isco88=1100 if job2012mn_occu==10201
replace isco88=1140 if job2012mn_occu==10202
replace isco88=1100 if job2012mn_occu==10203
replace isco88=1100 if job2012mn_occu==10204
replace isco88=1200 if job2012mn_occu==10205
replace isco88=1200 if job2012mn_occu==10209
replace isco88=1140 if job2012mn_occu==10300
replace isco88=1141 if job2012mn_occu==10301
replace isco88=1142 if job2012mn_occu==10302
replace isco88=1143 if job2012mn_occu==10303
replace isco88=1143 if job2012mn_occu==10309
replace isco88=1210 if job2012mn_occu==10400
replace isco88=1210 if job2012mn_occu==10401
replace isco88=1210 if job2012mn_occu==10402
replace isco88=1210 if job2012mn_occu==10403
replace isco88=1210 if job2012mn_occu==10409
replace isco88=1210 if job2012mn_occu==10500
replace isco88=1210 if job2012mn_occu==10501

replace isco88=1210 if job2012mn_occu==10510
replace isco88=1220 if job2012mn_occu==10520
replace isco88=1220 if job2012mn_occu==10530
replace isco88=9110 if job2012mn_occu==10549
replace isco88=9110 if job2012mn_occu==10550
replace isco88=9110 if job2012mn_occu==10551
replace isco88=1310 if job2012mn_occu==10552

replace isco88=2000 if job2012mn_occu==20000
replace isco88=2100 if job2012mn_occu==20100
replace isco88=2443 if job2012mn_occu==20101
replace isco88=2441 if job2012mn_occu==20102
replace isco88=2442 if job2012mn_occu==20103
replace isco88=2442 if job2012mn_occu==20104
replace isco88=2442 if job2012mn_occu==20105
replace isco88=2440 if job2012mn_occu==20106
replace isco88=2432 if job2012mn_occu==20107
replace isco88=2443 if job2012mn_occu==20108
replace isco88=2442 if job2012mn_occu==20109
replace isco88=2121 if job2012mn_occu==20111
replace isco88=2111 if job2012mn_occu==20112
replace isco88=2113 if job2012mn_occu==20113
replace isco88=2111 if job2012mn_occu==20114
replace isco88=2114 if job2012mn_occu==20115
replace isco88=2211 if job2012mn_occu==20116
replace isco88=2213 if job2012mn_occu==20117
replace isco88=2211 if job2012mn_occu==20118
replace isco88=2100 if job2012mn_occu==20119
replace isco88=2140 if job2012mn_occu==20200
replace isco88=2147 if job2012mn_occu==20201
replace isco88=2148 if job2012mn_occu==20202
replace isco88=2147 if job2012mn_occu==20203
replace isco88=2147 if job2012mn_occu==20204
replace isco88=2147 if job2012mn_occu==20205
replace isco88=2146 if job2012mn_occu==20206
replace isco88=2145 if job2012mn_occu==20207
replace isco88=2145 if job2012mn_occu==20208
replace isco88=2145 if job2012mn_occu==20209
replace isco88=2145 if job2012mn_occu==20211
replace isco88=2144 if job2012mn_occu==20212
replace isco88=2144 if job2012mn_occu==20213
replace isco88=2130 if job2012mn_occu==20214
replace isco88=2143 if job2012mn_occu==20215
replace isco88=2149 if job2012mn_occu==20216
replace isco88=2149 if job2012mn_occu==20217
replace isco88=2144 if job2012mn_occu==20218
replace isco88=2141 if job2012mn_occu==20219
replace isco88=2141 if job2012mn_occu==20221
replace isco88=2141 if job2012mn_occu==20222
replace isco88=2141 if job2012mn_occu==20223
replace isco88=2142 if job2012mn_occu==20224
replace isco88=2213 if job2012mn_occu==20225
replace isco88=2145 if job2012mn_occu==20226
replace isco88=2144 if job2012mn_occu==20227
replace isco88=2149 if job2012mn_occu==20228
replace isco88=2149 if job2012mn_occu==20229
replace isco88=2149 if job2012mn_occu==20231
replace isco88=2112 if job2012mn_occu==20232
replace isco88=2114 if job2012mn_occu==20233
replace isco88=2149 if job2012mn_occu==20234
replace isco88=2149 if job2012mn_occu==20235
replace isco88=2149 if job2012mn_occu==20236
replace isco88=2149 if job2012mn_occu==20237
replace isco88=2149 if job2012mn_occu==20239
replace isco88=2213 if job2012mn_occu==20300
replace isco88=2213 if job2012mn_occu==20301
replace isco88=2213 if job2012mn_occu==20302
replace isco88=2213 if job2012mn_occu==20303
replace isco88=2213 if job2012mn_occu==20304
replace isco88=2223 if job2012mn_occu==20305
replace isco88=2213 if job2012mn_occu==20306
replace isco88=2213 if job2012mn_occu==20309
replace isco88=3140 if job2012mn_occu==20400
replace isco88=3143 if job2012mn_occu==20401
replace isco88=3142 if job2012mn_occu==20402
replace isco88=3140 if job2012mn_occu==20409
replace isco88=2220 if job2012mn_occu==20500
replace isco88=2221 if job2012mn_occu==20501
replace isco88=2220 if job2012mn_occu==20502
replace isco88=2221 if job2012mn_occu==20503
replace isco88=2220 if job2012mn_occu==20504
replace isco88=2221 if job2012mn_occu==20505
replace isco88=2224 if job2012mn_occu==20506
replace isco88=3220 if job2012mn_occu==20507
replace isco88=2230 if job2012mn_occu==20508
replace isco88=3220 if job2012mn_occu==20509
replace isco88=2410 if job2012mn_occu==20600
replace isco88=2441 if job2012mn_occu==20601
replace isco88=2122 if job2012mn_occu==20602
replace isco88=2411 if job2012mn_occu==20603
replace isco88=2411 if job2012mn_occu==20604
replace isco88=3421 if job2012mn_occu==20605
replace isco88=2410 if job2012mn_occu==20609
replace isco88=3410 if job2012mn_occu==20700
replace isco88=3419 if job2012mn_occu==20701
replace isco88=3412 if job2012mn_occu==20702
replace isco88=3411 if job2012mn_occu==20703
replace isco88=3419 if job2012mn_occu==20709
replace isco88=2420 if job2012mn_occu==20800
replace isco88=2422 if job2012mn_occu==20801
replace isco88=2421 if job2012mn_occu==20802
replace isco88=2421 if job2012mn_occu==20803
replace isco88=2429 if job2012mn_occu==20804
replace isco88=2429 if job2012mn_occu==20805
replace isco88=2429 if job2012mn_occu==20806
replace isco88=2429 if job2012mn_occu==20809
replace isco88=2300 if job2012mn_occu==20900
replace isco88=2310 if job2012mn_occu==20901
replace isco88=2320 if job2012mn_occu==20902
replace isco88=2320 if job2012mn_occu==20903
replace isco88=2331 if job2012mn_occu==20904
replace isco88=2332 if job2012mn_occu==20905
replace isco88=2340 if job2012mn_occu==20906
replace isco88=2359 if job2012mn_occu==20909
replace isco88=2450 if job2012mn_occu==21000
replace isco88=2451 if job2012mn_occu==21001
replace isco88=2453 if job2012mn_occu==21002
replace isco88=2455 if job2012mn_occu==21003
replace isco88=2453 if job2012mn_occu==21004
replace isco88=2455 if job2012mn_occu==21005
replace isco88=2452 if job2012mn_occu==21006
replace isco88=2452 if job2012mn_occu==21007
replace isco88=2450 if job2012mn_occu==21009
replace isco88=3475 if job2012mn_occu==21100
replace isco88=3475 if job2012mn_occu==21101
replace isco88=2450 if job2012mn_occu==21200
replace isco88=2451 if job2012mn_occu==21201
replace isco88=2451 if job2012mn_occu==21202
replace isco88=4143 if job2012mn_occu==21203
replace isco88=3472 if job2012mn_occu==21204
replace isco88=2444 if job2012mn_occu==21205
replace isco88=2431 if job2012mn_occu==21206
replace isco88=2430 if job2012mn_occu==21207
replace isco88=3470 if job2012mn_occu==21209
replace isco88=2460 if job2012mn_occu==21300
replace isco88=2460 if job2012mn_occu==21301
replace isco88=2400 if job2012mn_occu==21900
replace isco88=2400 if job2012mn_occu==21901
replace isco88=4000 if job2012mn_occu==30000
replace isco88=4110 if job2012mn_occu==30100
replace isco88=3430 if job2012mn_occu==30101
replace isco88=4110 if job2012mn_occu==30102
replace isco88=4110 if job2012mn_occu==30109
replace isco88=5160 if job2012mn_occu==30200
replace isco88=5162 if job2012mn_occu==30201
replace isco88=5169 if job2012mn_occu==30202
replace isco88=5161 if job2012mn_occu==30203
replace isco88=5169 if job2012mn_occu==30209
replace isco88=4210 if job2012mn_occu==30300
replace isco88=4142 if job2012mn_occu==30301
replace isco88=4210 if job2012mn_occu==30302
replace isco88=4210 if job2012mn_occu==30303
replace isco88=4210 if job2012mn_occu==30309
replace isco88=4190 if job2012mn_occu==30900
replace isco88=4190 if job2012mn_occu==30901
replace isco88=5000 if job2012mn_occu==40000
replace isco88=5200 if job2012mn_occu==40100
replace isco88=5220 if job2012mn_occu==40101
replace isco88=5220 if job2012mn_occu==40102
replace isco88=3416 if job2012mn_occu==40103
replace isco88=3417 if job2012mn_occu==40104
replace isco88=9161 if job2012mn_occu==40105
replace isco88=3439 if job2012mn_occu==40106
replace isco88=3439 if job2012mn_occu==40107
replace isco88=5200 if job2012mn_occu==40109
replace isco88=4130 if job2012mn_occu==40200
replace isco88=4131 if job2012mn_occu==40201
replace isco88=4133 if job2012mn_occu==40202
replace isco88=4130 if job2012mn_occu==40209
replace isco88=5120 if job2012mn_occu==40300
replace isco88=5122 if job2012mn_occu==40301
replace isco88=5122 if job2012mn_occu==40302
replace isco88=5123 if job2012mn_occu==40303
replace isco88=5120 if job2012mn_occu==40304
replace isco88=5123 if job2012mn_occu==40305
replace isco88=5120 if job2012mn_occu==40309
replace isco88=5132 if job2012mn_occu==40400
replace isco88=5132 if job2012mn_occu==40401
replace isco88=5111 if job2012mn_occu==40402
replace isco88=5132 if job2012mn_occu==40403
replace isco88=5139 if job2012mn_occu==40409
replace isco88=5110 if job2012mn_occu==40500
replace isco88=5110 if job2012mn_occu==40501
replace isco88=5110 if job2012mn_occu==40502
replace isco88=5110 if job2012mn_occu==40503
replace isco88=5110 if job2012mn_occu==40504
replace isco88=5110 if job2012mn_occu==40509
replace isco88=5132 if job2012mn_occu==40600
replace isco88=5132 if job2012mn_occu==40601
replace isco88=5132 if job2012mn_occu==40700
replace isco88=5132 if job2012mn_occu==40701
replace isco88=5121 if job2012mn_occu==40702
replace isco88=5121 if job2012mn_occu==40703
replace isco88=5141 if job2012mn_occu==40704
replace isco88=3131 if job2012mn_occu==40705
replace isco88=3224 if job2012mn_occu==40706
replace isco88=5149 if job2012mn_occu==40707
replace isco88=5149 if job2012mn_occu==40708
replace isco88=7300 if job2012mn_occu==40709
replace isco88=7241 if job2012mn_occu==40711
replace isco88=7241 if job2012mn_occu==40712
replace isco88=5130 if job2012mn_occu==40713
replace isco88=9162 if job2012mn_occu==40714
replace isco88=5143 if job2012mn_occu==40715
replace isco88=5132 if job2012mn_occu==40719
replace isco88=5000 if job2012mn_occu==40900
replace isco88=5000 if job2012mn_occu==40901
replace isco88=6100 if job2012mn_occu==50000
replace isco88=6110 if job2012mn_occu==50100
replace isco88=6111 if job2012mn_occu==50101
replace isco88=3212 if job2012mn_occu==50102
replace isco88=6113 if job2012mn_occu==50103
replace isco88=6113 if job2012mn_occu==50104
replace isco88=6113 if job2012mn_occu==50105
replace isco88=7410 if job2012mn_occu==50106
replace isco88=6114 if job2012mn_occu==50109
replace isco88=6140 if job2012mn_occu==50200
replace isco88=6141 if job2012mn_occu==50201
replace isco88=6141 if job2012mn_occu==50202
replace isco88=6130 if job2012mn_occu==50203
replace isco88=6141 if job2012mn_occu==50204
replace isco88=6130 if job2012mn_occu==50209
replace isco88=6120 if job2012mn_occu==50300
replace isco88=6121 if job2012mn_occu==50301
replace isco88=6122 if job2012mn_occu==50302
replace isco88=6123 if job2012mn_occu==50303
replace isco88=6129 if job2012mn_occu==50304
replace isco88=3227 if job2012mn_occu==50305
replace isco88=6111 if job2012mn_occu==50306
replace isco88=6129 if job2012mn_occu==50309
replace isco88=6150 if job2012mn_occu==50400
replace isco88=6151 if job2012mn_occu==50401
replace isco88=6152 if job2012mn_occu==50402
replace isco88=8271 if job2012mn_occu==50403
replace isco88=6150 if job2012mn_occu==50409
replace isco88=9312 if job2012mn_occu==50500
replace isco88=9312 if job2012mn_occu==50501
replace isco88=9312 if job2012mn_occu==50502
replace isco88=9312 if job2012mn_occu==50503
replace isco88=9312 if job2012mn_occu==50504
replace isco88=9312 if job2012mn_occu==50509
replace isco88=6100 if job2012mn_occu==50900
replace isco88=8331 if job2012mn_occu==50901
replace isco88=8163 if job2012mn_occu==50902
replace isco88=7000 if job2012mn_occu==60000
replace isco88=7110 if job2012mn_occu==60100
replace isco88=3117 if job2012mn_occu==60101
replace isco88=3117 if job2012mn_occu==60102
replace isco88=7111 if job2012mn_occu==60103
replace isco88=8112 if job2012mn_occu==60104
replace isco88=7111 if job2012mn_occu==60105
replace isco88=7111 if job2012mn_occu==60106
replace isco88=7111 if job2012mn_occu==60107
replace isco88=7100 if job2012mn_occu==60109
replace isco88=8120 if job2012mn_occu==60200
replace isco88=8121 if job2012mn_occu==60201
replace isco88=8121 if job2012mn_occu==60202
replace isco88=8121 if job2012mn_occu==60203
replace isco88=8121 if job2012mn_occu==60204
replace isco88=8121 if job2012mn_occu==60205
replace isco88=8121 if job2012mn_occu==60206
replace isco88=8131 if job2012mn_occu==60207
replace isco88=8122 if job2012mn_occu==60208
replace isco88=8122 if job2012mn_occu==60209
replace isco88=8120 if job2012mn_occu==60211
replace isco88=8120 if job2012mn_occu==60212
replace isco88=8120 if job2012mn_occu==60219
replace isco88=8150 if job2012mn_occu==60300
replace isco88=8150 if job2012mn_occu==60301
replace isco88=8155 if job2012mn_occu==60302
replace isco88=8150 if job2012mn_occu==60303
replace isco88=8150 if job2012mn_occu==60304
replace isco88=8150 if job2012mn_occu==60305
replace isco88=8150 if job2012mn_occu==60306
replace isco88=8150 if job2012mn_occu==60307
replace isco88=8150 if job2012mn_occu==60308
replace isco88=8150 if job2012mn_occu==60309
replace isco88=8150 if job2012mn_occu==60311
replace isco88=8220 if job2012mn_occu==60312
replace isco88=8220 if job2012mn_occu==60313
replace isco88=8222 if job2012mn_occu==60314
replace isco88=8220 if job2012mn_occu==60315
replace isco88=8220 if job2012mn_occu==60316
replace isco88=8229 if job2012mn_occu==60317
replace isco88=8229 if job2012mn_occu==60319
replace isco88=7210 if job2012mn_occu==60400
replace isco88=7210 if job2012mn_occu==60401
replace isco88=7210 if job2012mn_occu==60402
replace isco88=7210 if job2012mn_occu==60403
replace isco88=7213 if job2012mn_occu==60404
replace isco88=7224 if job2012mn_occu==60405
replace isco88=7224 if job2012mn_occu==60406
replace isco88=7210 if job2012mn_occu==60407
replace isco88=7210 if job2012mn_occu==60409
replace isco88=8280 if job2012mn_occu==60500
replace isco88=8280 if job2012mn_occu==60501
replace isco88=8281 if job2012mn_occu==60502
replace isco88=8282 if job2012mn_occu==60503
replace isco88=8283 if job2012mn_occu==60504
replace isco88=8283 if job2012mn_occu==60505
replace isco88=8283 if job2012mn_occu==60506
replace isco88=8281 if job2012mn_occu==60507
replace isco88=8280 if job2012mn_occu==60508
replace isco88=8280 if job2012mn_occu==60509
replace isco88=8282 if job2012mn_occu==60511
replace isco88=8281 if job2012mn_occu==60512
replace isco88=8281 if job2012mn_occu==60513
replace isco88=8280 if job2012mn_occu==60514
replace isco88=8290 if job2012mn_occu==60515
replace isco88=8290 if job2012mn_occu==60516
replace isco88=8290 if job2012mn_occu==60517
replace isco88=8290 if job2012mn_occu==60518
replace isco88=7230 if job2012mn_occu==60519
replace isco88=7230 if job2012mn_occu==60521
replace isco88=3119 if job2012mn_occu==60522
replace isco88=7232 if job2012mn_occu==60523
replace isco88=7232 if job2012mn_occu==60524
replace isco88=3119 if job2012mn_occu==60525
replace isco88=3119 if job2012mn_occu==60526
replace isco88=8290 if job2012mn_occu==60529
replace isco88=7230 if job2012mn_occu==60600
replace isco88=7230 if job2012mn_occu==60601
replace isco88=7243 if job2012mn_occu==60602
replace isco88=7232 if job2012mn_occu==60603
replace isco88=7230 if job2012mn_occu==60609
replace isco88=7240 if job2012mn_occu==60700
replace isco88=7241 if job2012mn_occu==60701
replace isco88=8161 if job2012mn_occu==60702
replace isco88=7241 if job2012mn_occu==60703
replace isco88=7241 if job2012mn_occu==60704
replace isco88=7245 if job2012mn_occu==60705
replace isco88=7240 if job2012mn_occu==60706
replace isco88=7240 if job2012mn_occu==60709
replace isco88=7240 if job2012mn_occu==60800
replace isco88=7240 if job2012mn_occu==60801
replace isco88=7240 if job2012mn_occu==60802
replace isco88=7240 if job2012mn_occu==60803
replace isco88=7240 if job2012mn_occu==60804
replace isco88=7243 if job2012mn_occu==60805
replace isco88=7240 if job2012mn_occu==60809
replace isco88=8230 if job2012mn_occu==60900
replace isco88=8231 if job2012mn_occu==60901
replace isco88=8232 if job2012mn_occu==60902
replace isco88=8230 if job2012mn_occu==60909
replace isco88=7430 if job2012mn_occu==61000
replace isco88=7431 if job2012mn_occu==61001
replace isco88=7432 if job2012mn_occu==61002
replace isco88=7430 if job2012mn_occu==61003
replace isco88=7432 if job2012mn_occu==61004
replace isco88=7432 if job2012mn_occu==61005
replace isco88=7432 if job2012mn_occu==61009
replace isco88=7430 if job2012mn_occu==61100
replace isco88=7433 if job2012mn_occu==61101
replace isco88=7433 if job2012mn_occu==61102
replace isco88=7434 if job2012mn_occu==61103
replace isco88=7436 if job2012mn_occu==61104
replace isco88=7430 if job2012mn_occu==61109
replace isco88=7410 if job2012mn_occu==61200
replace isco88=7410 if job2012mn_occu==61201
replace isco88=7412 if job2012mn_occu==61202
replace isco88=7413 if job2012mn_occu==61203
replace isco88=7410 if job2012mn_occu==61204
replace isco88=7410 if job2012mn_occu==61205
replace isco88=7410 if job2012mn_occu==61206
replace isco88=7410 if job2012mn_occu==61207
replace isco88=7410 if job2012mn_occu==61208
replace isco88=7410 if job2012mn_occu==61209
replace isco88=7416 if job2012mn_occu==61300
replace isco88=7416 if job2012mn_occu==61301
replace isco88=7416 if job2012mn_occu==61302
replace isco88=7416 if job2012mn_occu==61303
replace isco88=7416 if job2012mn_occu==61309
replace isco88=8221 if job2012mn_occu==61400
replace isco88=8221 if job2012mn_occu==61401
replace isco88=8221 if job2012mn_occu==61402
replace isco88=2224 if job2012mn_occu==61403
replace isco88=2224 if job2012mn_occu==61404
replace isco88=8221 if job2012mn_occu==61409
replace isco88=8140 if job2012mn_occu==61500
replace isco88=8141 if job2012mn_occu==61501
replace isco88=8141 if job2012mn_occu==61502
replace isco88=8240 if job2012mn_occu==61503
replace isco88=8142 if job2012mn_occu==61504
replace isco88=8143 if job2012mn_occu==61505
replace isco88=8253 if job2012mn_occu==61506
replace isco88=8140 if job2012mn_occu==61509
replace isco88=8290 if job2012mn_occu==61600
replace isco88=8212 if job2012mn_occu==61601
replace isco88=8212 if job2012mn_occu==61602
replace isco88=8290 if job2012mn_occu==61603
replace isco88=8290 if job2012mn_occu==61604
replace isco88=8290 if job2012mn_occu==61605
replace isco88=8290 if job2012mn_occu==61606
replace isco88=8290 if job2012mn_occu==61607
replace isco88=8290 if job2012mn_occu==61609
replace isco88=7320 if job2012mn_occu==61700
replace isco88=7321 if job2012mn_occu==61701
replace isco88=7321 if job2012mn_occu==61702
replace isco88=7322 if job2012mn_occu==61703
replace isco88=7324 if job2012mn_occu==61704
replace isco88=7324 if job2012mn_occu==61705
replace isco88=7320 if job2012mn_occu==61709
replace isco88=3130 if job2012mn_occu==61800
replace isco88=3130 if job2012mn_occu==61801
replace isco88=3131 if job2012mn_occu==61802
replace isco88=3132 if job2012mn_occu==61803
replace isco88=3132 if job2012mn_occu==61804
replace isco88=3110 if job2012mn_occu==61805
replace isco88=3130 if job2012mn_occu==61809
replace isco88=7340 if job2012mn_occu==61900
replace isco88=7340 if job2012mn_occu==61901
replace isco88=7340 if job2012mn_occu==61902
replace isco88=7340 if job2012mn_occu==61903
replace isco88=7340 if job2012mn_occu==61909
replace isco88=7300 if job2012mn_occu==62000
replace isco88=7313 if job2012mn_occu==62001
replace isco88=7332 if job2012mn_occu==62002
replace isco88=7330 if job2012mn_occu==62003
replace isco88=7331 if job2012mn_occu==62004
replace isco88=7436 if job2012mn_occu==62005
replace isco88=7313 if job2012mn_occu==62006
replace isco88=7330 if job2012mn_occu==62007
replace isco88=7300 if job2012mn_occu==62008
replace isco88=7300 if job2012mn_occu==62009
replace isco88=7400 if job2012mn_occu==62100
replace isco88=7400 if job2012mn_occu==62101
replace isco88=7400 if job2012mn_occu==62102
replace isco88=7312 if job2012mn_occu==62103
replace isco88=7400 if job2012mn_occu==62109
replace isco88=7120 if job2012mn_occu==62200
replace isco88=7121 if job2012mn_occu==62201
replace isco88=7122 if job2012mn_occu==62202
replace isco88=7123 if job2012mn_occu==62203
replace isco88=7129 if job2012mn_occu==62204
replace isco88=7130 if job2012mn_occu==62205
replace isco88=7134 if job2012mn_occu==62206
replace isco88=7141 if job2012mn_occu==62207
replace isco88=7130 if job2012mn_occu==62208
replace isco88=9312 if job2012mn_occu==62209
replace isco88=7230 if job2012mn_occu==62211
replace isco88=7129 if job2012mn_occu==62219
replace isco88=8300 if job2012mn_occu==62300
replace isco88=8320 if job2012mn_occu==62301
replace isco88=8310 if job2012mn_occu==62302
replace isco88=8320 if job2012mn_occu==62303
replace isco88=8340 if job2012mn_occu==62304
replace isco88=8334 if job2012mn_occu==62305
replace isco88=8300 if job2012mn_occu==62309
replace isco88=3150 if job2012mn_occu==62400
replace isco88=3150 if job2012mn_occu==62401
replace isco88=3150 if job2012mn_occu==62402
replace isco88=9161 if job2012mn_occu==62403
replace isco88=3150 if job2012mn_occu==62409
replace isco88=3150 if job2012mn_occu==62500
replace isco88=3150 if job2012mn_occu==62501
replace isco88=3150 if job2012mn_occu==62502
replace isco88=3150 if job2012mn_occu==62503
replace isco88=3110 if job2012mn_occu==62504
replace isco88=3150 if job2012mn_occu==62509
replace isco88=8000 if job2012mn_occu==62900
replace isco88=9322 if job2012mn_occu==62901
replace isco88=8160 if job2012mn_occu==62902
replace isco88=9000 if job2012mn_occu==62903

replace isco88=.a if job2012mn_occu==70000
replace isco88=.b if job2012mn_occu==80000
replace isco88=.c if job2012mn_occu==90000

replace isco88=.x if job2012mn_occu==-1
replace isco88=.y if job2012mn_occu==-2
replace isco88=.z if job2012mn_occu==-8

replace isco88=.w if job2012mn_occu==-7
replace isco88=.r if job2012mn_occu==-9







//-----------------------------gen isei code----------------------------
	quietly gen isei=.
	quietly replace isei=55 if (isco88 == 1000)
	quietly replace isei=70 if (isco88 == 1100)
	quietly replace isei=77 if (isco88 == 1110)
	quietly replace isei=77 if (isco88 == 1120)
	quietly replace isei=66 if (isco88 == 1130)
	quietly replace isei=58 if (isco88 == 1140)
	quietly replace isei=58 if (isco88 == 1141)
	quietly replace isei=58 if (isco88 == 1142)
	quietly replace isei=58 if (isco88 == 1143)
	quietly replace isei=68 if (isco88 == 1200)
	quietly replace isei=70 if (isco88 == 1210)
	quietly replace isei=67 if (isco88 == 1220)
	quietly replace isei=67 if (isco88 == 1221)
	quietly replace isei=67 if (isco88 == 1222)
	quietly replace isei=67 if (isco88 == 1223)
	quietly replace isei=59 if (isco88 == 1224)
	quietly replace isei=59 if (isco88 == 1225)
	quietly replace isei=59 if (isco88 == 1226)
	quietly replace isei=87 if (isco88 == 1227)
	quietly replace isei=59 if (isco88 == 1228)
	quietly replace isei=67 if (isco88 == 1229)
	quietly replace isei=61 if (isco88 == 1230)
	quietly replace isei=69 if (isco88 == 1231)
	quietly replace isei=69 if (isco88 == 1232)
	quietly replace isei=56 if (isco88 == 1233)
	quietly replace isei=69 if (isco88 == 1234)
	quietly replace isei=69 if (isco88 == 1235)
	quietly replace isei=69 if (isco88 == 1236)
	quietly replace isei=69 if (isco88 == 1237)
	quietly replace isei=69 if (isco88 == 1239)
	quietly replace isei=58 if (isco88 == 1240)
	quietly replace isei=64 if (isco88 == 1250)
	quietly replace isei=70 if (isco88 == 1251)
	quietly replace isei=60 if (isco88 == 1252)
	quietly replace isei=51 if (isco88 == 1300)
	quietly replace isei=51 if (isco88 == 1310)
	quietly replace isei=43 if (isco88 == 1311)
	quietly replace isei=56 if (isco88 == 1312)
	quietly replace isei=51 if (isco88 == 1313)
	quietly replace isei=49 if (isco88 == 1314)
	quietly replace isei=44 if (isco88 == 1315)
	quietly replace isei=51 if (isco88 == 1316)
	quietly replace isei=51 if (isco88 == 1317)
	quietly replace isei=51 if (isco88 == 1318)
	quietly replace isei=51 if (isco88 == 1319)
	quietly replace isei=70 if (isco88 == 2000)
	quietly replace isei=69 if (isco88 == 2100)
	quietly replace isei=74 if (isco88 == 2110)
	quietly replace isei=74 if (isco88 == 2111)
	quietly replace isei=74 if (isco88 == 2112)
	quietly replace isei=74 if (isco88 == 2113)
	quietly replace isei=74 if (isco88 == 2114)
	quietly replace isei=71 if (isco88 == 2120)
	quietly replace isei=71 if (isco88 == 2121)
	quietly replace isei=71 if (isco88 == 2122)
	quietly replace isei=71 if (isco88 == 2130)
	quietly replace isei=71 if (isco88 == 2131)
	quietly replace isei=71 if (isco88 == 2132)
	quietly replace isei=71 if (isco88 == 2139)
	quietly replace isei=73 if (isco88 == 2140)
	quietly replace isei=69 if (isco88 == 2141)
	quietly replace isei=69 if (isco88 == 2142)
	quietly replace isei=68 if (isco88 == 2143)
	quietly replace isei=68 if (isco88 == 2144)
	quietly replace isei=67 if (isco88 == 2145)
	quietly replace isei=71 if (isco88 == 2146)
	quietly replace isei=67 if (isco88 == 2147)
	quietly replace isei=56 if (isco88 == 2148)
	quietly replace isei=69 if (isco88 == 2149)
	quietly replace isei=80 if (isco88 == 2200)
	quietly replace isei=78 if (isco88 == 2210)
	quietly replace isei=77 if (isco88 == 2211)
	quietly replace isei=77 if (isco88 == 2212)
	quietly replace isei=79 if (isco88 == 2213)
	quietly replace isei=85 if (isco88 == 2220)
	quietly replace isei=88 if (isco88 == 2221)
	quietly replace isei=85 if (isco88 == 2222)
	quietly replace isei=83 if (isco88 == 2223)
	quietly replace isei=74 if (isco88 == 2224)
	quietly replace isei=85 if (isco88 == 2229)
	quietly replace isei=43 if (isco88 == 2230)
	quietly replace isei=69 if (isco88 == 2300)
	quietly replace isei=77 if (isco88 == 2310)
	quietly replace isei=69 if (isco88 == 2320)
	quietly replace isei=70 if (isco88 == 2321)
	quietly replace isei=66 if (isco88 == 2322)
	quietly replace isei=66 if (isco88 == 2330)
	quietly replace isei=66 if (isco88 == 2331)
	quietly replace isei=43 if (isco88 == 2332)
	quietly replace isei=66 if (isco88 == 2340)
	quietly replace isei=66 if (isco88 == 2350)
	quietly replace isei=70 if (isco88 == 2351)
	quietly replace isei=70 if (isco88 == 2352)
	quietly replace isei=65 if (isco88 == 2359)
	quietly replace isei=68 if (isco88 == 2400)
	quietly replace isei=69 if (isco88 == 2410)
	quietly replace isei=69 if (isco88 == 2411)
	quietly replace isei=69 if (isco88 == 2412)
	quietly replace isei=69 if (isco88 == 2419)
	quietly replace isei=85 if (isco88 == 2420)
	quietly replace isei=85 if (isco88 == 2421)
	quietly replace isei=90 if (isco88 == 2422)
	quietly replace isei=82 if (isco88 == 2429)
	quietly replace isei=65 if (isco88 == 2430)
	quietly replace isei=65 if (isco88 == 2431)
	quietly replace isei=65 if (isco88 == 2432)
	quietly replace isei=65 if (isco88 == 2440)
	quietly replace isei=78 if (isco88 == 2441)
	quietly replace isei=71 if (isco88 == 2442)
	quietly replace isei=71 if (isco88 == 2443)
	quietly replace isei=65 if (isco88 == 2444)
	quietly replace isei=71 if (isco88 == 2445)
	quietly replace isei=51 if (isco88 == 2446)
	quietly replace isei=61 if (isco88 == 2450)
	quietly replace isei=65 if (isco88 == 2451)
	quietly replace isei=54 if (isco88 == 2452)
	quietly replace isei=64 if (isco88 == 2453)
	quietly replace isei=64 if (isco88 == 2454)
	quietly replace isei=64 if (isco88 == 2455)
	quietly replace isei=53 if (isco88 == 2460)
	quietly replace isei=54 if (isco88 == 3000)
	quietly replace isei=50 if (isco88 == 3100)
	quietly replace isei=49 if (isco88 == 3110)
	quietly replace isei=45 if (isco88 == 3111)
	quietly replace isei=45 if (isco88 == 3112)
	quietly replace isei=46 if (isco88 == 3113)
	quietly replace isei=46 if (isco88 == 3114)
	quietly replace isei=54 if (isco88 == 3115)
	quietly replace isei=54 if (isco88 == 3116)
	quietly replace isei=54 if (isco88 == 3117)
	quietly replace isei=51 if (isco88 == 3118)
	quietly replace isei=53 if (isco88 == 3119)
	quietly replace isei=52 if (isco88 == 3120)
	quietly replace isei=52 if (isco88 == 3121)
	quietly replace isei=52 if (isco88 == 3122)
	quietly replace isei=52 if (isco88 == 3123)
	quietly replace isei=52 if (isco88 == 3130)
	quietly replace isei=48 if (isco88 == 3131)
	quietly replace isei=57 if (isco88 == 3132)
	quietly replace isei=57 if (isco88 == 3133)
	quietly replace isei=52 if (isco88 == 3139)
	quietly replace isei=57 if (isco88 == 3140)
	quietly replace isei=52 if (isco88 == 3141)
	quietly replace isei=52 if (isco88 == 3142)
	quietly replace isei=69 if (isco88 == 3143)
	quietly replace isei=69 if (isco88 == 3144)
	quietly replace isei=50 if (isco88 == 3145)
	quietly replace isei=50 if (isco88 == 3150)
	quietly replace isei=50 if (isco88 == 3151)
	quietly replace isei=50 if (isco88 == 3152)
	quietly replace isei=48 if (isco88 == 3200)
	quietly replace isei=50 if (isco88 == 3210)
	quietly replace isei=50 if (isco88 == 3211)
	quietly replace isei=50 if (isco88 == 3212)
	quietly replace isei=50 if (isco88 == 3213)
	quietly replace isei=55 if (isco88 == 3220)
	quietly replace isei=51 if (isco88 == 3221)
	quietly replace isei=51 if (isco88 == 3222)
	quietly replace isei=51 if (isco88 == 3223)
	quietly replace isei=60 if (isco88 == 3224)
	quietly replace isei=51 if (isco88 == 3225)
	quietly replace isei=60 if (isco88 == 3226)
	quietly replace isei=51 if (isco88 == 3227)
	quietly replace isei=51 if (isco88 == 3228)
	quietly replace isei=51 if (isco88 == 3229)
	quietly replace isei=38 if (isco88 == 3230)
	quietly replace isei=38 if (isco88 == 3231)
	quietly replace isei=38 if (isco88 == 3232)
	quietly replace isei=49 if (isco88 == 3240)
	quietly replace isei=51 if (isco88 == 3241)
	quietly replace isei=38 if (isco88 == 3242)
	quietly replace isei=38 if (isco88 == 3300)
	quietly replace isei=38 if (isco88 == 3310)
	quietly replace isei=38 if (isco88 == 3320)
	quietly replace isei=38 if (isco88 == 3330)
	quietly replace isei=38 if (isco88 == 3340)
	quietly replace isei=55 if (isco88 == 3400)
	quietly replace isei=55 if (isco88 == 3410)
	quietly replace isei=61 if (isco88 == 3411)
	quietly replace isei=54 if (isco88 == 3412)
	quietly replace isei=59 if (isco88 == 3413)
	quietly replace isei=56 if (isco88 == 3414)
	quietly replace isei=56 if (isco88 == 3415)
	quietly replace isei=50 if (isco88 == 3416)
	quietly replace isei=56 if (isco88 == 3417)
	quietly replace isei=55 if (isco88 == 3419)
	quietly replace isei=55 if (isco88 == 3420)
	quietly replace isei=55 if (isco88 == 3421)
	quietly replace isei=55 if (isco88 == 3422)
	quietly replace isei=55 if (isco88 == 3423)
	quietly replace isei=55 if (isco88 == 3429)
	quietly replace isei=54 if (isco88 == 3430)
	quietly replace isei=54 if (isco88 == 3431)
	quietly replace isei=59 if (isco88 == 3432)
	quietly replace isei=51 if (isco88 == 3433)
	quietly replace isei=61 if (isco88 == 3434)
	quietly replace isei=54 if (isco88 == 3439)
	quietly replace isei=56 if (isco88 == 3440)
	quietly replace isei=56 if (isco88 == 3441)
	quietly replace isei=57 if (isco88 == 3442)
	quietly replace isei=56 if (isco88 == 3443)
	quietly replace isei=46 if (isco88 == 3444)
	quietly replace isei=56 if (isco88 == 3449)
	quietly replace isei=56 if (isco88 == 3450)
	quietly replace isei=55 if (isco88 == 3451)
	quietly replace isei=56 if (isco88 == 3452)
	quietly replace isei=43 if (isco88 == 3460)
	quietly replace isei=52 if (isco88 == 3470)
	quietly replace isei=53 if (isco88 == 3471)
	quietly replace isei=64 if (isco88 == 3472)
	quietly replace isei=50 if (isco88 == 3473)
	quietly replace isei=50 if (isco88 == 3474)
	quietly replace isei=54 if (isco88 == 3475)
	quietly replace isei=38 if (isco88 == 3480)
	quietly replace isei=45 if (isco88 == 4000)
	quietly replace isei=45 if (isco88 == 4100)
	quietly replace isei=51 if (isco88 == 4110)
	quietly replace isei=51 if (isco88 == 4111)
	quietly replace isei=50 if (isco88 == 4112)
	quietly replace isei=50 if (isco88 == 4113)
	quietly replace isei=51 if (isco88 == 4114)
	quietly replace isei=53 if (isco88 == 4115)
	quietly replace isei=51 if (isco88 == 4120)
	quietly replace isei=51 if (isco88 == 4121)
	quietly replace isei=51 if (isco88 == 4122)
	quietly replace isei=36 if (isco88 == 4130)
	quietly replace isei=32 if (isco88 == 4131)
	quietly replace isei=43 if (isco88 == 4132)
	quietly replace isei=45 if (isco88 == 4133)
	quietly replace isei=39 if (isco88 == 4140)
	quietly replace isei=39 if (isco88 == 4141)
	quietly replace isei=39 if (isco88 == 4142)
	quietly replace isei=39 if (isco88 == 4143)
	quietly replace isei=39 if (isco88 == 4144)
	quietly replace isei=39 if (isco88 == 4190)
	quietly replace isei=49 if (isco88 == 4200)
	quietly replace isei=48 if (isco88 == 4210)
	quietly replace isei=53 if (isco88 == 4211)
	quietly replace isei=46 if (isco88 == 4212)
	quietly replace isei=40 if (isco88 == 4213)
	quietly replace isei=40 if (isco88 == 4214)
	quietly replace isei=40 if (isco88 == 4215)
	quietly replace isei=52 if (isco88 == 4220)
	quietly replace isei=52 if (isco88 == 4221)
	quietly replace isei=52 if (isco88 == 4222)
	quietly replace isei=52 if (isco88 == 4223)
	quietly replace isei=40 if (isco88 == 5000)
	quietly replace isei=38 if (isco88 == 5100)
	quietly replace isei=34 if (isco88 == 5110)
	quietly replace isei=34 if (isco88 == 5111)
	quietly replace isei=34 if (isco88 == 5112)
	quietly replace isei=34 if (isco88 == 5113)
	quietly replace isei=32 if (isco88 == 5120)
	quietly replace isei=30 if (isco88 == 5121)
	quietly replace isei=30 if (isco88 == 5122)
	quietly replace isei=34 if (isco88 == 5123)
	quietly replace isei=25 if (isco88 == 5130)
	quietly replace isei=25 if (isco88 == 5131)
	quietly replace isei=25 if (isco88 == 5132)
	quietly replace isei=25 if (isco88 == 5133)
	quietly replace isei=25 if (isco88 == 5139)
	quietly replace isei=30 if (isco88 == 5140)
	quietly replace isei=29 if (isco88 == 5141)
	quietly replace isei=19 if (isco88 == 5142)
	quietly replace isei=54 if (isco88 == 5143)
	quietly replace isei=19 if (isco88 == 5149)
	quietly replace isei=43 if (isco88 == 5150)
	quietly replace isei=43 if (isco88 == 5151)
	quietly replace isei=43 if (isco88 == 5152)
	quietly replace isei=47 if (isco88 == 5160)
	quietly replace isei=42 if (isco88 == 5161)
	quietly replace isei=50 if (isco88 == 5162)
	quietly replace isei=40 if (isco88 == 5163)
	quietly replace isei=40 if (isco88 == 5164)
	quietly replace isei=40 if (isco88 == 5169)
	quietly replace isei=43 if (isco88 == 5200)
	quietly replace isei=43 if (isco88 == 5210)
	quietly replace isei=43 if (isco88 == 5220)
	quietly replace isei=37 if (isco88 == 5230)
	quietly replace isei=23 if (isco88 == 6000)
	quietly replace isei=23 if (isco88 == 6100)
	quietly replace isei=23 if (isco88 == 6110)
	quietly replace isei=23 if (isco88 == 6111)
	quietly replace isei=23 if (isco88 == 6112)
	quietly replace isei=23 if (isco88 == 6113)
	quietly replace isei=23 if (isco88 == 6114)
	quietly replace isei=23 if (isco88 == 6120)
	quietly replace isei=23 if (isco88 == 6121)
	quietly replace isei=23 if (isco88 == 6122)
	quietly replace isei=23 if (isco88 == 6123)
	quietly replace isei=23 if (isco88 == 6124)
	quietly replace isei=23 if (isco88 == 6129)
	quietly replace isei=23 if (isco88 == 6130)
	quietly replace isei=23 if (isco88 == 6131)
	quietly replace isei=27 if (isco88 == 6132)
	quietly replace isei=28 if (isco88 == 6133)
	quietly replace isei=28 if (isco88 == 6134)
	quietly replace isei=22 if (isco88 == 6140)
	quietly replace isei=22 if (isco88 == 6141)
	quietly replace isei=22 if (isco88 == 6142)
	quietly replace isei=28 if (isco88 == 6150)
	quietly replace isei=28 if (isco88 == 6151)
	quietly replace isei=28 if (isco88 == 6152)
	quietly replace isei=28 if (isco88 == 6153)
	quietly replace isei=28 if (isco88 == 6154)
	quietly replace isei=16 if (isco88 == 6200)
	quietly replace isei=16 if (isco88 == 6210)
	quietly replace isei=34 if (isco88 == 7000)
	quietly replace isei=31 if (isco88 == 7100)
	quietly replace isei=30 if (isco88 == 7110)
	quietly replace isei=30 if (isco88 == 7111)
	quietly replace isei=30 if (isco88 == 7112)
	quietly replace isei=27 if (isco88 == 7113)
	quietly replace isei=30 if (isco88 == 7120)
	quietly replace isei=29 if (isco88 == 7121)
	quietly replace isei=29 if (isco88 == 7122)
	quietly replace isei=26 if (isco88 == 7123)
	quietly replace isei=29 if (isco88 == 7124)
	quietly replace isei=30 if (isco88 == 7129)
	quietly replace isei=34 if (isco88 == 7130)
	quietly replace isei=19 if (isco88 == 7131)
	quietly replace isei=30 if (isco88 == 7132)
	quietly replace isei=31 if (isco88 == 7133)
	quietly replace isei=34 if (isco88 == 7134)
	quietly replace isei=26 if (isco88 == 7135)
	quietly replace isei=33 if (isco88 == 7136)
	quietly replace isei=37 if (isco88 == 7137)
	quietly replace isei=29 if (isco88 == 7140)
	quietly replace isei=29 if (isco88 == 7141)
	quietly replace isei=32 if (isco88 == 7142)
	quietly replace isei=29 if (isco88 == 7143)
	quietly replace isei=34 if (isco88 == 7200)
	quietly replace isei=31 if (isco88 == 7210)
	quietly replace isei=29 if (isco88 == 7211)
	quietly replace isei=30 if (isco88 == 7212)
	quietly replace isei=33 if (isco88 == 7213)
	quietly replace isei=30 if (isco88 == 7214)
	quietly replace isei=30 if (isco88 == 7215)
	quietly replace isei=30 if (isco88 == 7216)
	quietly replace isei=35 if (isco88 == 7220)
	quietly replace isei=33 if (isco88 == 7221)
	quietly replace isei=40 if (isco88 == 7222)
	quietly replace isei=34 if (isco88 == 7223)
	quietly replace isei=24 if (isco88 == 7224)
	quietly replace isei=34 if (isco88 == 7230)
	quietly replace isei=34 if (isco88 == 7231)
	quietly replace isei=42 if (isco88 == 7232)
	quietly replace isei=33 if (isco88 == 7233)
	quietly replace isei=23 if (isco88 == 7234)
	quietly replace isei=40 if (isco88 == 7240)
	quietly replace isei=40 if (isco88 == 7241)
	quietly replace isei=39 if (isco88 == 7242)
	quietly replace isei=41 if (isco88 == 7243)
	quietly replace isei=40 if (isco88 == 7244)
	quietly replace isei=38 if (isco88 == 7245)
	quietly replace isei=34 if (isco88 == 7300)
	quietly replace isei=38 if (isco88 == 7310)
	quietly replace isei=38 if (isco88 == 7311)
	quietly replace isei=38 if (isco88 == 7312)
	quietly replace isei=38 if (isco88 == 7313)
	quietly replace isei=28 if (isco88 == 7320)
	quietly replace isei=27 if (isco88 == 7321)
	quietly replace isei=29 if (isco88 == 7322)
	quietly replace isei=29 if (isco88 == 7323)
	quietly replace isei=29 if (isco88 == 7324)
	quietly replace isei=29 if (isco88 == 7330)
	quietly replace isei=29 if (isco88 == 7331)
	quietly replace isei=29 if (isco88 == 7332)
	quietly replace isei=40 if (isco88 == 7340)
	quietly replace isei=40 if (isco88 == 7341)
	quietly replace isei=40 if (isco88 == 7342)
	quietly replace isei=42 if (isco88 == 7343)
	quietly replace isei=40 if (isco88 == 7344)
	quietly replace isei=37 if (isco88 == 7345)
	quietly replace isei=38 if (isco88 == 7346)
	quietly replace isei=33 if (isco88 == 7400)
	quietly replace isei=30 if (isco88 == 7410)
	quietly replace isei=30 if (isco88 == 7411)
	quietly replace isei=31 if (isco88 == 7412)
	quietly replace isei=30 if (isco88 == 7413)
	quietly replace isei=30 if (isco88 == 7414)
	quietly replace isei=30 if (isco88 == 7415)
	quietly replace isei=30 if (isco88 == 7416)
	quietly replace isei=33 if (isco88 == 7420)
	quietly replace isei=33 if (isco88 == 7421)
	quietly replace isei=33 if (isco88 == 7422)
	quietly replace isei=33 if (isco88 == 7423)
	quietly replace isei=33 if (isco88 == 7424)
	quietly replace isei=36 if (isco88 == 7430)
	quietly replace isei=29 if (isco88 == 7431)
	quietly replace isei=29 if (isco88 == 7432)
	quietly replace isei=45 if (isco88 == 7433)
	quietly replace isei=36 if (isco88 == 7434)
	quietly replace isei=36 if (isco88 == 7435)
	quietly replace isei=33 if (isco88 == 7436)
	quietly replace isei=28 if (isco88 == 7437)
	quietly replace isei=31 if (isco88 == 7440)
	quietly replace isei=31 if (isco88 == 7441)
	quietly replace isei=31 if (isco88 == 7442)
	quietly replace isei=42 if (isco88 == 7500)
	quietly replace isei=42 if (isco88 == 7510)
	quietly replace isei=39 if (isco88 == 7520)
	quietly replace isei=26 if (isco88 == 7530)
	quietly replace isei=31 if (isco88 == 8000)
	quietly replace isei=30 if (isco88 == 8100)
	quietly replace isei=35 if (isco88 == 8110)
	quietly replace isei=35 if (isco88 == 8111)
	quietly replace isei=35 if (isco88 == 8112)
	quietly replace isei=35 if (isco88 == 8113)
	quietly replace isei=30 if (isco88 == 8120)
	quietly replace isei=31 if (isco88 == 8121)
	quietly replace isei=30 if (isco88 == 8122)
	quietly replace isei=28 if (isco88 == 8123)
	quietly replace isei=30 if (isco88 == 8124)
	quietly replace isei=22 if (isco88 == 8130)
	quietly replace isei=22 if (isco88 == 8131)
	quietly replace isei=22 if (isco88 == 8139)
	quietly replace isei=27 if (isco88 == 8140)
	quietly replace isei=27 if (isco88 == 8141)
	quietly replace isei=27 if (isco88 == 8142)
	quietly replace isei=27 if (isco88 == 8143)
	quietly replace isei=35 if (isco88 == 8150)
	quietly replace isei=35 if (isco88 == 8151)
	quietly replace isei=35 if (isco88 == 8152)
	quietly replace isei=35 if (isco88 == 8153)
	quietly replace isei=35 if (isco88 == 8154)
	quietly replace isei=35 if (isco88 == 8155)
	quietly replace isei=35 if (isco88 == 8159)
	quietly replace isei=32 if (isco88 == 8160)
	quietly replace isei=33 if (isco88 == 8161)
	quietly replace isei=27 if (isco88 == 8162)
	quietly replace isei=33 if (isco88 == 8163)
	quietly replace isei=26 if (isco88 == 8170)
	quietly replace isei=26 if (isco88 == 8171)
	quietly replace isei=26 if (isco88 == 8172)
	quietly replace isei=32 if (isco88 == 8200)
	quietly replace isei=36 if (isco88 == 8210)
	quietly replace isei=36 if (isco88 == 8211)
	quietly replace isei=30 if (isco88 == 8212)
	quietly replace isei=30 if (isco88 == 8220)
	quietly replace isei=30 if (isco88 == 8221)
	quietly replace isei=30 if (isco88 == 8222)
	quietly replace isei=30 if (isco88 == 8223)
	quietly replace isei=30 if (isco88 == 8224)
	quietly replace isei=30 if (isco88 == 8229)
	quietly replace isei=30 if (isco88 == 8230)
	quietly replace isei=30 if (isco88 == 8231)
	quietly replace isei=30 if (isco88 == 8232)
	quietly replace isei=29 if (isco88 == 8240)
	quietly replace isei=38 if (isco88 == 8250)
	quietly replace isei=38 if (isco88 == 8251)
	quietly replace isei=38 if (isco88 == 8252)
	quietly replace isei=38 if (isco88 == 8253)
	quietly replace isei=30 if (isco88 == 8260)
	quietly replace isei=29 if (isco88 == 8261)
	quietly replace isei=29 if (isco88 == 8262)
	quietly replace isei=32 if (isco88 == 8263)
	quietly replace isei=24 if (isco88 == 8264)
	quietly replace isei=32 if (isco88 == 8265)
	quietly replace isei=32 if (isco88 == 8266)
	quietly replace isei=32 if (isco88 == 8269)
	quietly replace isei=29 if (isco88 == 8270)
	quietly replace isei=29 if (isco88 == 8271)
	quietly replace isei=29 if (isco88 == 8272)
	quietly replace isei=29 if (isco88 == 8273)
	quietly replace isei=29 if (isco88 == 8274)
	quietly replace isei=29 if (isco88 == 8275)
	quietly replace isei=29 if (isco88 == 8276)
	quietly replace isei=29 if (isco88 == 8277)
	quietly replace isei=29 if (isco88 == 8278)
	quietly replace isei=29 if (isco88 == 8279)
	quietly replace isei=31 if (isco88 == 8280)
	quietly replace isei=30 if (isco88 == 8281)
	quietly replace isei=34 if (isco88 == 8282)
	quietly replace isei=34 if (isco88 == 8283)
	quietly replace isei=30 if (isco88 == 8284)
	quietly replace isei=30 if (isco88 == 8285)
	quietly replace isei=30 if (isco88 == 8286)
	quietly replace isei=26 if (isco88 == 8290)
	quietly replace isei=32 if (isco88 == 8300)
	quietly replace isei=36 if (isco88 == 8310)
	quietly replace isei=41 if (isco88 == 8311)
	quietly replace isei=32 if (isco88 == 8312)
	quietly replace isei=34 if (isco88 == 8320)
	quietly replace isei=30 if (isco88 == 8321)
	quietly replace isei=30 if (isco88 == 8322)
	quietly replace isei=30 if (isco88 == 8323)
	quietly replace isei=34 if (isco88 == 8324)
	quietly replace isei=26 if (isco88 == 8330)
	quietly replace isei=26 if (isco88 == 8331)
	quietly replace isei=26 if (isco88 == 8332)
	quietly replace isei=28 if (isco88 == 8333)
	quietly replace isei=28 if (isco88 == 8334)
	quietly replace isei=32 if (isco88 == 8340)
	quietly replace isei=24 if (isco88 == 8400)
	quietly replace isei=20 if (isco88 == 9000)
	quietly replace isei=25 if (isco88 == 9100)
	quietly replace isei=29 if (isco88 == 9110)
	quietly replace isei=29 if (isco88 == 9111)
	quietly replace isei=28 if (isco88 == 9112)
	quietly replace isei=29 if (isco88 == 9113)
	quietly replace isei=28 if (isco88 == 9120)
	quietly replace isei=16 if (isco88 == 9130)
	quietly replace isei=16 if (isco88 == 9131)
	quietly replace isei=16 if (isco88 == 9132)
	quietly replace isei=16 if (isco88 == 9133)
	quietly replace isei=23 if (isco88 == 9140)
	quietly replace isei=23 if (isco88 == 9141)
	quietly replace isei=23 if (isco88 == 9142)
	quietly replace isei=27 if (isco88 == 9150)
	quietly replace isei=25 if (isco88 == 9151)
	quietly replace isei=27 if (isco88 == 9152)
	quietly replace isei=27 if (isco88 == 9153)
	quietly replace isei=23 if (isco88 == 9160)
	quietly replace isei=23 if (isco88 == 9161)
	quietly replace isei=23 if (isco88 == 9162)
	quietly replace isei=16 if (isco88 == 9200)
	quietly replace isei=16 if (isco88 == 9210)
	quietly replace isei=16 if (isco88 == 9211)
	quietly replace isei=16 if (isco88 == 9212)
	quietly replace isei=16 if (isco88 == 9213)
	quietly replace isei=23 if (isco88 == 9300)
	quietly replace isei=21 if (isco88 == 9310)
	quietly replace isei=21 if (isco88 == 9311)
	quietly replace isei=21 if (isco88 == 9312)
	quietly replace isei=21 if (isco88 == 9313)
	quietly replace isei=20 if (isco88 == 9320)
	quietly replace isei=20 if (isco88 == 9321)
	quietly replace isei=24 if (isco88 == 9322)
	quietly replace isei=29 if (isco88 == 9330)
	quietly replace isei=22 if (isco88 == 9331)
	quietly replace isei=22 if (isco88 == 9332)
	quietly replace isei=30 if (isco88 == 9333)
	save 2012,replace

use 2018,clear
//
gen isco88=.
replace isco88=1100 if qg303code==10000
replace isco88=1100 if qg303code==10100
replace isco88=1100 if qg303code==10101
replace isco88=1100 if qg303code==10200
replace isco88=1100 if qg303code==10201
replace isco88=1140 if qg303code==10202
replace isco88=1100 if qg303code==10203
replace isco88=1100 if qg303code==10204
replace isco88=1200 if qg303code==10205
replace isco88=1200 if qg303code==10209
replace isco88=1140 if qg303code==10300
replace isco88=1141 if qg303code==10301
replace isco88=1142 if qg303code==10302
replace isco88=1143 if qg303code==10303
replace isco88=1143 if qg303code==10309
replace isco88=1210 if qg303code==10400
replace isco88=1210 if qg303code==10401
replace isco88=1210 if qg303code==10402
replace isco88=1210 if qg303code==10403
replace isco88=1210 if qg303code==10409
replace isco88=1210 if qg303code==10500
replace isco88=1210 if qg303code==10501

replace isco88=1210 if qg303code==10510
replace isco88=1220 if qg303code==10520
replace isco88=1220 if qg303code==10530
replace isco88=9110 if qg303code==10549
replace isco88=9110 if qg303code==10550
replace isco88=9110 if qg303code==10551
replace isco88=1310 if qg303code==10552

replace isco88=2000 if qg303code==20000
replace isco88=2100 if qg303code==20100
replace isco88=2443 if qg303code==20101
replace isco88=2441 if qg303code==20102
replace isco88=2442 if qg303code==20103
replace isco88=2442 if qg303code==20104
replace isco88=2442 if qg303code==20105
replace isco88=2440 if qg303code==20106
replace isco88=2432 if qg303code==20107
replace isco88=2443 if qg303code==20108
replace isco88=2442 if qg303code==20109
replace isco88=2121 if qg303code==20111
replace isco88=2111 if qg303code==20112
replace isco88=2113 if qg303code==20113
replace isco88=2111 if qg303code==20114
replace isco88=2114 if qg303code==20115
replace isco88=2211 if qg303code==20116
replace isco88=2213 if qg303code==20117
replace isco88=2211 if qg303code==20118
replace isco88=2100 if qg303code==20119
replace isco88=2140 if qg303code==20200
replace isco88=2147 if qg303code==20201
replace isco88=2148 if qg303code==20202
replace isco88=2147 if qg303code==20203
replace isco88=2147 if qg303code==20204
replace isco88=2147 if qg303code==20205
replace isco88=2146 if qg303code==20206
replace isco88=2145 if qg303code==20207
replace isco88=2145 if qg303code==20208
replace isco88=2145 if qg303code==20209
replace isco88=2145 if qg303code==20211
replace isco88=2144 if qg303code==20212
replace isco88=2144 if qg303code==20213
replace isco88=2130 if qg303code==20214
replace isco88=2143 if qg303code==20215
replace isco88=2149 if qg303code==20216
replace isco88=2149 if qg303code==20217
replace isco88=2144 if qg303code==20218
replace isco88=2141 if qg303code==20219
replace isco88=2141 if qg303code==20221
replace isco88=2141 if qg303code==20222
replace isco88=2141 if qg303code==20223
replace isco88=2142 if qg303code==20224
replace isco88=2213 if qg303code==20225
replace isco88=2145 if qg303code==20226
replace isco88=2144 if qg303code==20227
replace isco88=2149 if qg303code==20228
replace isco88=2149 if qg303code==20229
replace isco88=2149 if qg303code==20231
replace isco88=2112 if qg303code==20232
replace isco88=2114 if qg303code==20233
replace isco88=2149 if qg303code==20234
replace isco88=2149 if qg303code==20235
replace isco88=2149 if qg303code==20236
replace isco88=2149 if qg303code==20237
replace isco88=2149 if qg303code==20239
replace isco88=2213 if qg303code==20300
replace isco88=2213 if qg303code==20301
replace isco88=2213 if qg303code==20302
replace isco88=2213 if qg303code==20303
replace isco88=2213 if qg303code==20304
replace isco88=2223 if qg303code==20305
replace isco88=2213 if qg303code==20306
replace isco88=2213 if qg303code==20309
replace isco88=3140 if qg303code==20400
replace isco88=3143 if qg303code==20401
replace isco88=3142 if qg303code==20402
replace isco88=3140 if qg303code==20409
replace isco88=2220 if qg303code==20500
replace isco88=2221 if qg303code==20501
replace isco88=2220 if qg303code==20502
replace isco88=2221 if qg303code==20503
replace isco88=2220 if qg303code==20504
replace isco88=2221 if qg303code==20505
replace isco88=2224 if qg303code==20506
replace isco88=3220 if qg303code==20507
replace isco88=2230 if qg303code==20508
replace isco88=3220 if qg303code==20509
replace isco88=2410 if qg303code==20600
replace isco88=2441 if qg303code==20601
replace isco88=2122 if qg303code==20602
replace isco88=2411 if qg303code==20603
replace isco88=2411 if qg303code==20604
replace isco88=3421 if qg303code==20605
replace isco88=2410 if qg303code==20609
replace isco88=3410 if qg303code==20700
replace isco88=3419 if qg303code==20701
replace isco88=3412 if qg303code==20702
replace isco88=3411 if qg303code==20703
replace isco88=3419 if qg303code==20709
replace isco88=2420 if qg303code==20800
replace isco88=2422 if qg303code==20801
replace isco88=2421 if qg303code==20802
replace isco88=2421 if qg303code==20803
replace isco88=2429 if qg303code==20804
replace isco88=2429 if qg303code==20805
replace isco88=2429 if qg303code==20806
replace isco88=2429 if qg303code==20809
replace isco88=2300 if qg303code==20900
replace isco88=2310 if qg303code==20901
replace isco88=2320 if qg303code==20902
replace isco88=2320 if qg303code==20903
replace isco88=2331 if qg303code==20904
replace isco88=2332 if qg303code==20905
replace isco88=2340 if qg303code==20906
replace isco88=2359 if qg303code==20909
replace isco88=2450 if qg303code==21000
replace isco88=2451 if qg303code==21001
replace isco88=2453 if qg303code==21002
replace isco88=2455 if qg303code==21003
replace isco88=2453 if qg303code==21004
replace isco88=2455 if qg303code==21005
replace isco88=2452 if qg303code==21006
replace isco88=2452 if qg303code==21007
replace isco88=2450 if qg303code==21009
replace isco88=3475 if qg303code==21100
replace isco88=3475 if qg303code==21101
replace isco88=2450 if qg303code==21200
replace isco88=2451 if qg303code==21201
replace isco88=2451 if qg303code==21202
replace isco88=4143 if qg303code==21203
replace isco88=3472 if qg303code==21204
replace isco88=2444 if qg303code==21205
replace isco88=2431 if qg303code==21206
replace isco88=2430 if qg303code==21207
replace isco88=3470 if qg303code==21209
replace isco88=2460 if qg303code==21300
replace isco88=2460 if qg303code==21301
replace isco88=2400 if qg303code==21900
replace isco88=2400 if qg303code==21901
replace isco88=4000 if qg303code==30000
replace isco88=4110 if qg303code==30100
replace isco88=3430 if qg303code==30101
replace isco88=4110 if qg303code==30102
replace isco88=4110 if qg303code==30109
replace isco88=5160 if qg303code==30200
replace isco88=5162 if qg303code==30201
replace isco88=5169 if qg303code==30202
replace isco88=5161 if qg303code==30203
replace isco88=5169 if qg303code==30209
replace isco88=4210 if qg303code==30300
replace isco88=4142 if qg303code==30301
replace isco88=4210 if qg303code==30302
replace isco88=4210 if qg303code==30303
replace isco88=4210 if qg303code==30309
replace isco88=4190 if qg303code==30900
replace isco88=4190 if qg303code==30901
replace isco88=5000 if qg303code==40000
replace isco88=5200 if qg303code==40100
replace isco88=5220 if qg303code==40101
replace isco88=5220 if qg303code==40102
replace isco88=3416 if qg303code==40103
replace isco88=3417 if qg303code==40104
replace isco88=9161 if qg303code==40105
replace isco88=3439 if qg303code==40106
replace isco88=3439 if qg303code==40107
replace isco88=5200 if qg303code==40109
replace isco88=4130 if qg303code==40200
replace isco88=4131 if qg303code==40201
replace isco88=4133 if qg303code==40202
replace isco88=4130 if qg303code==40209
replace isco88=5120 if qg303code==40300
replace isco88=5122 if qg303code==40301
replace isco88=5122 if qg303code==40302
replace isco88=5123 if qg303code==40303
replace isco88=5120 if qg303code==40304
replace isco88=5123 if qg303code==40305
replace isco88=5120 if qg303code==40309
replace isco88=5132 if qg303code==40400
replace isco88=5132 if qg303code==40401
replace isco88=5111 if qg303code==40402
replace isco88=5132 if qg303code==40403
replace isco88=5139 if qg303code==40409
replace isco88=5110 if qg303code==40500
replace isco88=5110 if qg303code==40501
replace isco88=5110 if qg303code==40502
replace isco88=5110 if qg303code==40503
replace isco88=5110 if qg303code==40504
replace isco88=5110 if qg303code==40509
replace isco88=5132 if qg303code==40600
replace isco88=5132 if qg303code==40601
replace isco88=5132 if qg303code==40700
replace isco88=5132 if qg303code==40701
replace isco88=5121 if qg303code==40702
replace isco88=5121 if qg303code==40703
replace isco88=5141 if qg303code==40704
replace isco88=3131 if qg303code==40705
replace isco88=3224 if qg303code==40706
replace isco88=5149 if qg303code==40707
replace isco88=5149 if qg303code==40708
replace isco88=7300 if qg303code==40709
replace isco88=7241 if qg303code==40711
replace isco88=7241 if qg303code==40712
replace isco88=5130 if qg303code==40713
replace isco88=9162 if qg303code==40714
replace isco88=5143 if qg303code==40715
replace isco88=5132 if qg303code==40719
replace isco88=5000 if qg303code==40900
replace isco88=5000 if qg303code==40901
replace isco88=6100 if qg303code==50000
replace isco88=6110 if qg303code==50100
replace isco88=6111 if qg303code==50101
replace isco88=3212 if qg303code==50102
replace isco88=6113 if qg303code==50103
replace isco88=6113 if qg303code==50104
replace isco88=6113 if qg303code==50105
replace isco88=7410 if qg303code==50106
replace isco88=6114 if qg303code==50109
replace isco88=6140 if qg303code==50200
replace isco88=6141 if qg303code==50201
replace isco88=6141 if qg303code==50202
replace isco88=6130 if qg303code==50203
replace isco88=6141 if qg303code==50204
replace isco88=6130 if qg303code==50209
replace isco88=6120 if qg303code==50300
replace isco88=6121 if qg303code==50301
replace isco88=6122 if qg303code==50302
replace isco88=6123 if qg303code==50303
replace isco88=6129 if qg303code==50304
replace isco88=3227 if qg303code==50305
replace isco88=6111 if qg303code==50306
replace isco88=6129 if qg303code==50309
replace isco88=6150 if qg303code==50400
replace isco88=6151 if qg303code==50401
replace isco88=6152 if qg303code==50402
replace isco88=8271 if qg303code==50403
replace isco88=6150 if qg303code==50409
replace isco88=9312 if qg303code==50500
replace isco88=9312 if qg303code==50501
replace isco88=9312 if qg303code==50502
replace isco88=9312 if qg303code==50503
replace isco88=9312 if qg303code==50504
replace isco88=9312 if qg303code==50509
replace isco88=6100 if qg303code==50900
replace isco88=8331 if qg303code==50901
replace isco88=8163 if qg303code==50902
replace isco88=7000 if qg303code==60000
replace isco88=7110 if qg303code==60100
replace isco88=3117 if qg303code==60101
replace isco88=3117 if qg303code==60102
replace isco88=7111 if qg303code==60103
replace isco88=8112 if qg303code==60104
replace isco88=7111 if qg303code==60105
replace isco88=7111 if qg303code==60106
replace isco88=7111 if qg303code==60107
replace isco88=7100 if qg303code==60109
replace isco88=8120 if qg303code==60200
replace isco88=8121 if qg303code==60201
replace isco88=8121 if qg303code==60202
replace isco88=8121 if qg303code==60203
replace isco88=8121 if qg303code==60204
replace isco88=8121 if qg303code==60205
replace isco88=8121 if qg303code==60206
replace isco88=8131 if qg303code==60207
replace isco88=8122 if qg303code==60208
replace isco88=8122 if qg303code==60209
replace isco88=8120 if qg303code==60211
replace isco88=8120 if qg303code==60212
replace isco88=8120 if qg303code==60219
replace isco88=8150 if qg303code==60300
replace isco88=8150 if qg303code==60301
replace isco88=8155 if qg303code==60302
replace isco88=8150 if qg303code==60303
replace isco88=8150 if qg303code==60304
replace isco88=8150 if qg303code==60305
replace isco88=8150 if qg303code==60306
replace isco88=8150 if qg303code==60307
replace isco88=8150 if qg303code==60308
replace isco88=8150 if qg303code==60309
replace isco88=8150 if qg303code==60311
replace isco88=8220 if qg303code==60312
replace isco88=8220 if qg303code==60313
replace isco88=8222 if qg303code==60314
replace isco88=8220 if qg303code==60315
replace isco88=8220 if qg303code==60316
replace isco88=8229 if qg303code==60317
replace isco88=8229 if qg303code==60319
replace isco88=7210 if qg303code==60400
replace isco88=7210 if qg303code==60401
replace isco88=7210 if qg303code==60402
replace isco88=7210 if qg303code==60403
replace isco88=7213 if qg303code==60404
replace isco88=7224 if qg303code==60405
replace isco88=7224 if qg303code==60406
replace isco88=7210 if qg303code==60407
replace isco88=7210 if qg303code==60409
replace isco88=8280 if qg303code==60500
replace isco88=8280 if qg303code==60501
replace isco88=8281 if qg303code==60502
replace isco88=8282 if qg303code==60503
replace isco88=8283 if qg303code==60504
replace isco88=8283 if qg303code==60505
replace isco88=8283 if qg303code==60506
replace isco88=8281 if qg303code==60507
replace isco88=8280 if qg303code==60508
replace isco88=8280 if qg303code==60509
replace isco88=8282 if qg303code==60511
replace isco88=8281 if qg303code==60512
replace isco88=8281 if qg303code==60513
replace isco88=8280 if qg303code==60514
replace isco88=8290 if qg303code==60515
replace isco88=8290 if qg303code==60516
replace isco88=8290 if qg303code==60517
replace isco88=8290 if qg303code==60518
replace isco88=7230 if qg303code==60519
replace isco88=7230 if qg303code==60521
replace isco88=3119 if qg303code==60522
replace isco88=7232 if qg303code==60523
replace isco88=7232 if qg303code==60524
replace isco88=3119 if qg303code==60525
replace isco88=3119 if qg303code==60526
replace isco88=8290 if qg303code==60529
replace isco88=7230 if qg303code==60600
replace isco88=7230 if qg303code==60601
replace isco88=7243 if qg303code==60602
replace isco88=7232 if qg303code==60603
replace isco88=7230 if qg303code==60609
replace isco88=7240 if qg303code==60700
replace isco88=7241 if qg303code==60701
replace isco88=8161 if qg303code==60702
replace isco88=7241 if qg303code==60703
replace isco88=7241 if qg303code==60704
replace isco88=7245 if qg303code==60705
replace isco88=7240 if qg303code==60706
replace isco88=7240 if qg303code==60709
replace isco88=7240 if qg303code==60800
replace isco88=7240 if qg303code==60801
replace isco88=7240 if qg303code==60802
replace isco88=7240 if qg303code==60803
replace isco88=7240 if qg303code==60804
replace isco88=7243 if qg303code==60805
replace isco88=7240 if qg303code==60809
replace isco88=8230 if qg303code==60900
replace isco88=8231 if qg303code==60901
replace isco88=8232 if qg303code==60902
replace isco88=8230 if qg303code==60909
replace isco88=7430 if qg303code==61000
replace isco88=7431 if qg303code==61001
replace isco88=7432 if qg303code==61002
replace isco88=7430 if qg303code==61003
replace isco88=7432 if qg303code==61004
replace isco88=7432 if qg303code==61005
replace isco88=7432 if qg303code==61009
replace isco88=7430 if qg303code==61100
replace isco88=7433 if qg303code==61101
replace isco88=7433 if qg303code==61102
replace isco88=7434 if qg303code==61103
replace isco88=7436 if qg303code==61104
replace isco88=7430 if qg303code==61109
replace isco88=7410 if qg303code==61200
replace isco88=7410 if qg303code==61201
replace isco88=7412 if qg303code==61202
replace isco88=7413 if qg303code==61203
replace isco88=7410 if qg303code==61204
replace isco88=7410 if qg303code==61205
replace isco88=7410 if qg303code==61206
replace isco88=7410 if qg303code==61207
replace isco88=7410 if qg303code==61208
replace isco88=7410 if qg303code==61209
replace isco88=7416 if qg303code==61300
replace isco88=7416 if qg303code==61301
replace isco88=7416 if qg303code==61302
replace isco88=7416 if qg303code==61303
replace isco88=7416 if qg303code==61309
replace isco88=8221 if qg303code==61400
replace isco88=8221 if qg303code==61401
replace isco88=8221 if qg303code==61402
replace isco88=2224 if qg303code==61403
replace isco88=2224 if qg303code==61404
replace isco88=8221 if qg303code==61409
replace isco88=8140 if qg303code==61500
replace isco88=8141 if qg303code==61501
replace isco88=8141 if qg303code==61502
replace isco88=8240 if qg303code==61503
replace isco88=8142 if qg303code==61504
replace isco88=8143 if qg303code==61505
replace isco88=8253 if qg303code==61506
replace isco88=8140 if qg303code==61509
replace isco88=8290 if qg303code==61600
replace isco88=8212 if qg303code==61601
replace isco88=8212 if qg303code==61602
replace isco88=8290 if qg303code==61603
replace isco88=8290 if qg303code==61604
replace isco88=8290 if qg303code==61605
replace isco88=8290 if qg303code==61606
replace isco88=8290 if qg303code==61607
replace isco88=8290 if qg303code==61609
replace isco88=7320 if qg303code==61700
replace isco88=7321 if qg303code==61701
replace isco88=7321 if qg303code==61702
replace isco88=7322 if qg303code==61703
replace isco88=7324 if qg303code==61704
replace isco88=7324 if qg303code==61705
replace isco88=7320 if qg303code==61709
replace isco88=3130 if qg303code==61800
replace isco88=3130 if qg303code==61801
replace isco88=3131 if qg303code==61802
replace isco88=3132 if qg303code==61803
replace isco88=3132 if qg303code==61804
replace isco88=3110 if qg303code==61805
replace isco88=3130 if qg303code==61809
replace isco88=7340 if qg303code==61900
replace isco88=7340 if qg303code==61901
replace isco88=7340 if qg303code==61902
replace isco88=7340 if qg303code==61903
replace isco88=7340 if qg303code==61909
replace isco88=7300 if qg303code==62000
replace isco88=7313 if qg303code==62001
replace isco88=7332 if qg303code==62002
replace isco88=7330 if qg303code==62003
replace isco88=7331 if qg303code==62004
replace isco88=7436 if qg303code==62005
replace isco88=7313 if qg303code==62006
replace isco88=7330 if qg303code==62007
replace isco88=7300 if qg303code==62008
replace isco88=7300 if qg303code==62009
replace isco88=7400 if qg303code==62100
replace isco88=7400 if qg303code==62101
replace isco88=7400 if qg303code==62102
replace isco88=7312 if qg303code==62103
replace isco88=7400 if qg303code==62109
replace isco88=7120 if qg303code==62200
replace isco88=7121 if qg303code==62201
replace isco88=7122 if qg303code==62202
replace isco88=7123 if qg303code==62203
replace isco88=7129 if qg303code==62204
replace isco88=7130 if qg303code==62205
replace isco88=7134 if qg303code==62206
replace isco88=7141 if qg303code==62207
replace isco88=7130 if qg303code==62208
replace isco88=9312 if qg303code==62209
replace isco88=7230 if qg303code==62211
replace isco88=7129 if qg303code==62219
replace isco88=8300 if qg303code==62300
replace isco88=8320 if qg303code==62301
replace isco88=8310 if qg303code==62302
replace isco88=8320 if qg303code==62303
replace isco88=8340 if qg303code==62304
replace isco88=8334 if qg303code==62305
replace isco88=8300 if qg303code==62309
replace isco88=3150 if qg303code==62400
replace isco88=3150 if qg303code==62401
replace isco88=3150 if qg303code==62402
replace isco88=9161 if qg303code==62403
replace isco88=3150 if qg303code==62409
replace isco88=3150 if qg303code==62500
replace isco88=3150 if qg303code==62501
replace isco88=3150 if qg303code==62502
replace isco88=3150 if qg303code==62503
replace isco88=3110 if qg303code==62504
replace isco88=3150 if qg303code==62509
replace isco88=8000 if qg303code==62900
replace isco88=9322 if qg303code==62901
replace isco88=8160 if qg303code==62902
replace isco88=9000 if qg303code==62903

replace isco88=.a if qg303code==70000
replace isco88=.b if qg303code==80000
replace isco88=.c if qg303code==90000

replace isco88=9300 if qg303code==99700
replace isco88=9300 if qg303code==99800
replace isco88=9300 if qg303code==99900

replace isco88=.x if qg303code==-1
replace isco88=.y if qg303code==-2
replace isco88=.z if qg303code==-8

replace isco88=.w if qg303code==-7
replace isco88=.r if qg303code==-9







//-----------------------------gen isei code----------------------------
	quietly gen isei=.
	quietly replace isei=55 if (isco88 == 1000)
	quietly replace isei=70 if (isco88 == 1100)
	quietly replace isei=77 if (isco88 == 1110)
	quietly replace isei=77 if (isco88 == 1120)
	quietly replace isei=66 if (isco88 == 1130)
	quietly replace isei=58 if (isco88 == 1140)
	quietly replace isei=58 if (isco88 == 1141)
	quietly replace isei=58 if (isco88 == 1142)
	quietly replace isei=58 if (isco88 == 1143)
	quietly replace isei=68 if (isco88 == 1200)
	quietly replace isei=70 if (isco88 == 1210)
	quietly replace isei=67 if (isco88 == 1220)
	quietly replace isei=67 if (isco88 == 1221)
	quietly replace isei=67 if (isco88 == 1222)
	quietly replace isei=67 if (isco88 == 1223)
	quietly replace isei=59 if (isco88 == 1224)
	quietly replace isei=59 if (isco88 == 1225)
	quietly replace isei=59 if (isco88 == 1226)
	quietly replace isei=87 if (isco88 == 1227)
	quietly replace isei=59 if (isco88 == 1228)
	quietly replace isei=67 if (isco88 == 1229)
	quietly replace isei=61 if (isco88 == 1230)
	quietly replace isei=69 if (isco88 == 1231)
	quietly replace isei=69 if (isco88 == 1232)
	quietly replace isei=56 if (isco88 == 1233)
	quietly replace isei=69 if (isco88 == 1234)
	quietly replace isei=69 if (isco88 == 1235)
	quietly replace isei=69 if (isco88 == 1236)
	quietly replace isei=69 if (isco88 == 1237)
	quietly replace isei=69 if (isco88 == 1239)
	quietly replace isei=58 if (isco88 == 1240)
	quietly replace isei=64 if (isco88 == 1250)
	quietly replace isei=70 if (isco88 == 1251)
	quietly replace isei=60 if (isco88 == 1252)
	quietly replace isei=51 if (isco88 == 1300)
	quietly replace isei=51 if (isco88 == 1310)
	quietly replace isei=43 if (isco88 == 1311)
	quietly replace isei=56 if (isco88 == 1312)
	quietly replace isei=51 if (isco88 == 1313)
	quietly replace isei=49 if (isco88 == 1314)
	quietly replace isei=44 if (isco88 == 1315)
	quietly replace isei=51 if (isco88 == 1316)
	quietly replace isei=51 if (isco88 == 1317)
	quietly replace isei=51 if (isco88 == 1318)
	quietly replace isei=51 if (isco88 == 1319)
	quietly replace isei=70 if (isco88 == 2000)
	quietly replace isei=69 if (isco88 == 2100)
	quietly replace isei=74 if (isco88 == 2110)
	quietly replace isei=74 if (isco88 == 2111)
	quietly replace isei=74 if (isco88 == 2112)
	quietly replace isei=74 if (isco88 == 2113)
	quietly replace isei=74 if (isco88 == 2114)
	quietly replace isei=71 if (isco88 == 2120)
	quietly replace isei=71 if (isco88 == 2121)
	quietly replace isei=71 if (isco88 == 2122)
	quietly replace isei=71 if (isco88 == 2130)
	quietly replace isei=71 if (isco88 == 2131)
	quietly replace isei=71 if (isco88 == 2132)
	quietly replace isei=71 if (isco88 == 2139)
	quietly replace isei=73 if (isco88 == 2140)
	quietly replace isei=69 if (isco88 == 2141)
	quietly replace isei=69 if (isco88 == 2142)
	quietly replace isei=68 if (isco88 == 2143)
	quietly replace isei=68 if (isco88 == 2144)
	quietly replace isei=67 if (isco88 == 2145)
	quietly replace isei=71 if (isco88 == 2146)
	quietly replace isei=67 if (isco88 == 2147)
	quietly replace isei=56 if (isco88 == 2148)
	quietly replace isei=69 if (isco88 == 2149)
	quietly replace isei=80 if (isco88 == 2200)
	quietly replace isei=78 if (isco88 == 2210)
	quietly replace isei=77 if (isco88 == 2211)
	quietly replace isei=77 if (isco88 == 2212)
	quietly replace isei=79 if (isco88 == 2213)
	quietly replace isei=85 if (isco88 == 2220)
	quietly replace isei=88 if (isco88 == 2221)
	quietly replace isei=85 if (isco88 == 2222)
	quietly replace isei=83 if (isco88 == 2223)
	quietly replace isei=74 if (isco88 == 2224)
	quietly replace isei=85 if (isco88 == 2229)
	quietly replace isei=43 if (isco88 == 2230)
	quietly replace isei=69 if (isco88 == 2300)
	quietly replace isei=77 if (isco88 == 2310)
	quietly replace isei=69 if (isco88 == 2320)
	quietly replace isei=70 if (isco88 == 2321)
	quietly replace isei=66 if (isco88 == 2322)
	quietly replace isei=66 if (isco88 == 2330)
	quietly replace isei=66 if (isco88 == 2331)
	quietly replace isei=43 if (isco88 == 2332)
	quietly replace isei=66 if (isco88 == 2340)
	quietly replace isei=66 if (isco88 == 2350)
	quietly replace isei=70 if (isco88 == 2351)
	quietly replace isei=70 if (isco88 == 2352)
	quietly replace isei=65 if (isco88 == 2359)
	quietly replace isei=68 if (isco88 == 2400)
	quietly replace isei=69 if (isco88 == 2410)
	quietly replace isei=69 if (isco88 == 2411)
	quietly replace isei=69 if (isco88 == 2412)
	quietly replace isei=69 if (isco88 == 2419)
	quietly replace isei=85 if (isco88 == 2420)
	quietly replace isei=85 if (isco88 == 2421)
	quietly replace isei=90 if (isco88 == 2422)
	quietly replace isei=82 if (isco88 == 2429)
	quietly replace isei=65 if (isco88 == 2430)
	quietly replace isei=65 if (isco88 == 2431)
	quietly replace isei=65 if (isco88 == 2432)
	quietly replace isei=65 if (isco88 == 2440)
	quietly replace isei=78 if (isco88 == 2441)
	quietly replace isei=71 if (isco88 == 2442)
	quietly replace isei=71 if (isco88 == 2443)
	quietly replace isei=65 if (isco88 == 2444)
	quietly replace isei=71 if (isco88 == 2445)
	quietly replace isei=51 if (isco88 == 2446)
	quietly replace isei=61 if (isco88 == 2450)
	quietly replace isei=65 if (isco88 == 2451)
	quietly replace isei=54 if (isco88 == 2452)
	quietly replace isei=64 if (isco88 == 2453)
	quietly replace isei=64 if (isco88 == 2454)
	quietly replace isei=64 if (isco88 == 2455)
	quietly replace isei=53 if (isco88 == 2460)
	quietly replace isei=54 if (isco88 == 3000)
	quietly replace isei=50 if (isco88 == 3100)
	quietly replace isei=49 if (isco88 == 3110)
	quietly replace isei=45 if (isco88 == 3111)
	quietly replace isei=45 if (isco88 == 3112)
	quietly replace isei=46 if (isco88 == 3113)
	quietly replace isei=46 if (isco88 == 3114)
	quietly replace isei=54 if (isco88 == 3115)
	quietly replace isei=54 if (isco88 == 3116)
	quietly replace isei=54 if (isco88 == 3117)
	quietly replace isei=51 if (isco88 == 3118)
	quietly replace isei=53 if (isco88 == 3119)
	quietly replace isei=52 if (isco88 == 3120)
	quietly replace isei=52 if (isco88 == 3121)
	quietly replace isei=52 if (isco88 == 3122)
	quietly replace isei=52 if (isco88 == 3123)
	quietly replace isei=52 if (isco88 == 3130)
	quietly replace isei=48 if (isco88 == 3131)
	quietly replace isei=57 if (isco88 == 3132)
	quietly replace isei=57 if (isco88 == 3133)
	quietly replace isei=52 if (isco88 == 3139)
	quietly replace isei=57 if (isco88 == 3140)
	quietly replace isei=52 if (isco88 == 3141)
	quietly replace isei=52 if (isco88 == 3142)
	quietly replace isei=69 if (isco88 == 3143)
	quietly replace isei=69 if (isco88 == 3144)
	quietly replace isei=50 if (isco88 == 3145)
	quietly replace isei=50 if (isco88 == 3150)
	quietly replace isei=50 if (isco88 == 3151)
	quietly replace isei=50 if (isco88 == 3152)
	quietly replace isei=48 if (isco88 == 3200)
	quietly replace isei=50 if (isco88 == 3210)
	quietly replace isei=50 if (isco88 == 3211)
	quietly replace isei=50 if (isco88 == 3212)
	quietly replace isei=50 if (isco88 == 3213)
	quietly replace isei=55 if (isco88 == 3220)
	quietly replace isei=51 if (isco88 == 3221)
	quietly replace isei=51 if (isco88 == 3222)
	quietly replace isei=51 if (isco88 == 3223)
	quietly replace isei=60 if (isco88 == 3224)
	quietly replace isei=51 if (isco88 == 3225)
	quietly replace isei=60 if (isco88 == 3226)
	quietly replace isei=51 if (isco88 == 3227)
	quietly replace isei=51 if (isco88 == 3228)
	quietly replace isei=51 if (isco88 == 3229)
	quietly replace isei=38 if (isco88 == 3230)
	quietly replace isei=38 if (isco88 == 3231)
	quietly replace isei=38 if (isco88 == 3232)
	quietly replace isei=49 if (isco88 == 3240)
	quietly replace isei=51 if (isco88 == 3241)
	quietly replace isei=38 if (isco88 == 3242)
	quietly replace isei=38 if (isco88 == 3300)
	quietly replace isei=38 if (isco88 == 3310)
	quietly replace isei=38 if (isco88 == 3320)
	quietly replace isei=38 if (isco88 == 3330)
	quietly replace isei=38 if (isco88 == 3340)
	quietly replace isei=55 if (isco88 == 3400)
	quietly replace isei=55 if (isco88 == 3410)
	quietly replace isei=61 if (isco88 == 3411)
	quietly replace isei=54 if (isco88 == 3412)
	quietly replace isei=59 if (isco88 == 3413)
	quietly replace isei=56 if (isco88 == 3414)
	quietly replace isei=56 if (isco88 == 3415)
	quietly replace isei=50 if (isco88 == 3416)
	quietly replace isei=56 if (isco88 == 3417)
	quietly replace isei=55 if (isco88 == 3419)
	quietly replace isei=55 if (isco88 == 3420)
	quietly replace isei=55 if (isco88 == 3421)
	quietly replace isei=55 if (isco88 == 3422)
	quietly replace isei=55 if (isco88 == 3423)
	quietly replace isei=55 if (isco88 == 3429)
	quietly replace isei=54 if (isco88 == 3430)
	quietly replace isei=54 if (isco88 == 3431)
	quietly replace isei=59 if (isco88 == 3432)
	quietly replace isei=51 if (isco88 == 3433)
	quietly replace isei=61 if (isco88 == 3434)
	quietly replace isei=54 if (isco88 == 3439)
	quietly replace isei=56 if (isco88 == 3440)
	quietly replace isei=56 if (isco88 == 3441)
	quietly replace isei=57 if (isco88 == 3442)
	quietly replace isei=56 if (isco88 == 3443)
	quietly replace isei=46 if (isco88 == 3444)
	quietly replace isei=56 if (isco88 == 3449)
	quietly replace isei=56 if (isco88 == 3450)
	quietly replace isei=55 if (isco88 == 3451)
	quietly replace isei=56 if (isco88 == 3452)
	quietly replace isei=43 if (isco88 == 3460)
	quietly replace isei=52 if (isco88 == 3470)
	quietly replace isei=53 if (isco88 == 3471)
	quietly replace isei=64 if (isco88 == 3472)
	quietly replace isei=50 if (isco88 == 3473)
	quietly replace isei=50 if (isco88 == 3474)
	quietly replace isei=54 if (isco88 == 3475)
	quietly replace isei=38 if (isco88 == 3480)
	quietly replace isei=45 if (isco88 == 4000)
	quietly replace isei=45 if (isco88 == 4100)
	quietly replace isei=51 if (isco88 == 4110)
	quietly replace isei=51 if (isco88 == 4111)
	quietly replace isei=50 if (isco88 == 4112)
	quietly replace isei=50 if (isco88 == 4113)
	quietly replace isei=51 if (isco88 == 4114)
	quietly replace isei=53 if (isco88 == 4115)
	quietly replace isei=51 if (isco88 == 4120)
	quietly replace isei=51 if (isco88 == 4121)
	quietly replace isei=51 if (isco88 == 4122)
	quietly replace isei=36 if (isco88 == 4130)
	quietly replace isei=32 if (isco88 == 4131)
	quietly replace isei=43 if (isco88 == 4132)
	quietly replace isei=45 if (isco88 == 4133)
	quietly replace isei=39 if (isco88 == 4140)
	quietly replace isei=39 if (isco88 == 4141)
	quietly replace isei=39 if (isco88 == 4142)
	quietly replace isei=39 if (isco88 == 4143)
	quietly replace isei=39 if (isco88 == 4144)
	quietly replace isei=39 if (isco88 == 4190)
	quietly replace isei=49 if (isco88 == 4200)
	quietly replace isei=48 if (isco88 == 4210)
	quietly replace isei=53 if (isco88 == 4211)
	quietly replace isei=46 if (isco88 == 4212)
	quietly replace isei=40 if (isco88 == 4213)
	quietly replace isei=40 if (isco88 == 4214)
	quietly replace isei=40 if (isco88 == 4215)
	quietly replace isei=52 if (isco88 == 4220)
	quietly replace isei=52 if (isco88 == 4221)
	quietly replace isei=52 if (isco88 == 4222)
	quietly replace isei=52 if (isco88 == 4223)
	quietly replace isei=40 if (isco88 == 5000)
	quietly replace isei=38 if (isco88 == 5100)
	quietly replace isei=34 if (isco88 == 5110)
	quietly replace isei=34 if (isco88 == 5111)
	quietly replace isei=34 if (isco88 == 5112)
	quietly replace isei=34 if (isco88 == 5113)
	quietly replace isei=32 if (isco88 == 5120)
	quietly replace isei=30 if (isco88 == 5121)
	quietly replace isei=30 if (isco88 == 5122)
	quietly replace isei=34 if (isco88 == 5123)
	quietly replace isei=25 if (isco88 == 5130)
	quietly replace isei=25 if (isco88 == 5131)
	quietly replace isei=25 if (isco88 == 5132)
	quietly replace isei=25 if (isco88 == 5133)
	quietly replace isei=25 if (isco88 == 5139)
	quietly replace isei=30 if (isco88 == 5140)
	quietly replace isei=29 if (isco88 == 5141)
	quietly replace isei=19 if (isco88 == 5142)
	quietly replace isei=54 if (isco88 == 5143)
	quietly replace isei=19 if (isco88 == 5149)
	quietly replace isei=43 if (isco88 == 5150)
	quietly replace isei=43 if (isco88 == 5151)
	quietly replace isei=43 if (isco88 == 5152)
	quietly replace isei=47 if (isco88 == 5160)
	quietly replace isei=42 if (isco88 == 5161)
	quietly replace isei=50 if (isco88 == 5162)
	quietly replace isei=40 if (isco88 == 5163)
	quietly replace isei=40 if (isco88 == 5164)
	quietly replace isei=40 if (isco88 == 5169)
	quietly replace isei=43 if (isco88 == 5200)
	quietly replace isei=43 if (isco88 == 5210)
	quietly replace isei=43 if (isco88 == 5220)
	quietly replace isei=37 if (isco88 == 5230)
	quietly replace isei=23 if (isco88 == 6000)
	quietly replace isei=23 if (isco88 == 6100)
	quietly replace isei=23 if (isco88 == 6110)
	quietly replace isei=23 if (isco88 == 6111)
	quietly replace isei=23 if (isco88 == 6112)
	quietly replace isei=23 if (isco88 == 6113)
	quietly replace isei=23 if (isco88 == 6114)
	quietly replace isei=23 if (isco88 == 6120)
	quietly replace isei=23 if (isco88 == 6121)
	quietly replace isei=23 if (isco88 == 6122)
	quietly replace isei=23 if (isco88 == 6123)
	quietly replace isei=23 if (isco88 == 6124)
	quietly replace isei=23 if (isco88 == 6129)
	quietly replace isei=23 if (isco88 == 6130)
	quietly replace isei=23 if (isco88 == 6131)
	quietly replace isei=27 if (isco88 == 6132)
	quietly replace isei=28 if (isco88 == 6133)
	quietly replace isei=28 if (isco88 == 6134)
	quietly replace isei=22 if (isco88 == 6140)
	quietly replace isei=22 if (isco88 == 6141)
	quietly replace isei=22 if (isco88 == 6142)
	quietly replace isei=28 if (isco88 == 6150)
	quietly replace isei=28 if (isco88 == 6151)
	quietly replace isei=28 if (isco88 == 6152)
	quietly replace isei=28 if (isco88 == 6153)
	quietly replace isei=28 if (isco88 == 6154)
	quietly replace isei=16 if (isco88 == 6200)
	quietly replace isei=16 if (isco88 == 6210)
	quietly replace isei=34 if (isco88 == 7000)
	quietly replace isei=31 if (isco88 == 7100)
	quietly replace isei=30 if (isco88 == 7110)
	quietly replace isei=30 if (isco88 == 7111)
	quietly replace isei=30 if (isco88 == 7112)
	quietly replace isei=27 if (isco88 == 7113)
	quietly replace isei=30 if (isco88 == 7120)
	quietly replace isei=29 if (isco88 == 7121)
	quietly replace isei=29 if (isco88 == 7122)
	quietly replace isei=26 if (isco88 == 7123)
	quietly replace isei=29 if (isco88 == 7124)
	quietly replace isei=30 if (isco88 == 7129)
	quietly replace isei=34 if (isco88 == 7130)
	quietly replace isei=19 if (isco88 == 7131)
	quietly replace isei=30 if (isco88 == 7132)
	quietly replace isei=31 if (isco88 == 7133)
	quietly replace isei=34 if (isco88 == 7134)
	quietly replace isei=26 if (isco88 == 7135)
	quietly replace isei=33 if (isco88 == 7136)
	quietly replace isei=37 if (isco88 == 7137)
	quietly replace isei=29 if (isco88 == 7140)
	quietly replace isei=29 if (isco88 == 7141)
	quietly replace isei=32 if (isco88 == 7142)
	quietly replace isei=29 if (isco88 == 7143)
	quietly replace isei=34 if (isco88 == 7200)
	quietly replace isei=31 if (isco88 == 7210)
	quietly replace isei=29 if (isco88 == 7211)
	quietly replace isei=30 if (isco88 == 7212)
	quietly replace isei=33 if (isco88 == 7213)
	quietly replace isei=30 if (isco88 == 7214)
	quietly replace isei=30 if (isco88 == 7215)
	quietly replace isei=30 if (isco88 == 7216)
	quietly replace isei=35 if (isco88 == 7220)
	quietly replace isei=33 if (isco88 == 7221)
	quietly replace isei=40 if (isco88 == 7222)
	quietly replace isei=34 if (isco88 == 7223)
	quietly replace isei=24 if (isco88 == 7224)
	quietly replace isei=34 if (isco88 == 7230)
	quietly replace isei=34 if (isco88 == 7231)
	quietly replace isei=42 if (isco88 == 7232)
	quietly replace isei=33 if (isco88 == 7233)
	quietly replace isei=23 if (isco88 == 7234)
	quietly replace isei=40 if (isco88 == 7240)
	quietly replace isei=40 if (isco88 == 7241)
	quietly replace isei=39 if (isco88 == 7242)
	quietly replace isei=41 if (isco88 == 7243)
	quietly replace isei=40 if (isco88 == 7244)
	quietly replace isei=38 if (isco88 == 7245)
	quietly replace isei=34 if (isco88 == 7300)
	quietly replace isei=38 if (isco88 == 7310)
	quietly replace isei=38 if (isco88 == 7311)
	quietly replace isei=38 if (isco88 == 7312)
	quietly replace isei=38 if (isco88 == 7313)
	quietly replace isei=28 if (isco88 == 7320)
	quietly replace isei=27 if (isco88 == 7321)
	quietly replace isei=29 if (isco88 == 7322)
	quietly replace isei=29 if (isco88 == 7323)
	quietly replace isei=29 if (isco88 == 7324)
	quietly replace isei=29 if (isco88 == 7330)
	quietly replace isei=29 if (isco88 == 7331)
	quietly replace isei=29 if (isco88 == 7332)
	quietly replace isei=40 if (isco88 == 7340)
	quietly replace isei=40 if (isco88 == 7341)
	quietly replace isei=40 if (isco88 == 7342)
	quietly replace isei=42 if (isco88 == 7343)
	quietly replace isei=40 if (isco88 == 7344)
	quietly replace isei=37 if (isco88 == 7345)
	quietly replace isei=38 if (isco88 == 7346)
	quietly replace isei=33 if (isco88 == 7400)
	quietly replace isei=30 if (isco88 == 7410)
	quietly replace isei=30 if (isco88 == 7411)
	quietly replace isei=31 if (isco88 == 7412)
	quietly replace isei=30 if (isco88 == 7413)
	quietly replace isei=30 if (isco88 == 7414)
	quietly replace isei=30 if (isco88 == 7415)
	quietly replace isei=30 if (isco88 == 7416)
	quietly replace isei=33 if (isco88 == 7420)
	quietly replace isei=33 if (isco88 == 7421)
	quietly replace isei=33 if (isco88 == 7422)
	quietly replace isei=33 if (isco88 == 7423)
	quietly replace isei=33 if (isco88 == 7424)
	quietly replace isei=36 if (isco88 == 7430)
	quietly replace isei=29 if (isco88 == 7431)
	quietly replace isei=29 if (isco88 == 7432)
	quietly replace isei=45 if (isco88 == 7433)
	quietly replace isei=36 if (isco88 == 7434)
	quietly replace isei=36 if (isco88 == 7435)
	quietly replace isei=33 if (isco88 == 7436)
	quietly replace isei=28 if (isco88 == 7437)
	quietly replace isei=31 if (isco88 == 7440)
	quietly replace isei=31 if (isco88 == 7441)
	quietly replace isei=31 if (isco88 == 7442)
	quietly replace isei=42 if (isco88 == 7500)
	quietly replace isei=42 if (isco88 == 7510)
	quietly replace isei=39 if (isco88 == 7520)
	quietly replace isei=26 if (isco88 == 7530)
	quietly replace isei=31 if (isco88 == 8000)
	quietly replace isei=30 if (isco88 == 8100)
	quietly replace isei=35 if (isco88 == 8110)
	quietly replace isei=35 if (isco88 == 8111)
	quietly replace isei=35 if (isco88 == 8112)
	quietly replace isei=35 if (isco88 == 8113)
	quietly replace isei=30 if (isco88 == 8120)
	quietly replace isei=31 if (isco88 == 8121)
	quietly replace isei=30 if (isco88 == 8122)
	quietly replace isei=28 if (isco88 == 8123)
	quietly replace isei=30 if (isco88 == 8124)
	quietly replace isei=22 if (isco88 == 8130)
	quietly replace isei=22 if (isco88 == 8131)
	quietly replace isei=22 if (isco88 == 8139)
	quietly replace isei=27 if (isco88 == 8140)
	quietly replace isei=27 if (isco88 == 8141)
	quietly replace isei=27 if (isco88 == 8142)
	quietly replace isei=27 if (isco88 == 8143)
	quietly replace isei=35 if (isco88 == 8150)
	quietly replace isei=35 if (isco88 == 8151)
	quietly replace isei=35 if (isco88 == 8152)
	quietly replace isei=35 if (isco88 == 8153)
	quietly replace isei=35 if (isco88 == 8154)
	quietly replace isei=35 if (isco88 == 8155)
	quietly replace isei=35 if (isco88 == 8159)
	quietly replace isei=32 if (isco88 == 8160)
	quietly replace isei=33 if (isco88 == 8161)
	quietly replace isei=27 if (isco88 == 8162)
	quietly replace isei=33 if (isco88 == 8163)
	quietly replace isei=26 if (isco88 == 8170)
	quietly replace isei=26 if (isco88 == 8171)
	quietly replace isei=26 if (isco88 == 8172)
	quietly replace isei=32 if (isco88 == 8200)
	quietly replace isei=36 if (isco88 == 8210)
	quietly replace isei=36 if (isco88 == 8211)
	quietly replace isei=30 if (isco88 == 8212)
	quietly replace isei=30 if (isco88 == 8220)
	quietly replace isei=30 if (isco88 == 8221)
	quietly replace isei=30 if (isco88 == 8222)
	quietly replace isei=30 if (isco88 == 8223)
	quietly replace isei=30 if (isco88 == 8224)
	quietly replace isei=30 if (isco88 == 8229)
	quietly replace isei=30 if (isco88 == 8230)
	quietly replace isei=30 if (isco88 == 8231)
	quietly replace isei=30 if (isco88 == 8232)
	quietly replace isei=29 if (isco88 == 8240)
	quietly replace isei=38 if (isco88 == 8250)
	quietly replace isei=38 if (isco88 == 8251)
	quietly replace isei=38 if (isco88 == 8252)
	quietly replace isei=38 if (isco88 == 8253)
	quietly replace isei=30 if (isco88 == 8260)
	quietly replace isei=29 if (isco88 == 8261)
	quietly replace isei=29 if (isco88 == 8262)
	quietly replace isei=32 if (isco88 == 8263)
	quietly replace isei=24 if (isco88 == 8264)
	quietly replace isei=32 if (isco88 == 8265)
	quietly replace isei=32 if (isco88 == 8266)
	quietly replace isei=32 if (isco88 == 8269)
	quietly replace isei=29 if (isco88 == 8270)
	quietly replace isei=29 if (isco88 == 8271)
	quietly replace isei=29 if (isco88 == 8272)
	quietly replace isei=29 if (isco88 == 8273)
	quietly replace isei=29 if (isco88 == 8274)
	quietly replace isei=29 if (isco88 == 8275)
	quietly replace isei=29 if (isco88 == 8276)
	quietly replace isei=29 if (isco88 == 8277)
	quietly replace isei=29 if (isco88 == 8278)
	quietly replace isei=29 if (isco88 == 8279)
	quietly replace isei=31 if (isco88 == 8280)
	quietly replace isei=30 if (isco88 == 8281)
	quietly replace isei=34 if (isco88 == 8282)
	quietly replace isei=34 if (isco88 == 8283)
	quietly replace isei=30 if (isco88 == 8284)
	quietly replace isei=30 if (isco88 == 8285)
	quietly replace isei=30 if (isco88 == 8286)
	quietly replace isei=26 if (isco88 == 8290)
	quietly replace isei=32 if (isco88 == 8300)
	quietly replace isei=36 if (isco88 == 8310)
	quietly replace isei=41 if (isco88 == 8311)
	quietly replace isei=32 if (isco88 == 8312)
	quietly replace isei=34 if (isco88 == 8320)
	quietly replace isei=30 if (isco88 == 8321)
	quietly replace isei=30 if (isco88 == 8322)
	quietly replace isei=30 if (isco88 == 8323)
	quietly replace isei=34 if (isco88 == 8324)
	quietly replace isei=26 if (isco88 == 8330)
	quietly replace isei=26 if (isco88 == 8331)
	quietly replace isei=26 if (isco88 == 8332)
	quietly replace isei=28 if (isco88 == 8333)
	quietly replace isei=28 if (isco88 == 8334)
	quietly replace isei=32 if (isco88 == 8340)
	quietly replace isei=24 if (isco88 == 8400)
	quietly replace isei=20 if (isco88 == 9000)
	quietly replace isei=25 if (isco88 == 9100)
	quietly replace isei=29 if (isco88 == 9110)
	quietly replace isei=29 if (isco88 == 9111)
	quietly replace isei=28 if (isco88 == 9112)
	quietly replace isei=29 if (isco88 == 9113)
	quietly replace isei=28 if (isco88 == 9120)
	quietly replace isei=16 if (isco88 == 9130)
	quietly replace isei=16 if (isco88 == 9131)
	quietly replace isei=16 if (isco88 == 9132)
	quietly replace isei=16 if (isco88 == 9133)
	quietly replace isei=23 if (isco88 == 9140)
	quietly replace isei=23 if (isco88 == 9141)
	quietly replace isei=23 if (isco88 == 9142)
	quietly replace isei=27 if (isco88 == 9150)
	quietly replace isei=25 if (isco88 == 9151)
	quietly replace isei=27 if (isco88 == 9152)
	quietly replace isei=27 if (isco88 == 9153)
	quietly replace isei=23 if (isco88 == 9160)
	quietly replace isei=23 if (isco88 == 9161)
	quietly replace isei=23 if (isco88 == 9162)
	quietly replace isei=16 if (isco88 == 9200)
	quietly replace isei=16 if (isco88 == 9210)
	quietly replace isei=16 if (isco88 == 9211)
	quietly replace isei=16 if (isco88 == 9212)
	quietly replace isei=16 if (isco88 == 9213)
	quietly replace isei=23 if (isco88 == 9300)
	quietly replace isei=21 if (isco88 == 9310)
	quietly replace isei=21 if (isco88 == 9311)
	quietly replace isei=21 if (isco88 == 9312)
	quietly replace isei=21 if (isco88 == 9313)
	quietly replace isei=20 if (isco88 == 9320)
	quietly replace isei=20 if (isco88 == 9321)
	quietly replace isei=24 if (isco88 == 9322)
	quietly replace isei=29 if (isco88 == 9330)
	quietly replace isei=22 if (isco88 == 9331)
	quietly replace isei=22 if (isco88 == 9332)
	quietly replace isei=30 if (isco88 == 9333)
	save 2018,replace

// gen 2018 isco88 isei
//use 2020,clear
//merge m:1 qg303code_g using CSCO_ISCO_2020.dta




//--------------------------*generate party variable--------------------
use 2010,clear
gen party=.
replace party=1 if qa7_s_1==1
replace party=0 if qa7_s_1>0 & qa7_s_1!=1
save 2010,replace

use 2012,clear
gen party=.
replace party=1 if qn401_s_1==1
replace party=0 if qn401_s_1>0 & qn401_s_1!=1
save 2012,replace

use 2014,clear
gen party=.
replace party=1 if qn401_s_1==1
replace party=0 if qn401_s_1>0 & qn401_s_1!=1
save 2014,replace

use 2016,clear
gen party=.
replace party=1 if qn4001==1
replace party=0 if qn4001>0 & qn4001!=1
save 2016,replace

use 2018,clear
replace party=1 if qn4001==1
save 2018,replace


//--------------------------*generate&rename control varaibles----------------
cd "$path\data"
use 2010,clear
keep pid cfps2010edu_best cfps2010eduy_best gender urban qa5code qa1age party
rename (cfps2010edu_best cfps2010eduy_best gender urban qa5code qa1age party)(edu_2010 eduy_2010 gender_2010 urban_2010 minzu_2010 age_2010 party_2010)
save "2010_control",replace

use 2012,clear
keep pid edu2012 eduy2012 cfps2012_gender_best urban12 qa701code cfps2012_age party
rename (edu2012 eduy2012 cfps2012_gender_best urban12 qa701code cfps2012_age party)(edu_2012 eduy_2012 gender_2012 urban_2012 minzu_2012 age_2012 party_2012)
save "2012_control",replace

use 2014,clear
keep pid cfps2014edu cfps2014eduy_im cfps_gender urban14 qa701code cfps2014_age party
rename (cfps2014edu cfps2014eduy_im cfps_gender urban14 qa701code cfps2014_age party)(edu_2014 eduy_2014 gender_2014 urban_2014 minzu_2014 age_2014 party_2014)
save "2014_control",replace

use 2016,clear
keep pid cfps2016edu cfps2016eduy_im cfps_gender urban16 pa701code cfps_age party
rename (cfps2016edu cfps2016eduy_im cfps_gender urban16 pa701code cfps_age party)(edu_2016 eduy_2016 gender_2016 urban_2016 minzu_2016 age_2016 party_2016)
save "2016_control",replace

use 2018,clear
keep pid cfps2018edu cfps2018eduy_im gender urban18 qa701code age party
rename (cfps2018edu cfps2018eduy_im gender urban18 qa701code age party)(edu_2018 eduy_2018 gender_2018 urban_2018 minzu_2018 age_2018 party_2018)
save "2018_control",replace



*-----------fill the later year edu/eduy/gender/urban/minzu/age/party-------
use 2012,clear
merge 1:1 pid using 2010_control
drop if _merge==2
replace edu2012=edu_2010 if edu2012==. & edu_2010~=.
replace eduy2012=eduy_2010 if eduy2012==. & eduy_2010~=.
replace cfps2012_gender_best=gender_2010 if cfps2012_gender_best==.& gender_2010 ~=.
replace urban12=urban_2010 if urban12==-9 & urban_2010~=.
replace qa701code=minzu_2010 if qa701code==. & minzu_2010~=.
replace cfps2012_age=age_2010+2 if cfps2012_age==. & age_2010~=.
replace party=party_2010 if party==. & party_2010~=.
drop _merge edu_2010 eduy_2010 gender_2010 urban_2010 minzu_2010 age_2010 party_2010
save 2012_adj,replace
*------------------------------------------
use 2014,clear
merge 1:1 pid using 2012_control
drop if _merge==2
replace cfps2014edu=edu_2012 if (cfps2014edu==. & edu_2012~=. & edu_2012>=0)|(cfps2014edu==-9 & edu_2012~=. & edu_2012>=0)
replace cfps2014eduy_im=eduy_2012 if (cfps2014eduy_im==. & eduy_2012~=. & eduy_2012>=0)|(cfps2014eduy_im==-9 & eduy_2012~=. & eduy_2012>=0)
replace cfps_gender=gender_2012 if cfps_gender==.& gender_2012 ~=.
replace urban14=urban_2012 if (urban14==. & urban_2012~=. & urban_2012>=0)|(urban14==-9 & urban_2012~=. & urban_2012>=0)
replace qa701code=minzu_2012 if (qa701code==. & minzu_2012~=. & minzu_2012>=0)|(qa701code==-8 & minzu_2012~=. & minzu_2012>=0)
replace cfps2014_age=age_2012+2 if cfps2014_age==. & age_2012~=.
replace party=party_2012 if party==. & party_2012~=.
drop _merge edu_2012 eduy_2012 gender_2012 urban_2012 minzu_2012 age_2012 party_2012

merge 1:1 pid using 2010_control
drop if _merge==2
replace cfps2014edu=edu_2010 if (cfps2014edu==. & edu_2010~=. & edu_2010>=0)|(cfps2014edu==-9 & edu_2010~=. & edu_2010>=0)
replace cfps2014eduy_im=eduy_2010 if (cfps2014eduy_im==. & eduy_2010~=. & eduy_2010>=0)|(cfps2014eduy_im==-9 & eduy_2010~=. & eduy_2010>=0)
replace cfps_gender=gender_2010 if cfps_gender==.& gender_2010 ~=.
replace urban14=urban_2010 if (urban14==. & urban_2010~=. & urban_2010>=0)|(urban14==-9 & urban_2010~=. & urban_2010>=0)
replace qa701code=minzu_2010 if (qa701code==. & minzu_2010~=. & minzu_2010>=0)|(qa701code==-8 & minzu_2010~=. & minzu_2010>=0)
replace cfps2014_age=age_2010+2 if cfps2014_age==. & age_2010~=.
replace party=party_2010 if party==. & party_2010~=.
drop _merge edu_2010 eduy_2010 gender_2010 urban_2010 minzu_2010 age_2010 party_2010
save 2014_adj,replace
*------------------------------------------
use 2016,clear
merge 1:1 pid using 2014_control
drop if _merge==2
replace cfps2016edu=edu_2014 if cfps2016edu==. & edu_2014~=.
replace cfps2016eduy_im=eduy_2014 if cfps2016eduy_im==. & eduy_2014~=.
replace cfps_gender=gender_2014 if cfps_gender==.& gender_2014 ~=.
replace urban16=urban_2014 if (urban16==. & urban_2014~=. & urban_2014>=0)|(urban16==-9 & urban_2014~=. & urban_2014>=0)
replace pa701code=minzu_2014 if (pa701code==. & minzu_2014~=. & minzu_2014>=0)|(pa701code==-8 & minzu_2014~=. & minzu_2014>=0)
replace cfps_age=age_2014+2 if cfps_age==. & age_2014~=.
replace party=party_2014 if party==. & party_2014~=.
drop _merge edu_2014 eduy_2014 gender_2014 urban_2014 minzu_2014 age_2014 party_2014

merge 1:1 pid using 2012_control
drop if _merge==2
replace cfps2016edu=edu_2012 if cfps2016edu==. & edu_2012~=.
replace cfps2016eduy_im=eduy_2012 if cfps2016eduy_im==. & eduy_2012~=.
replace cfps_gender=gender_2012 if cfps_gender==.& gender_2012 ~=.
replace urban16=urban_2012 if (urban16==. & urban_2012~=. & urban_2012>=0)|(urban16==-9 & urban_2012~=. & urban_2012>=0)
replace pa701code=minzu_2012 if (pa701code==. & minzu_2012~=. & minzu_2012>=0)|(pa701code==-8 & minzu_2012~=. & minzu_2012>=0)
replace cfps_age=age_2012+2 if cfps_age==. & age_2012~=.
replace party=party_2012 if party==. & party_2012~=.
drop _merge edu_2012 eduy_2012 gender_2012 urban_2012 minzu_2012 age_2012 party_2012

merge 1:1 pid using 2010_control
drop if _merge==2
replace cfps2016edu=edu_2010 if cfps2016edu==. & edu_2010~=.
replace cfps2016eduy_im=eduy_2010 if cfps2016eduy_im==. & eduy_2010~=.
replace cfps_gender=gender_2010 if cfps_gender==.& gender_2010 ~=.
replace urban16=urban_2010 if (urban16==. & urban_2010~=. & urban_2010>=0)|(urban16==-9 & urban_2010~=. & urban_2010>=0)
replace pa701code=minzu_2010 if (pa701code==. & minzu_2010~=. & minzu_2010>=0)|(pa701code==-8 & minzu_2010~=. & minzu_2010>=0)
replace cfps_age=age_2010+2 if cfps_age==. & age_2010~=.
replace party=party_2010 if party==. & party_2010~=.
drop _merge edu_2010 eduy_2010 gender_2010 urban_2010 minzu_2010 age_2010 party_2010
save 2016_adj,replace
*------------------------------------------
use 2018,clear
merge 1:1 pid using 2016_control
drop if _merge==2
replace cfps2018edu=edu_2016 if cfps2018edu==. & edu_2016~=.
replace cfps2018eduy_im=eduy_2016 if cfps2018eduy_im==. & eduy_2016~=.
replace gender=gender_2016 if gender==.& gender_2016 ~=.
replace urban18=urban_2016 if (urban18==. & urban_2016~=. & urban_2016>=0)|(urban18==-9 & urban_2016~=. & urban_2016>=0)
replace qa701code=minzu_2016 if (qa701code==. & minzu_2016~=. & minzu_2016>=0)|(qa701code==-8 & minzu_2016~=. & minzu_2016>=0)
replace age=age_2016+2 if age==. & age_2016~=.
replace party=party_2016 if party==-8 & party_2016~=.
drop _merge edu_2016 eduy_2016 gender_2016 urban_2016 minzu_2016 age_2016 party_2016

merge 1:1 pid using 2014_control
drop if _merge==2
replace cfps2018edu=edu_2014 if cfps2018edu==. & edu_2014~=.
replace cfps2018eduy_im=eduy_2014 if cfps2018eduy_im==. & eduy_2014~=.
replace gender=gender_2014 if gender==.& gender_2014 ~=.
replace urban18=urban_2014 if (urban18==. & urban_2014~=. & urban_2014>=0)|(urban18==-9 & urban_2014~=. & urban_2014>=0)
replace qa701code=minzu_2014 if (qa701code==. & minzu_2014~=. & minzu_2014>=0)|(qa701code==-8 & minzu_2014~=. & minzu_2014>=0)
replace age=age_2014+2 if age==. & age_2014~=.
replace party=party_2014 if party==-8 & party_2014~=.
drop _merge edu_2014 eduy_2014 gender_2014 urban_2014 minzu_2014 age_2014 party_2014

merge 1:1 pid using 2012_control
drop if _merge==2
replace cfps2018edu=edu_2012 if cfps2018edu==. & edu_2012~=.
replace cfps2018eduy_im=eduy_2012 if cfps2018eduy_im==. & eduy_2012~=.
replace gender=gender_2012 if gender==.& gender_2012 ~=.
replace urban18=urban_2012 if (urban18==. & urban_2012~=. & urban_2012>=0)|(urban18==-9 & urban_2012~=. & urban_2012>=0)
replace qa701code=minzu_2012 if (qa701code==. & minzu_2012~=. & minzu_2012>=0)|(qa701code==-8 & minzu_2012~=. & minzu_2012>=0)
replace age=age_2012+2 if age==. & age_2012~=.
replace party=party_2012 if party==-8 & party_2012~=.
drop _merge edu_2012 eduy_2012 gender_2012 urban_2012 minzu_2012 age_2012 party_2012

merge 1:1 pid using 2010_control
drop if _merge==2
replace cfps2018edu=edu_2010 if cfps2018edu==. & edu_2010~=.
replace cfps2018eduy_im=eduy_2010 if cfps2018eduy_im==. & eduy_2010~=.
replace gender=gender_2010 if gender==.& gender_2010 ~=.
replace urban18=urban_2010 if (urban18==. & urban_2010~=. & urban_2010>=0)|(urban18==-9 & urban_2010~=. & urban_2010>=0)
replace qa701code=minzu_2010 if (qa701code==. & minzu_2010~=. & minzu_2010>=0)|(qa701code==-8 & minzu_2010~=. & minzu_2010>=0)
replace age=age_2010+2 if age==. & age_2010~=.
replace party=party_2010 if party==-8 & party_2010~=.
drop _merge edu_2010 eduy_2010 gender_2010 urban_2010 minzu_2010 age_2010 party_2010
save 2018_adj,replace


//--------------------*认知能力 和非认知能力变量--------------------
use 2010,clear
egen wordtest_std = std(wordtest)
egen mathtest_std = std(mathtest)
egen comprehension_std=std(qz201)
egen coordinate_std=std(qz206)
egen manner_std=std(qz208)
egen credibility_std=std(qz211)
egen expression_std=std(qz212)
gen non_cognitive=(comprehension_std+coordinate_std+manner_std+credibility_std+expression_std)/5
save 2010,replace

use 2012,clear
egen dwr_std = std(dwr)
egen ns_w_std = std(ns_w)
egen comprehension_std=std(qz201)
egen coordinate_std=std(qz206)
egen manner_std=std(qz208)
egen credibility_std=std(qz211)
egen expression_std=std(qz212)
gen non_cognitive=(comprehension_std+coordinate_std+manner_std+credibility_std+expression_std)/5
save 2012,replace

use 2014,clear
egen wordtest_std = std(wordtest14)
egen mathtest_std = std(mathtest14)
egen comprehension_std=std(qz201)
egen coordinate_std=std(qz206)
egen manner_std=std(qz208)
egen credibility_std=std(qz211)
egen expression_std=std(qz212)
gen non_cognitive=(comprehension_std+coordinate_std+manner_std+credibility_std+expression_std)/5
save 2014,replace

use 2016,clear
egen dwr_std = std(dwr)
egen ns_w_std = std(ns_w)
egen comprehension_std=std(qz201)
egen coordinate_std=std(qz206)
egen manner_std=std(qz208)
egen credibility_std=std(qz211)
egen expression_std=std(qz212)
gen non_cognitive=(comprehension_std+coordinate_std+manner_std+credibility_std+expression_std)/5
save 2016,replace
