**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table IV in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************

#delimit;
clear;
set mem 100m;
set more off;



log using Appendix_TableIV.log, replace;


**********************;
*** LOGISTIC(GINI) ***;
**********************;
muse macro_workfile.dta, s w c 
generate y = log(gini/(1-gini));
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

muse macro_workfile.dta, s w c 
generate y = log(gini/(1-gini));
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

muse macro_workfile.dta, s w c 
generate y = log(gini/(1-gini));
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


*****************;
*** LOG(GINI) ***;
*****************;
muse macro_workfile.dta, s w c 
generate y = log(gini);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

muse macro_workfile.dta, s w c 
generate y = log(gini);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

muse macro_workfile.dta, s w c 
generate y = log(gini);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(THEIL) ***;
******************;
muse macro_workfile.dta, s w c 
generate y = log(theil);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

muse macro_workfile.dta, s w c 
generate y = log(theil);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

muse macro_workfile.dta, s w c 
generate y = log(theil);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(90/10) ***;
******************;
muse macro_workfile.dta, s w c 
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

muse macro_workfile.dta, s w c 
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

muse macro_workfile.dta, s w c 
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(75/25) ***;
******************;
muse macro_workfile.dta, s w c 
generate y = log(p75)-log(p25);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

muse macro_workfile.dta, s w c 
generate y = log(p75)-log(p25);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

muse macro_workfile.dta, s w c 
generate y = log(p75)-log(p25);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


log close;










**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table V in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************

#delimit;
clear;
set mem 2g;
set more off;



log using Appendix_TableV.log, replace;

muse micro_workfile.dta, s w c
keep if main_sample == 1;

*** drop the unemployed ***;
drop if empstat==20;
drop if empstat==21;
drop if empstat==22;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial;
generate Y = _inctot_cpi_tr0199;
save temp, replace;

*****************************;
*** Different percentiles ***;
*****************************;
use temp, clear;

collapse 
(p10)  p10=Y
(p25)  p25=Y
(p50)  p50=Y
(p75)  p75=Y
(p90)  p90=Y
[pw=_perwt], by(statefip wrkyr);
sort statefip wrkyr;
save percentiles, replace;

***********************************;
*** More measures of inequality ***;
***********************************;
use temp, clear;
replace  Y = 1 if Y == 0; 

egen gini    = inequal(Y), by(statefip wrkyr) weights(_perwt) index(gini);
egen theil   = inequal(Y), by(statefip wrkyr) weights(_perwt) index(theil);

keep statefip wrkyr gini theil;
duplicates drop;
drop if gini==.;
sort statefip wrkyr;
merge statefip wrkyr using percentiles;
drop _merge*;
sort statefip wrkyr;
save temp, replace;


muse macro_workfile.dta, s w c 
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);

xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);

xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);

xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);

xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);


estout m1 m2 m3 m4 m5 using Appendix_TableV.txt, replace
keep(_intra)
cells(b(fmt(3)) se(star par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Income Inequality:" "Excluding the Unemployed")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
log close;









**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table VI in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set matsize 10000;
set more off;



log using Appendix_TableVI.log, replace;

muse macro_workfile.dta, s w c 

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);
xtreg logistic_gini wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);
xtreg log_gini wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);
xtreg log_theil wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);
xtreg log_9010 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);
xtreg log_7525 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);


*** Bootstraped standard errors ***;
bootstrap, reps(500): regress logistic_gini _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_gini      _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_theil     _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_9010      _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_7525      _intra  wrkyr_dumm* state_dumm*;


*** SUR standard errors ***;
sureg (logistic_gini _intra wrkyr_dumm* state_dumm*)
      (log_gini      _intra wrkyr_dumm* state_dumm*)
      (log_theil     _intra wrkyr_dumm* state_dumm*)
      (log_9010      _intra wrkyr_dumm* state_dumm*)
      (log_7525      _intra wrkyr_dumm* state_dumm*);
      
estout m1 m2 m3 m4 m5 using Appendix_TableVI.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Income Inequality" "Robustness to Standard Errors")
posthead("Panel A: No controls")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


xtreg logistic_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);

xtreg log_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);

xtreg log_theil _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);

xtreg log_9010 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);

xtreg log_7525 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);


*** Bootstraped standard errors ***;
bootstrap, reps(500): regress logistic_gini _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_gini      _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_theil     _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_9010      _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_7525      _intra `Xs' wrkyr_dumm* state_dumm*;


*** SUR standard errors ***;
sureg (logistic_gini _intra `Xs' wrkyr_dumm* state_dumm*)
      (log_gini      _intra `Xs' wrkyr_dumm* state_dumm*) 
      (log_theil     _intra `Xs' wrkyr_dumm* state_dumm*)
      (log_9010      _intra `Xs' wrkyr_dumm* state_dumm*) 
      (log_7525      _intra `Xs' wrkyr_dumm* state_dumm*);


estout m1 m2 m3 m4 m5 using Appendix_TableVI.txt, append
keep(_intra `Xs')
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
posthead("Panel B: With controls")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

log close;







**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table VII in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************

clear
set mem 2g
set more off


log using Appendix_TableVII.log, replace


*****************************************************************
*** AGES 18-64 **************************************************
*****************************************************************
*作者未提供数据
clear
infix ///
 int     year                                 1-4 ///
 long    serial                               5-9 ///
 float  hhwt                                10-16 ///
 float  hhwt04                              17-24 ///
 byte    gq                                  25 ///
 byte    statefip                            26-27 ///
 long    hhincome                            28-34 ///
 float  perwt                               35-42 ///
 float  perwt04                             43-50 ///
 int     relate                              51-54 ///
 byte    age                                 55-56 ///
 byte    sex                                 57 ///
 int     race                                58-60 ///
 int     hispan                              61-63 ///
 byte    educ99                              64-65 ///
 int     higrade                             66-68 ///
 byte    educrec                             69-70 ///
 byte    empstat                             71-72 ///
 byte    classwly                            73-74 ///
 byte    wkswork1                            75-76 ///
 byte    uhrswork                            77-78 ///
 long    inctot                              79-84 ///
 long    incwage                             85-90 ///
 long    incbus                              91-96 ///
 using "/home/alevkov/BeckLevineLevkov2010/data/raw_cps.dat"

replace hhwt=hhwt/100
replace hhwt04=hhwt04/100
replace perwt=perwt/100
replace perwt04=perwt04/100

label var year `"Survey year"'
label var serial `"Household serial number"'
label var hhwt `"Household weight"'
label var hhwt04 `"Household weight 2004"'
label var gq `"Group Quarters status"'
label var statefip `"State (FIPS code)"'
label var hhincome `"Total household income"'
label var perwt `"Person weight"'
label var perwt04 `"Person weight 2004"'
label var relate `"Relationship to household head"'
label var age `"Age"'
label var sex `"Sex"'
label var race `"Race"'
label var hispan `"Hispanic origin"'
label var educ99 `"Educational attainment, 1990"'
label var higrade `"Highest grade of school"'
label var educrec `"Educational attainment recode"'
label var empstat `"Employment status"'
label var classwly `"Class of worker last year"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week (last yr)"'
label var inctot `"Total personal income"'
label var incwage `"Wage and salary income"'
label var incbus `"Non-farm business income"'


#delimit;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


*** Age last year ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;


*** Gender and athnicity ***;
gen     _female = 0 ;
replace _female = 1 if sex == 2 ;
replace _female = . if sex == . ;

gen     _hispanic = 0 ;
replace _hispanic = 1 if hispan >=100 & hispan <=410 ;
replace _hispanic = . if hispan == 901 | hispan == 902 ;

gen _white = 0 ;
gen _black = 0 ;

replace _white = 1 if race == 100 ;
replace _black = 1 if race == 200 ;

replace _white = 0 if _hispanic == 1 ;
replace _black = 0 if _hispanic == 1 ;

label variable _white "1 if person is white and not a Hispanic" ;
label variable _black "1 if person is black and not a Hispanic" ;


*** Female-headed household indicator ***;
generate temp = 0;
replace  temp = 1 if _female == 1 & relate == 101;

bysort statefip wrkyr serial: egen _female_headed = max(temp);
drop temp;
label variable _female_headed "1 if female_headed household";


*** Years of completed education before 1992 ***;
gen _educomp =. ;

replace _educomp = 0 if higrade==10 ;
replace _educomp = 0 if higrade==31 ;

replace _educomp = 1 if higrade==40 ;
replace _educomp = 1 if higrade==41 ;
replace _educomp = 2 if higrade==50 ;
replace _educomp = 2 if higrade==51 ;
replace _educomp = 3 if higrade==60 ;
replace _educomp = 3 if higrade==61 ;
replace _educomp = 4 if higrade==70 ;
replace _educomp = 4 if higrade==71 ;
replace _educomp = 5 if higrade==80 ;
replace _educomp = 5 if higrade==81 ;
replace _educomp = 6 if higrade==90 ;
replace _educomp = 6 if higrade==91 ;

replace _educomp = 7 if higrade==100 ;
replace _educomp = 7 if higrade==101 ;
replace _educomp = 8 if higrade==110 ;
replace _educomp = 8 if higrade==111 ;
replace _educomp = 9 if higrade==120 ;
replace _educomp = 9 if higrade==121 ;

replace _educomp =10 if higrade==130 ;
replace _educomp =10 if higrade==131 ;
replace _educomp =11 if higrade==140 ;
replace _educomp =11 if higrade==141 ;
replace _educomp =12 if higrade==150 ;
replace _educomp =12 if higrade==151 ;
replace _educomp =13 if higrade==160 ;
replace _educomp =13 if higrade==161 ;
replace _educomp =14 if higrade==170 ;
replace _educomp =14 if higrade==171 ;
replace _educomp =15 if higrade==180 ;
replace _educomp =15 if higrade==181 ;
replace _educomp =16 if higrade==190 ;
replace _educomp =16 if higrade==191 ;
replace _educomp =17 if higrade==200 ;
replace _educomp =17 if higrade==201 ;

replace _educomp =18 if higrade==210 ;

replace _educomp =. if higrade==  . ;
replace _educomp =. if higrade==  0 ;
replace _educomp =. if higrade==999 ;


*** Years of completed education after 1992 ***;
gen _race = . ;

replace _race = 1 if race == 100 ;
replace _race = 2 if race == 200 ;
replace _race = 3 if race  > 200 & _race ~=. ;

*** Men, white ***;
replace _educomp = 0.32  	if (_race==1 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.19 	if (_race==1 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.24 	if (_race==1 & _female==0 & (educ99 ==5)) ;
replace _educomp = 8.97 	if (_race==1 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==1 & _female==0 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==1 & _female==0 & educ99 ==8) ;
replace _educomp = 11.58 	if (_race==1 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==1 & _female==0 & educ99 ==10) ;
replace _educomp = 13.48 	if (_race==1 & _female==0 & educ99 ==11) ;
replace _educomp = 14.23 	if (_race==1 & _female==0 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.17 	if (_race==1 & _female==0 & educ99 ==14) ;
replace _educomp = 17.68 	if (_race==1 & _female==0 & educ99 ==15) ;
replace _educomp = 17.71 	if (_race==1 & _female==0 & educ99 ==16) ;
replace _educomp = 17.83 	if (_race==1 & _female==0 & educ99 ==17) ;

*** Women, white ***;
replace _educomp = 0.62 	if (_race==1 & _female==1 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.15 	if (_race==1 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.23 	if (_race==1 & _female==1 & (educ99 ==5)) ;
replace _educomp = 8.99 	if (_race==1 & _female==1 & educ99 == 6) ;
replace _educomp = 9.95 	if (_race==1 & _female==1 & educ99 == 7) ;
replace _educomp = 10.87 	if (_race==1 & _female==1 & educ99 ==8) ;
replace _educomp = 11.73 	if (_race==1 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==1 & _female==1 & educ99 ==10) ;
replace _educomp = 13.35 	if (_race==1 & _female==1 & educ99 ==11) ;
replace _educomp = 14.22 	if (_race==1 & _female==1 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.15 	if (_race==1 & _female==1 & educ99 ==14) ;
replace _educomp = 17.64 	if (_race==1 & _female==1 & educ99 ==15) ;
replace _educomp = 17.00 	if (_race==1 & _female==1 & educ99 ==16) ;
replace _educomp = 17.76 	if (_race==1 & _female==1 & educ99 ==17) ;

*** Men, black ***;
replace _educomp = 0.92  	if (_race==2 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.28 	if (_race==2 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.04 	if (_race==2 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==2 & _female==0 & educ99 == 6) ;
replace _educomp = 9.91 	if (_race==2 & _female==0 & educ99 == 7) ;
replace _educomp = 10.90 	if (_race==2 & _female==0 & educ99 ==8) ;
replace _educomp = 11.41 	if (_race==2 & _female==0 & educ99 ==9) ;
replace _educomp = 11.98 	if (_race==2 & _female==0 & educ99 ==10) ;
replace _educomp = 13.57 	if (_race==2 & _female==0 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.13 	if (_race==2 & _female==0 & educ99 ==14) ;
replace _educomp = 17.51 	if (_race==2 & _female==0 & educ99 ==15) ;
replace _educomp = 17.83 	if (_race==2 & _female==0 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==0 & educ99 ==17) ;

*** Women, black ***;
replace _educomp = 0.00 	if (_race==2 & _female==1 & (educ99 == 1 | educ99==0)) ;
replace _educomp = 2.90 	if (_race==2 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.03 	if (_race==2 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.05 	if (_race==2 & _female==1 & educ99 == 6) ;
replace _educomp = 9.99 	if (_race==2 & _female==1 & educ99 == 7) ;
replace _educomp = 10.85 	if (_race==2 & _female==1 & educ99 ==8) ;
replace _educomp = 11.64 	if (_race==2 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==2 & _female==1 & educ99 ==10) ;
replace _educomp = 13.43 	if (_race==2 & _female==1 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.04 	if (_race==2 & _female==1 & educ99 ==14) ;
replace _educomp = 17.69 	if (_race==2 & _female==1 & educ99 ==15) ;
replace _educomp = 17.40 	if (_race==2 & _female==1 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==1 & educ99 ==17) ;

*** Men, other ethnicity ***;
replace _educomp = 0.62  	if (_race==3 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.24 	if (_race==3 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.14 	if (_race==3 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.00 	if (_race==3 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==3 & _female==0 & educ99 == 7) ;
replace _educomp = 10.88 	if (_race==3 & _female==0 & educ99 ==8) ;
replace _educomp = 11.50 	if (_race==3 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==3 & _female==0 & educ99 ==10) ;
replace _educomp = 13.53 	if (_race==3 & _female==0 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.15 	if (_race==3 & _female==0 & educ99 ==14) ;
replace _educomp = 17.60 	if (_race==3 & _female==0 & educ99 ==15) ;
replace _educomp = 17.77 	if (_race==3 & _female==0 & educ99 ==16) ;
replace _educomp = 17.92 	if (_race==3 & _female==0 & educ99 ==17) ;

*** Women, other ethnicity ***;
replace _educomp = 0.31 	if (_race==3 & _female==1 & (educ99 ==1 |educ99==0)) ;
replace _educomp = 3.03 	if (_race==3 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.13 	if (_race==3 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==3 & _female==1 & educ99 == 6) ;
replace _educomp = 9.97 	if (_race==3 & _female==1 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==3 & _female==1 & educ99 ==8) ;
replace _educomp = 11.69 	if (_race==3 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==3 & _female==1 & educ99 ==10) ;
replace _educomp = 13.47 	if (_race==3 & _female==1 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.10 	if (_race==3 & _female==1 & educ99 ==14) ;
replace _educomp = 17.67 	if (_race==3 & _female==1 & educ99 ==15) ;
replace _educomp = 17.20 	if (_race==3 & _female==1 & educ99 ==16) ;
replace _educomp = 17.88 	if (_race==3 & _female==1 & educ99 ==17) ;


*** Years of completed education for all years (categorical version) ***;
gen _hsd08      = 0 ;
gen _hsd911     = 0 ;
gen _hsg 	= 0 ;
gen  _sc 	= 0 ;
gen  _cg 	= 0 ;
gen  _ad 	= 0 ;

replace _hsd08  = 1 if educrec >=1 & educrec <=3 & educrec ~=0 & educrec ~=99 ;
replace _hsd911 = 1 if educrec >=4 & educrec <=6 & educrec ~=0 & educrec ~=99 ;
replace _hsg    = 1 if educrec ==7               & educrec ~=0 & educrec ~=99 ;
replace _sc     = 1 if educrec ==8               & educrec ~=0 & educrec ~=99 ;

replace _cg     = 1 if educrec ==9 & _educomp  <18 & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=.;
replace _cg     = 1 if educrec ==9 & educ99 ==14   & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _ad     = 1 if educrec ==9 & _educomp >=18             & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=. ;
replace _ad     = 1 if educrec ==9 & educ99 >=15 & educ99 <=17 & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _hsd08  = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsd911 = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsg    = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _sc     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _cg     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _ad     = . if (educrec ==. | educrec == 0 | educrec == 99) ;

replace _cg  = . if _educomp == .                & year <=1991 ;
replace _cg  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

replace _ad  = . if _educomp == .                & year <=1991 ;
replace _ad  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

gen     _education = . ;
replace _education = 1 if _hsd08  == 1 ;
replace _education = 2 if _hsd911 == 1 ;
replace _education = 3 if _hsg    == 1 ;
replace _education = 4 if _sc     == 1 ;
replace _education = 5 if _cg     == 1 ;
replace _education = 6 if _ad     == 1 ;

replace _education = . if educrec == . ;
replace _education = 0 if educrec == 0 ;
replace _education = . if educrec ==99 ;

replace _education = 0 if educrec == 0 & year <=1991 ;
replace _education = 0 if educ99  == 0 & year >=1992 ;

label define _education 0 "NIU" 1 "HSD08" 2 "HSD911" 3 "HSG" 4 "SC" 5 "CG" 6 "AD" ;
label values _education _education ;

label variable _education "6 _education categories, hsd08 hsd911 hsg sc cg ad (IPUMS)" ; 


*** Income ***;
*** a. adjusting for missing values;
generate _inctot = inctot ;
replace  _inctot = . if inctot == 999998 | inctot == 999999;
label variable _inctot "Total personal income";

generate _incwage = incwage ;
replace  _incwage = . if incwage == 999998 | incwage == 999999;
replace  _incwage = . if gq~=1;
label variable _incwage "Wage and salary income";

generate _incbus = incbus ;
replace  _incbus = . if incbus == 999998 | incbus == 999999;
replace  _incbus = . if gq~=1;
label variable _incbus "Business income";

generate _hhincome = hhincome ;
replace  _hhincome = . if hhincome == 999999;
replace  _hhincome = . if hhincome <= 0; 
label variable _hhincome "Total household income";

*** b. adjusting for inflation;
generate _cpi = . ;
replace  _cpi =	56.9	if wrkyr == 	1976	;
replace  _cpi =	60.6	if wrkyr == 	1977	;
replace  _cpi =	65.2	if wrkyr == 	1978	;
replace  _cpi =	72.6	if wrkyr == 	1979	;
replace  _cpi =	82.4	if wrkyr == 	1980	;
replace  _cpi =	90.9	if wrkyr == 	1981	;
replace  _cpi =	96.5	if wrkyr == 	1982	;
replace  _cpi =	99.6	if wrkyr == 	1983	;
replace  _cpi =	103.9	if wrkyr == 	1984	;
replace  _cpi =	107.6	if wrkyr == 	1985	;
replace  _cpi =	109.6	if wrkyr == 	1986	;
replace  _cpi =	113.6	if wrkyr == 	1987	;
replace  _cpi =	118.3	if wrkyr == 	1988	;
replace  _cpi =	124	if wrkyr == 	1989	;
replace  _cpi =	130.7	if wrkyr == 	1990	;
replace  _cpi =	136.2	if wrkyr == 	1991	;
replace  _cpi =	140.3	if wrkyr == 	1992	;
replace  _cpi =	144.5	if wrkyr == 	1993	;
replace  _cpi =	148.2	if wrkyr == 	1994	;
replace  _cpi =	152.4	if wrkyr == 	1995	;
replace  _cpi =	156.9	if wrkyr == 	1996	;
replace  _cpi =	160.5	if wrkyr == 	1997	;
replace  _cpi =	163	if wrkyr == 	1998	;
replace  _cpi =	166.6	if wrkyr == 	1999	;
replace  _cpi =	172.2	if wrkyr == 	2000	;
replace  _cpi =	177.1	if wrkyr == 	2001	;
replace  _cpi =	179.9	if wrkyr == 	2002	;
replace  _cpi =	184	if wrkyr == 	2003	;
replace  _cpi =	188.9	if wrkyr == 	2004	;
replace  _cpi =	195.3	if wrkyr == 	2005	;
replace  _cpi =	201.6	if wrkyr == 	2006	;
replace  _cpi =	207.342 if wrkyr == 	2007	;

generate _cpi_deflator2000 = 172.2 / _cpi ;

generate  _inctot_cpi = _inctot * _cpi_deflator2000 ;
label variable _inctot_cpi "Total personal income, in 2000 dollars";

generate  _incwage_cpi  =  _incwage  * _cpi_deflator2000 ;
label variable _incwage_cpi  "Wage and salary income, in 2000 dollars";

generate  _incbus_cpi   =  _incbus   * _cpi_deflator2000 ;
label variable _incbus_cpi   "Business income, in 2000 dollars";

generate  _hhincome_cpi =  _hhincome * _cpi_deflator2000 ;
label variable _hhincome_cpi "Total household income, in 2000 dollars";

sort wrkyr;
save temp, replace;

*** c. cutting outliers;
use temp, clear;
keep if _female==0;
keep if _white==1;
keep if _agelyr>=18 & _agelyr<=64;

collapse 
(p1)  pct01 = _inctot_cpi
(p99) pct99 = _inctot_cpi
[pw=_perwt], by(wrkyr);
sort wrkyr;
merge wrkyr using temp;
drop _merge*;

generate _inctot_cpi_tr01   = _inctot_cpi;
generate _inctot_cpi_tr99   = _inctot_cpi;
generate _inctot_cpi_tr0199 = _inctot_cpi;

replace  _inctot_cpi_tr01   = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr99   = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi_tr0199 < 0;

label variable _inctot_cpi_tr01   "Total personal income, in 2000 dollars, w/o 01 prc. outliers";
label variable _inctot_cpi_tr99   "Total personal income, in 2000 dollars, w/o 99 prc. outliers";
label variable _inctot_cpi_tr0199 "Total personal income, in 2000 dollars, w/o 01 and 99 prc. outliers";
drop pct01 pct99;


*** Main sample indicator ***;
generate main_sample = 1;
replace  main_sample = 0 if _agelyr < 18;
replace  main_sample = 0 if _agelyr > 64;
replace  main_sample = 0 if gq ~= 1;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;

keep if main_sample==1;

replace _inctot_cpi        = 1 if _inctot_cpi        <= 0;
replace _inctot_cpi_tr01   = 1 if _inctot_cpi_tr01   <= 0;
replace _inctot_cpi_tr99   = 1 if _inctot_cpi_tr99   <= 0;
replace _inctot_cpi_tr0199 = 1 if _inctot_cpi_tr0199 <= 0;

egen gini_inctot_cpi        = inequal(_inctot_cpi),        by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr01   = inequal(_inctot_cpi_tr01),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr99   = inequal(_inctot_cpi_tr99),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr0199 = inequal(_inctot_cpi_tr0199), by(statefip wrkyr) weights(_perwt) index(gini);

keep statefip wrkyr gini_*;
duplicates drop;
drop if gini_inctot_cpi        ==.;
drop if gini_inctot_cpi_tr01   ==.;
drop if gini_inctot_cpi_tr99   ==.;
drop if gini_inctot_cpi_tr0199 ==.;

generate log_gini_inctot_cpi        = log(gini_inctot_cpi);
generate log_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01);
generate log_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99);
generate log_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199);

generate logistic_gini_inctot_cpi        = log(gini_inctot_cpi/(1-gini_inctot_cpi));
generate logistic_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01/(1-gini_inctot_cpi_tr01));
generate logistic_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99/(1-gini_inctot_cpi_tr99));
generate logistic_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199/(1-gini_inctot_cpi_tr0199));

sort statefip wrkyr;
save temp, replace;


muse macro_workfile.dta, s w c 
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVII.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("Robustness of the Results to Inclusion of Observations with Outlying Income")
posthead("Panel A: Ages 18-64")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
#delimit cr



*****************************************************************
*** AGES 25-54 **************************************************
*****************************************************************
*作者未提供数据
clear
infix ///
 int     year                                 1-4 ///
 long    serial                               5-9 ///
 float  hhwt                                10-16 ///
 float  hhwt04                              17-24 ///
 byte    gq                                  25 ///
 byte    statefip                            26-27 ///
 long    hhincome                            28-34 ///
 float  perwt                               35-42 ///
 float  perwt04                             43-50 ///
 int     relate                              51-54 ///
 byte    age                                 55-56 ///
 byte    sex                                 57 ///
 int     race                                58-60 ///
 int     hispan                              61-63 ///
 byte    educ99                              64-65 ///
 int     higrade                             66-68 ///
 byte    educrec                             69-70 ///
 byte    empstat                             71-72 ///
 byte    classwly                            73-74 ///
 byte    wkswork1                            75-76 ///
 byte    uhrswork                            77-78 ///
 long    inctot                              79-84 ///
 long    incwage                             85-90 ///
 long    incbus                              91-96 ///
 using "/home/alevkov/BeckLevineLevkov2010/data/raw_cps.dat"

replace hhwt=hhwt/100
replace hhwt04=hhwt04/100
replace perwt=perwt/100
replace perwt04=perwt04/100

label var year `"Survey year"'
label var serial `"Household serial number"'
label var hhwt `"Household weight"'
label var hhwt04 `"Household weight 2004"'
label var gq `"Group Quarters status"'
label var statefip `"State (FIPS code)"'
label var hhincome `"Total household income"'
label var perwt `"Person weight"'
label var perwt04 `"Person weight 2004"'
label var relate `"Relationship to household head"'
label var age `"Age"'
label var sex `"Sex"'
label var race `"Race"'
label var hispan `"Hispanic origin"'
label var educ99 `"Educational attainment, 1990"'
label var higrade `"Highest grade of school"'
label var educrec `"Educational attainment recode"'
label var empstat `"Employment status"'
label var classwly `"Class of worker last year"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week (last yr)"'
label var inctot `"Total personal income"'
label var incwage `"Wage and salary income"'
label var incbus `"Non-farm business income"'


#delimit;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


*** Age last year ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;


*** Gender and athnicity ***;
gen     _female = 0 ;
replace _female = 1 if sex == 2 ;
replace _female = . if sex == . ;

gen     _hispanic = 0 ;
replace _hispanic = 1 if hispan >=100 & hispan <=410 ;
replace _hispanic = . if hispan == 901 | hispan == 902 ;

gen _white = 0 ;
gen _black = 0 ;

replace _white = 1 if race == 100 ;
replace _black = 1 if race == 200 ;

replace _white = 0 if _hispanic == 1 ;
replace _black = 0 if _hispanic == 1 ;

label variable _white "1 if person is white and not a Hispanic" ;
label variable _black "1 if person is black and not a Hispanic" ;


*** Female-headed household indicator ***;
generate temp = 0;
replace  temp = 1 if _female == 1 & relate == 101;

bysort statefip wrkyr serial: egen _female_headed = max(temp);
drop temp;
label variable _female_headed "1 if female_headed household";


*** Years of completed education before 1992 ***;
gen _educomp =. ;

replace _educomp = 0 if higrade==10 ;
replace _educomp = 0 if higrade==31 ;

replace _educomp = 1 if higrade==40 ;
replace _educomp = 1 if higrade==41 ;
replace _educomp = 2 if higrade==50 ;
replace _educomp = 2 if higrade==51 ;
replace _educomp = 3 if higrade==60 ;
replace _educomp = 3 if higrade==61 ;
replace _educomp = 4 if higrade==70 ;
replace _educomp = 4 if higrade==71 ;
replace _educomp = 5 if higrade==80 ;
replace _educomp = 5 if higrade==81 ;
replace _educomp = 6 if higrade==90 ;
replace _educomp = 6 if higrade==91 ;

replace _educomp = 7 if higrade==100 ;
replace _educomp = 7 if higrade==101 ;
replace _educomp = 8 if higrade==110 ;
replace _educomp = 8 if higrade==111 ;
replace _educomp = 9 if higrade==120 ;
replace _educomp = 9 if higrade==121 ;

replace _educomp =10 if higrade==130 ;
replace _educomp =10 if higrade==131 ;
replace _educomp =11 if higrade==140 ;
replace _educomp =11 if higrade==141 ;
replace _educomp =12 if higrade==150 ;
replace _educomp =12 if higrade==151 ;
replace _educomp =13 if higrade==160 ;
replace _educomp =13 if higrade==161 ;
replace _educomp =14 if higrade==170 ;
replace _educomp =14 if higrade==171 ;
replace _educomp =15 if higrade==180 ;
replace _educomp =15 if higrade==181 ;
replace _educomp =16 if higrade==190 ;
replace _educomp =16 if higrade==191 ;
replace _educomp =17 if higrade==200 ;
replace _educomp =17 if higrade==201 ;

replace _educomp =18 if higrade==210 ;

replace _educomp =. if higrade==  . ;
replace _educomp =. if higrade==  0 ;
replace _educomp =. if higrade==999 ;


*** Years of completed education after 1992 ***;
gen _race = . ;

replace _race = 1 if race == 100 ;
replace _race = 2 if race == 200 ;
replace _race = 3 if race  > 200 & _race ~=. ;

*** Men, white ***;
replace _educomp = 0.32  	if (_race==1 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.19 	if (_race==1 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.24 	if (_race==1 & _female==0 & (educ99 ==5)) ;
replace _educomp = 8.97 	if (_race==1 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==1 & _female==0 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==1 & _female==0 & educ99 ==8) ;
replace _educomp = 11.58 	if (_race==1 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==1 & _female==0 & educ99 ==10) ;
replace _educomp = 13.48 	if (_race==1 & _female==0 & educ99 ==11) ;
replace _educomp = 14.23 	if (_race==1 & _female==0 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.17 	if (_race==1 & _female==0 & educ99 ==14) ;
replace _educomp = 17.68 	if (_race==1 & _female==0 & educ99 ==15) ;
replace _educomp = 17.71 	if (_race==1 & _female==0 & educ99 ==16) ;
replace _educomp = 17.83 	if (_race==1 & _female==0 & educ99 ==17) ;

*** Women, white ***;
replace _educomp = 0.62 	if (_race==1 & _female==1 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.15 	if (_race==1 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.23 	if (_race==1 & _female==1 & (educ99 ==5)) ;
replace _educomp = 8.99 	if (_race==1 & _female==1 & educ99 == 6) ;
replace _educomp = 9.95 	if (_race==1 & _female==1 & educ99 == 7) ;
replace _educomp = 10.87 	if (_race==1 & _female==1 & educ99 ==8) ;
replace _educomp = 11.73 	if (_race==1 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==1 & _female==1 & educ99 ==10) ;
replace _educomp = 13.35 	if (_race==1 & _female==1 & educ99 ==11) ;
replace _educomp = 14.22 	if (_race==1 & _female==1 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.15 	if (_race==1 & _female==1 & educ99 ==14) ;
replace _educomp = 17.64 	if (_race==1 & _female==1 & educ99 ==15) ;
replace _educomp = 17.00 	if (_race==1 & _female==1 & educ99 ==16) ;
replace _educomp = 17.76 	if (_race==1 & _female==1 & educ99 ==17) ;

*** Men, black ***;
replace _educomp = 0.92  	if (_race==2 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.28 	if (_race==2 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.04 	if (_race==2 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==2 & _female==0 & educ99 == 6) ;
replace _educomp = 9.91 	if (_race==2 & _female==0 & educ99 == 7) ;
replace _educomp = 10.90 	if (_race==2 & _female==0 & educ99 ==8) ;
replace _educomp = 11.41 	if (_race==2 & _female==0 & educ99 ==9) ;
replace _educomp = 11.98 	if (_race==2 & _female==0 & educ99 ==10) ;
replace _educomp = 13.57 	if (_race==2 & _female==0 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.13 	if (_race==2 & _female==0 & educ99 ==14) ;
replace _educomp = 17.51 	if (_race==2 & _female==0 & educ99 ==15) ;
replace _educomp = 17.83 	if (_race==2 & _female==0 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==0 & educ99 ==17) ;

*** Women, black ***;
replace _educomp = 0.00 	if (_race==2 & _female==1 & (educ99 == 1 | educ99==0)) ;
replace _educomp = 2.90 	if (_race==2 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.03 	if (_race==2 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.05 	if (_race==2 & _female==1 & educ99 == 6) ;
replace _educomp = 9.99 	if (_race==2 & _female==1 & educ99 == 7) ;
replace _educomp = 10.85 	if (_race==2 & _female==1 & educ99 ==8) ;
replace _educomp = 11.64 	if (_race==2 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==2 & _female==1 & educ99 ==10) ;
replace _educomp = 13.43 	if (_race==2 & _female==1 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.04 	if (_race==2 & _female==1 & educ99 ==14) ;
replace _educomp = 17.69 	if (_race==2 & _female==1 & educ99 ==15) ;
replace _educomp = 17.40 	if (_race==2 & _female==1 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==1 & educ99 ==17) ;

*** Men, other ethnicity ***;
replace _educomp = 0.62  	if (_race==3 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.24 	if (_race==3 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.14 	if (_race==3 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.00 	if (_race==3 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==3 & _female==0 & educ99 == 7) ;
replace _educomp = 10.88 	if (_race==3 & _female==0 & educ99 ==8) ;
replace _educomp = 11.50 	if (_race==3 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==3 & _female==0 & educ99 ==10) ;
replace _educomp = 13.53 	if (_race==3 & _female==0 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.15 	if (_race==3 & _female==0 & educ99 ==14) ;
replace _educomp = 17.60 	if (_race==3 & _female==0 & educ99 ==15) ;
replace _educomp = 17.77 	if (_race==3 & _female==0 & educ99 ==16) ;
replace _educomp = 17.92 	if (_race==3 & _female==0 & educ99 ==17) ;

*** Women, other ethnicity ***;
replace _educomp = 0.31 	if (_race==3 & _female==1 & (educ99 ==1 |educ99==0)) ;
replace _educomp = 3.03 	if (_race==3 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.13 	if (_race==3 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==3 & _female==1 & educ99 == 6) ;
replace _educomp = 9.97 	if (_race==3 & _female==1 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==3 & _female==1 & educ99 ==8) ;
replace _educomp = 11.69 	if (_race==3 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==3 & _female==1 & educ99 ==10) ;
replace _educomp = 13.47 	if (_race==3 & _female==1 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.10 	if (_race==3 & _female==1 & educ99 ==14) ;
replace _educomp = 17.67 	if (_race==3 & _female==1 & educ99 ==15) ;
replace _educomp = 17.20 	if (_race==3 & _female==1 & educ99 ==16) ;
replace _educomp = 17.88 	if (_race==3 & _female==1 & educ99 ==17) ;


*** Years of completed education for all years (categorical version) ***;
gen _hsd08      = 0 ;
gen _hsd911     = 0 ;
gen _hsg 	= 0 ;
gen  _sc 	= 0 ;
gen  _cg 	= 0 ;
gen  _ad 	= 0 ;

replace _hsd08  = 1 if educrec >=1 & educrec <=3 & educrec ~=0 & educrec ~=99 ;
replace _hsd911 = 1 if educrec >=4 & educrec <=6 & educrec ~=0 & educrec ~=99 ;
replace _hsg    = 1 if educrec ==7               & educrec ~=0 & educrec ~=99 ;
replace _sc     = 1 if educrec ==8               & educrec ~=0 & educrec ~=99 ;

replace _cg     = 1 if educrec ==9 & _educomp  <18 & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=.;
replace _cg     = 1 if educrec ==9 & educ99 ==14   & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _ad     = 1 if educrec ==9 & _educomp >=18             & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=. ;
replace _ad     = 1 if educrec ==9 & educ99 >=15 & educ99 <=17 & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _hsd08  = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsd911 = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsg    = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _sc     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _cg     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _ad     = . if (educrec ==. | educrec == 0 | educrec == 99) ;

replace _cg  = . if _educomp == .                & year <=1991 ;
replace _cg  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

replace _ad  = . if _educomp == .                & year <=1991 ;
replace _ad  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

gen     _education = . ;
replace _education = 1 if _hsd08  == 1 ;
replace _education = 2 if _hsd911 == 1 ;
replace _education = 3 if _hsg    == 1 ;
replace _education = 4 if _sc     == 1 ;
replace _education = 5 if _cg     == 1 ;
replace _education = 6 if _ad     == 1 ;

replace _education = . if educrec == . ;
replace _education = 0 if educrec == 0 ;
replace _education = . if educrec ==99 ;

replace _education = 0 if educrec == 0 & year <=1991 ;
replace _education = 0 if educ99  == 0 & year >=1992 ;

label define _education 0 "NIU" 1 "HSD08" 2 "HSD911" 3 "HSG" 4 "SC" 5 "CG" 6 "AD" ;
label values _education _education ;

label variable _education "6 _education categories, hsd08 hsd911 hsg sc cg ad (IPUMS)" ; 


*** Income ***;
*** a. adjusting for missing values;
generate _inctot = inctot ;
replace  _inctot = . if inctot == 999998 | inctot == 999999;
label variable _inctot "Total personal income";

generate _incwage = incwage ;
replace  _incwage = . if incwage == 999998 | incwage == 999999;
replace  _incwage = . if gq~=1;
label variable _incwage "Wage and salary income";

generate _incbus = incbus ;
replace  _incbus = . if incbus == 999998 | incbus == 999999;
replace  _incbus = . if gq~=1;
label variable _incbus "Business income";

generate _hhincome = hhincome ;
replace  _hhincome = . if hhincome == 999999;
replace  _hhincome = . if hhincome <= 0; 
label variable _hhincome "Total household income";

*** b. adjusting for inflation;
generate _cpi = . ;
replace  _cpi =	56.9	if wrkyr == 	1976	;
replace  _cpi =	60.6	if wrkyr == 	1977	;
replace  _cpi =	65.2	if wrkyr == 	1978	;
replace  _cpi =	72.6	if wrkyr == 	1979	;
replace  _cpi =	82.4	if wrkyr == 	1980	;
replace  _cpi =	90.9	if wrkyr == 	1981	;
replace  _cpi =	96.5	if wrkyr == 	1982	;
replace  _cpi =	99.6	if wrkyr == 	1983	;
replace  _cpi =	103.9	if wrkyr == 	1984	;
replace  _cpi =	107.6	if wrkyr == 	1985	;
replace  _cpi =	109.6	if wrkyr == 	1986	;
replace  _cpi =	113.6	if wrkyr == 	1987	;
replace  _cpi =	118.3	if wrkyr == 	1988	;
replace  _cpi =	124	if wrkyr == 	1989	;
replace  _cpi =	130.7	if wrkyr == 	1990	;
replace  _cpi =	136.2	if wrkyr == 	1991	;
replace  _cpi =	140.3	if wrkyr == 	1992	;
replace  _cpi =	144.5	if wrkyr == 	1993	;
replace  _cpi =	148.2	if wrkyr == 	1994	;
replace  _cpi =	152.4	if wrkyr == 	1995	;
replace  _cpi =	156.9	if wrkyr == 	1996	;
replace  _cpi =	160.5	if wrkyr == 	1997	;
replace  _cpi =	163	if wrkyr == 	1998	;
replace  _cpi =	166.6	if wrkyr == 	1999	;
replace  _cpi =	172.2	if wrkyr == 	2000	;
replace  _cpi =	177.1	if wrkyr == 	2001	;
replace  _cpi =	179.9	if wrkyr == 	2002	;
replace  _cpi =	184	if wrkyr == 	2003	;
replace  _cpi =	188.9	if wrkyr == 	2004	;
replace  _cpi =	195.3	if wrkyr == 	2005	;
replace  _cpi =	201.6	if wrkyr == 	2006	;
replace  _cpi =	207.342 if wrkyr == 	2007	;

generate _cpi_deflator2000 = 172.2 / _cpi ;

generate  _inctot_cpi = _inctot * _cpi_deflator2000 ;
label variable _inctot_cpi "Total personal income, in 2000 dollars";

generate  _incwage_cpi  =  _incwage  * _cpi_deflator2000 ;
label variable _incwage_cpi  "Wage and salary income, in 2000 dollars";

generate  _incbus_cpi   =  _incbus   * _cpi_deflator2000 ;
label variable _incbus_cpi   "Business income, in 2000 dollars";

generate  _hhincome_cpi =  _hhincome * _cpi_deflator2000 ;
label variable _hhincome_cpi "Total household income, in 2000 dollars";

sort wrkyr;
save temp, replace;

*** c. cutting outliers;
use temp, clear;
keep if _female==0;
keep if _white==1;
keep if _agelyr>=25 & _agelyr<=54;

collapse 
(p1)  pct01 = _inctot_cpi
(p99) pct99 = _inctot_cpi
[pw=_perwt], by(wrkyr);
sort wrkyr;
merge wrkyr using temp;
drop _merge*;

generate _inctot_cpi_tr01   = _inctot_cpi;
generate _inctot_cpi_tr99   = _inctot_cpi;
generate _inctot_cpi_tr0199 = _inctot_cpi;

replace  _inctot_cpi_tr01   = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr99   = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi_tr0199 < 0;

label variable _inctot_cpi_tr01   "Total personal income, in 2000 dollars, w/o 01 prc. outliers";
label variable _inctot_cpi_tr99   "Total personal income, in 2000 dollars, w/o 99 prc. outliers";
label variable _inctot_cpi_tr0199 "Total personal income, in 2000 dollars, w/o 01 and 99 prc. outliers";
drop pct01 pct99;


*** Main sample indicator ***;
generate main_sample = 1;
replace  main_sample = 0 if _agelyr < 25;
replace  main_sample = 0 if _agelyr > 54;
replace  main_sample = 0 if gq ~= 1;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;

keep if main_sample==1;

replace _inctot_cpi        = 1 if _inctot_cpi        <= 0;
replace _inctot_cpi_tr01   = 1 if _inctot_cpi_tr01   <= 0;
replace _inctot_cpi_tr99   = 1 if _inctot_cpi_tr99   <= 0;
replace _inctot_cpi_tr0199 = 1 if _inctot_cpi_tr0199 <= 0;

egen gini_inctot_cpi        = inequal(_inctot_cpi),        by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr01   = inequal(_inctot_cpi_tr01),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr99   = inequal(_inctot_cpi_tr99),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr0199 = inequal(_inctot_cpi_tr0199), by(statefip wrkyr) weights(_perwt) index(gini);

keep statefip wrkyr gini_*;
duplicates drop;
drop if gini_inctot_cpi        ==.;
drop if gini_inctot_cpi_tr01   ==.;
drop if gini_inctot_cpi_tr99   ==.;
drop if gini_inctot_cpi_tr0199 ==.;

generate log_gini_inctot_cpi        = log(gini_inctot_cpi);
generate log_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01);
generate log_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99);
generate log_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199);

generate logistic_gini_inctot_cpi        = log(gini_inctot_cpi/(1-gini_inctot_cpi));
generate logistic_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01/(1-gini_inctot_cpi_tr01));
generate logistic_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99/(1-gini_inctot_cpi_tr99));
generate logistic_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199/(1-gini_inctot_cpi_tr0199));

sort statefip wrkyr;
save temp, replace;


muse macro_workfile.dta, s w c 
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVII.txt, append
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("Panel B: Ages 25-54")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;

log close;








**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table VIII in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************

clear
set mem 2g
set more off


log using Appendix_TableVIII.log, replace

*作者未提供数据
clear
infix ///
 int     year                                 1-4 ///
 long    serial                               5-9 ///
 float  hhwt                                10-16 ///
 float  hhwt04                              17-24 ///
 byte    gq                                  25 ///
 byte    statefip                            26-27 ///
 long    hhincome                            28-34 ///
 float  perwt                               35-42 ///
 float  perwt04                             43-50 ///
 int     relate                              51-54 ///
 byte    age                                 55-56 ///
 byte    sex                                 57 ///
 int     race                                58-60 ///
 int     hispan                              61-63 ///
 byte    educ99                              64-65 ///
 int     higrade                             66-68 ///
 byte    educrec                             69-70 ///
 byte    empstat                             71-72 ///
 byte    classwly                            73-74 ///
 byte    wkswork1                            75-76 ///
 byte    uhrswork                            77-78 ///
 long    inctot                              79-84 ///
 long    incwage                             85-90 ///
 long    incbus                              91-96 ///
 using "/home/alevkov/BeckLevineLevkov2010/data/raw_cps.dat"

replace hhwt=hhwt/100
replace hhwt04=hhwt04/100
replace perwt=perwt/100
replace perwt04=perwt04/100

label var year `"Survey year"'
label var serial `"Household serial number"'
label var hhwt `"Household weight"'
label var hhwt04 `"Household weight 2004"'
label var gq `"Group Quarters status"'
label var statefip `"State (FIPS code)"'
label var hhincome `"Total household income"'
label var perwt `"Person weight"'
label var perwt04 `"Person weight 2004"'
label var relate `"Relationship to household head"'
label var age `"Age"'
label var sex `"Sex"'
label var race `"Race"'
label var hispan `"Hispanic origin"'
label var educ99 `"Educational attainment, 1990"'
label var higrade `"Highest grade of school"'
label var educrec `"Educational attainment recode"'
label var empstat `"Employment status"'
label var classwly `"Class of worker last year"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week (last yr)"'
label var inctot `"Total personal income"'
label var incwage `"Wage and salary income"'
label var incbus `"Non-farm business income"'


#delimit;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


*** Age last year ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;


*** Gender and athnicity ***;
gen     _female = 0 ;
replace _female = 1 if sex == 2 ;
replace _female = . if sex == . ;

gen     _hispanic = 0 ;
replace _hispanic = 1 if hispan >=100 & hispan <=410 ;
replace _hispanic = . if hispan == 901 | hispan == 902 ;

gen _white = 0 ;
gen _black = 0 ;

replace _white = 1 if race == 100 ;
replace _black = 1 if race == 200 ;

replace _white = 0 if _hispanic == 1 ;
replace _black = 0 if _hispanic == 1 ;

label variable _white "1 if person is white and not a Hispanic" ;
label variable _black "1 if person is black and not a Hispanic" ;


*** Female-headed household indicator ***;
generate temp = 0;
replace  temp = 1 if _female == 1 & relate == 101;

bysort statefip wrkyr serial: egen _female_headed = max(temp);
drop temp;
label variable _female_headed "1 if female_headed household";


*** Years of completed education before 1992 ***;
gen _educomp =. ;

replace _educomp = 0 if higrade==10 ;
replace _educomp = 0 if higrade==31 ;

replace _educomp = 1 if higrade==40 ;
replace _educomp = 1 if higrade==41 ;
replace _educomp = 2 if higrade==50 ;
replace _educomp = 2 if higrade==51 ;
replace _educomp = 3 if higrade==60 ;
replace _educomp = 3 if higrade==61 ;
replace _educomp = 4 if higrade==70 ;
replace _educomp = 4 if higrade==71 ;
replace _educomp = 5 if higrade==80 ;
replace _educomp = 5 if higrade==81 ;
replace _educomp = 6 if higrade==90 ;
replace _educomp = 6 if higrade==91 ;

replace _educomp = 7 if higrade==100 ;
replace _educomp = 7 if higrade==101 ;
replace _educomp = 8 if higrade==110 ;
replace _educomp = 8 if higrade==111 ;
replace _educomp = 9 if higrade==120 ;
replace _educomp = 9 if higrade==121 ;

replace _educomp =10 if higrade==130 ;
replace _educomp =10 if higrade==131 ;
replace _educomp =11 if higrade==140 ;
replace _educomp =11 if higrade==141 ;
replace _educomp =12 if higrade==150 ;
replace _educomp =12 if higrade==151 ;
replace _educomp =13 if higrade==160 ;
replace _educomp =13 if higrade==161 ;
replace _educomp =14 if higrade==170 ;
replace _educomp =14 if higrade==171 ;
replace _educomp =15 if higrade==180 ;
replace _educomp =15 if higrade==181 ;
replace _educomp =16 if higrade==190 ;
replace _educomp =16 if higrade==191 ;
replace _educomp =17 if higrade==200 ;
replace _educomp =17 if higrade==201 ;

replace _educomp =18 if higrade==210 ;

replace _educomp =. if higrade==  . ;
replace _educomp =. if higrade==  0 ;
replace _educomp =. if higrade==999 ;


*** Years of completed education after 1992 ***;
gen _race = . ;

replace _race = 1 if race == 100 ;
replace _race = 2 if race == 200 ;
replace _race = 3 if race  > 200 & _race ~=. ;

*** Men, white ***;
replace _educomp = 0.32  	if (_race==1 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.19 	if (_race==1 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.24 	if (_race==1 & _female==0 & (educ99 ==5)) ;
replace _educomp = 8.97 	if (_race==1 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==1 & _female==0 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==1 & _female==0 & educ99 ==8) ;
replace _educomp = 11.58 	if (_race==1 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==1 & _female==0 & educ99 ==10) ;
replace _educomp = 13.48 	if (_race==1 & _female==0 & educ99 ==11) ;
replace _educomp = 14.23 	if (_race==1 & _female==0 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.17 	if (_race==1 & _female==0 & educ99 ==14) ;
replace _educomp = 17.68 	if (_race==1 & _female==0 & educ99 ==15) ;
replace _educomp = 17.71 	if (_race==1 & _female==0 & educ99 ==16) ;
replace _educomp = 17.83 	if (_race==1 & _female==0 & educ99 ==17) ;

*** Women, white ***;
replace _educomp = 0.62 	if (_race==1 & _female==1 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.15 	if (_race==1 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.23 	if (_race==1 & _female==1 & (educ99 ==5)) ;
replace _educomp = 8.99 	if (_race==1 & _female==1 & educ99 == 6) ;
replace _educomp = 9.95 	if (_race==1 & _female==1 & educ99 == 7) ;
replace _educomp = 10.87 	if (_race==1 & _female==1 & educ99 ==8) ;
replace _educomp = 11.73 	if (_race==1 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==1 & _female==1 & educ99 ==10) ;
replace _educomp = 13.35 	if (_race==1 & _female==1 & educ99 ==11) ;
replace _educomp = 14.22 	if (_race==1 & _female==1 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.15 	if (_race==1 & _female==1 & educ99 ==14) ;
replace _educomp = 17.64 	if (_race==1 & _female==1 & educ99 ==15) ;
replace _educomp = 17.00 	if (_race==1 & _female==1 & educ99 ==16) ;
replace _educomp = 17.76 	if (_race==1 & _female==1 & educ99 ==17) ;

*** Men, black ***;
replace _educomp = 0.92  	if (_race==2 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.28 	if (_race==2 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.04 	if (_race==2 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==2 & _female==0 & educ99 == 6) ;
replace _educomp = 9.91 	if (_race==2 & _female==0 & educ99 == 7) ;
replace _educomp = 10.90 	if (_race==2 & _female==0 & educ99 ==8) ;
replace _educomp = 11.41 	if (_race==2 & _female==0 & educ99 ==9) ;
replace _educomp = 11.98 	if (_race==2 & _female==0 & educ99 ==10) ;
replace _educomp = 13.57 	if (_race==2 & _female==0 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.13 	if (_race==2 & _female==0 & educ99 ==14) ;
replace _educomp = 17.51 	if (_race==2 & _female==0 & educ99 ==15) ;
replace _educomp = 17.83 	if (_race==2 & _female==0 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==0 & educ99 ==17) ;

*** Women, black ***;
replace _educomp = 0.00 	if (_race==2 & _female==1 & (educ99 == 1 | educ99==0)) ;
replace _educomp = 2.90 	if (_race==2 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.03 	if (_race==2 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.05 	if (_race==2 & _female==1 & educ99 == 6) ;
replace _educomp = 9.99 	if (_race==2 & _female==1 & educ99 == 7) ;
replace _educomp = 10.85 	if (_race==2 & _female==1 & educ99 ==8) ;
replace _educomp = 11.64 	if (_race==2 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==2 & _female==1 & educ99 ==10) ;
replace _educomp = 13.43 	if (_race==2 & _female==1 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.04 	if (_race==2 & _female==1 & educ99 ==14) ;
replace _educomp = 17.69 	if (_race==2 & _female==1 & educ99 ==15) ;
replace _educomp = 17.40 	if (_race==2 & _female==1 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==1 & educ99 ==17) ;

*** Men, other ethnicity ***;
replace _educomp = 0.62  	if (_race==3 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.24 	if (_race==3 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.14 	if (_race==3 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.00 	if (_race==3 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==3 & _female==0 & educ99 == 7) ;
replace _educomp = 10.88 	if (_race==3 & _female==0 & educ99 ==8) ;
replace _educomp = 11.50 	if (_race==3 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==3 & _female==0 & educ99 ==10) ;
replace _educomp = 13.53 	if (_race==3 & _female==0 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.15 	if (_race==3 & _female==0 & educ99 ==14) ;
replace _educomp = 17.60 	if (_race==3 & _female==0 & educ99 ==15) ;
replace _educomp = 17.77 	if (_race==3 & _female==0 & educ99 ==16) ;
replace _educomp = 17.92 	if (_race==3 & _female==0 & educ99 ==17) ;

*** Women, other ethnicity ***;
replace _educomp = 0.31 	if (_race==3 & _female==1 & (educ99 ==1 |educ99==0)) ;
replace _educomp = 3.03 	if (_race==3 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.13 	if (_race==3 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==3 & _female==1 & educ99 == 6) ;
replace _educomp = 9.97 	if (_race==3 & _female==1 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==3 & _female==1 & educ99 ==8) ;
replace _educomp = 11.69 	if (_race==3 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==3 & _female==1 & educ99 ==10) ;
replace _educomp = 13.47 	if (_race==3 & _female==1 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.10 	if (_race==3 & _female==1 & educ99 ==14) ;
replace _educomp = 17.67 	if (_race==3 & _female==1 & educ99 ==15) ;
replace _educomp = 17.20 	if (_race==3 & _female==1 & educ99 ==16) ;
replace _educomp = 17.88 	if (_race==3 & _female==1 & educ99 ==17) ;


*** Years of completed education for all years (categorical version) ***;
gen _hsd08      = 0 ;
gen _hsd911     = 0 ;
gen _hsg 	= 0 ;
gen  _sc 	= 0 ;
gen  _cg 	= 0 ;
gen  _ad 	= 0 ;

replace _hsd08  = 1 if educrec >=1 & educrec <=3 & educrec ~=0 & educrec ~=99 ;
replace _hsd911 = 1 if educrec >=4 & educrec <=6 & educrec ~=0 & educrec ~=99 ;
replace _hsg    = 1 if educrec ==7               & educrec ~=0 & educrec ~=99 ;
replace _sc     = 1 if educrec ==8               & educrec ~=0 & educrec ~=99 ;

replace _cg     = 1 if educrec ==9 & _educomp  <18 & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=.;
replace _cg     = 1 if educrec ==9 & educ99 ==14   & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _ad     = 1 if educrec ==9 & _educomp >=18             & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=. ;
replace _ad     = 1 if educrec ==9 & educ99 >=15 & educ99 <=17 & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _hsd08  = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsd911 = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsg    = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _sc     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _cg     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _ad     = . if (educrec ==. | educrec == 0 | educrec == 99) ;

replace _cg  = . if _educomp == .                & year <=1991 ;
replace _cg  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

replace _ad  = . if _educomp == .                & year <=1991 ;
replace _ad  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

gen     _education = . ;
replace _education = 1 if _hsd08  == 1 ;
replace _education = 2 if _hsd911 == 1 ;
replace _education = 3 if _hsg    == 1 ;
replace _education = 4 if _sc     == 1 ;
replace _education = 5 if _cg     == 1 ;
replace _education = 6 if _ad     == 1 ;

replace _education = . if educrec == . ;
replace _education = 0 if educrec == 0 ;
replace _education = . if educrec ==99 ;

replace _education = 0 if educrec == 0 & year <=1991 ;
replace _education = 0 if educ99  == 0 & year >=1992 ;

label define _education 0 "NIU" 1 "HSD08" 2 "HSD911" 3 "HSG" 4 "SC" 5 "CG" 6 "AD" ;
label values _education _education ;

label variable _education "6 _education categories, hsd08 hsd911 hsg sc cg ad (IPUMS)" ; 


*** Income ***;
*** a. adjusting for missing values;
generate _inctot = inctot ;
replace  _inctot = . if inctot == 999998 | inctot == 999999;
label variable _inctot "Total personal income";

generate _incwage = incwage ;
replace  _incwage = . if incwage == 999998 | incwage == 999999;
replace  _incwage = . if gq~=1;
label variable _incwage "Wage and salary income";

generate _incbus = incbus ;
replace  _incbus = . if incbus == 999998 | incbus == 999999;
replace  _incbus = . if gq~=1;
label variable _incbus "Business income";

generate _hhincome = hhincome ;
replace  _hhincome = . if hhincome == 999999;
replace  _hhincome = . if hhincome <= 0; 
label variable _hhincome "Total household income";

*** b. adjusting for inflation;
generate _cpi = . ;
replace  _cpi =	56.9	if wrkyr == 	1976	;
replace  _cpi =	60.6	if wrkyr == 	1977	;
replace  _cpi =	65.2	if wrkyr == 	1978	;
replace  _cpi =	72.6	if wrkyr == 	1979	;
replace  _cpi =	82.4	if wrkyr == 	1980	;
replace  _cpi =	90.9	if wrkyr == 	1981	;
replace  _cpi =	96.5	if wrkyr == 	1982	;
replace  _cpi =	99.6	if wrkyr == 	1983	;
replace  _cpi =	103.9	if wrkyr == 	1984	;
replace  _cpi =	107.6	if wrkyr == 	1985	;
replace  _cpi =	109.6	if wrkyr == 	1986	;
replace  _cpi =	113.6	if wrkyr == 	1987	;
replace  _cpi =	118.3	if wrkyr == 	1988	;
replace  _cpi =	124	if wrkyr == 	1989	;
replace  _cpi =	130.7	if wrkyr == 	1990	;
replace  _cpi =	136.2	if wrkyr == 	1991	;
replace  _cpi =	140.3	if wrkyr == 	1992	;
replace  _cpi =	144.5	if wrkyr == 	1993	;
replace  _cpi =	148.2	if wrkyr == 	1994	;
replace  _cpi =	152.4	if wrkyr == 	1995	;
replace  _cpi =	156.9	if wrkyr == 	1996	;
replace  _cpi =	160.5	if wrkyr == 	1997	;
replace  _cpi =	163	if wrkyr == 	1998	;
replace  _cpi =	166.6	if wrkyr == 	1999	;
replace  _cpi =	172.2	if wrkyr == 	2000	;
replace  _cpi =	177.1	if wrkyr == 	2001	;
replace  _cpi =	179.9	if wrkyr == 	2002	;
replace  _cpi =	184	if wrkyr == 	2003	;
replace  _cpi =	188.9	if wrkyr == 	2004	;
replace  _cpi =	195.3	if wrkyr == 	2005	;
replace  _cpi =	201.6	if wrkyr == 	2006	;
replace  _cpi =	207.342 if wrkyr == 	2007	;

generate _cpi_deflator2000 = 172.2 / _cpi ;

generate  _inctot_cpi = _inctot * _cpi_deflator2000 ;
label variable _inctot_cpi "Total personal income, in 2000 dollars";

generate  _incwage_cpi  =  _incwage  * _cpi_deflator2000 ;
label variable _incwage_cpi  "Wage and salary income, in 2000 dollars";

generate  _incbus_cpi   =  _incbus   * _cpi_deflator2000 ;
label variable _incbus_cpi   "Business income, in 2000 dollars";

generate  _hhincome_cpi =  _hhincome * _cpi_deflator2000 ;
label variable _hhincome_cpi "Total household income, in 2000 dollars";

sort wrkyr;
save temp, replace;

*** c. cutting outliers;
use temp, clear;
keep if _female==0;
keep if _white==1;
keep if _agelyr>=25 & _agelyr<=54;

collapse 
(p1)  pct01 = _inctot_cpi
(p99) pct99 = _inctot_cpi
[pw=_perwt], by(wrkyr);
sort wrkyr;
merge wrkyr using temp;
drop _merge*;

generate _inctot_cpi_tr01   = _inctot_cpi;
generate _inctot_cpi_tr99   = _inctot_cpi;
generate _inctot_cpi_tr0199 = _inctot_cpi;

replace  _inctot_cpi_tr01   = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr99   = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi_tr0199 < 0;

label variable _inctot_cpi_tr01   "Total personal income, in 2000 dollars, w/o 01 prc. outliers";
label variable _inctot_cpi_tr99   "Total personal income, in 2000 dollars, w/o 99 prc. outliers";
label variable _inctot_cpi_tr0199 "Total personal income, in 2000 dollars, w/o 01 and 99 prc. outliers";
drop pct01 pct99;


*** Main sample indicator ***;
generate main_sample = 1;
replace  main_sample = 0 if _agelyr < 25;
replace  main_sample = 0 if _agelyr > 54;
replace  main_sample = 0 if gq ~= 1;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;

keep if main_sample==1;

replace _inctot_cpi        = 1 if _inctot_cpi        <= 0;
replace _inctot_cpi_tr01   = 1 if _inctot_cpi_tr01   <= 0;
replace _inctot_cpi_tr99   = 1 if _inctot_cpi_tr99   <= 0;
replace _inctot_cpi_tr0199 = 1 if _inctot_cpi_tr0199 <= 0;

egen gini_inctot_cpi        = inequal(_inctot_cpi),        by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr01   = inequal(_inctot_cpi_tr01),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr99   = inequal(_inctot_cpi_tr99),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr0199 = inequal(_inctot_cpi_tr0199), by(statefip wrkyr) weights(_perwt) index(gini);

keep statefip wrkyr gini_*;
duplicates drop;
drop if gini_inctot_cpi        ==.;
drop if gini_inctot_cpi_tr01   ==.;
drop if gini_inctot_cpi_tr99   ==.;
drop if gini_inctot_cpi_tr0199 ==.;

generate log_gini_inctot_cpi        = log(gini_inctot_cpi);
generate log_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01);
generate log_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99);
generate log_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199);

generate logistic_gini_inctot_cpi        = log(gini_inctot_cpi/(1-gini_inctot_cpi));
generate logistic_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01/(1-gini_inctot_cpi_tr01));
generate logistic_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99/(1-gini_inctot_cpi_tr99));
generate logistic_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199/(1-gini_inctot_cpi_tr0199));

sort statefip wrkyr;
save temp, replace;


muse macro_workfile.dta, s w c 
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
save temp, replace;


***********************************************;
*** PANEL A: W/O UTAH, HAWAII, AND VIRGINIA ***;
***********************************************;
use temp, clear;
drop if statefip==49; *** Utah;
drop if statefip==15; *** Hawaii;
drop if statefip==51; *** Virginia;

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVIII.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("Robustness of the Results to Exclusion of Outlying States and Latest Years")
posthead("Panel A: Sample Excludes Utah, Hawaii, and Virginia")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


**************************;
*** PANEL B: 2000-2006 ***;
**************************;
use temp, clear;
drop if wrkyr>=2000;

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVIII.txt, append
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("Panel B: Sample Excludes the Years 2000-2006")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;

log close;









**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table IX in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
*** Note:    The calculation of Theil index is very time consuming
**********************************************************************************************************************************


#delimit;
clear;
set mem 2g;
set more off;



log using Appendix_TableIX.log, replace;

*******************************************;
*** CALCULATING THEIL INDEX FOR PANEL A ***;
*******************************************;
muse micro_workfile.dta, s w c
keep if main_sample == 1;

generate ok=0;
replace  ok=1 if classwly==13 | classwly==14;
replace  ok=1 if classwly>=22 & classwly<=28;
keep if ok==1;

*** Group 1 -- white;
*** Group 2 -- non-white;
generate group=.;
replace  group=1 if _white==1;
replace  group=2 if _white==0;
drop if group==.;
tab group, missing;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial group;

generate Y = _inctot_cpi_tr0199;

#delimit cr
generate total    = .
generate between  = .
generate within   = .
generate within_1 = .
generate within_2 = .

save temporary, replace

************
*** 1976 ***
************
use temporary, clear
keep if wrkyr==1976

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1976, replace

************
*** 1977 ***
************
use temporary, clear
keep if wrkyr==1977

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1977, replace

************
*** 1978 ***
************
use temporary, clear
keep if wrkyr==1978

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1978, replace

************
*** 1979 ***
************
use temporary, clear
keep if wrkyr==1979

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1979, replace

************
*** 1980 ***
************
use temporary, clear
keep if wrkyr==1980

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1980, replace


************
*** 1981 ***
************
use temporary, clear
keep if wrkyr==1981

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1981, replace

************
*** 1982 ***
************
use temporary, clear
keep if wrkyr==1982

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1982, replace

************
*** 1983 ***
************
use temporary, clear
keep if wrkyr==1983

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1983, replace

************
*** 1984 ***
************
use temporary, clear
keep if wrkyr==1984

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1984, replace

************
*** 1985 ***
************
use temporary, clear
keep if wrkyr==1985

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1985, replace

************
*** 1986 ***
************
use temporary, clear
keep if wrkyr==1986

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1986, replace

************
*** 1987 ***
************
use temporary, clear
keep if wrkyr==1987

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1987, replace

************
*** 1988 ***
************
use temporary, clear
keep if wrkyr==1988

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1988, replace

************
*** 1989 ***
************
use temporary, clear
keep if wrkyr==1989

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1989, replace

************
*** 1990 ***
************
use temporary, clear
keep if wrkyr==1990

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1990, replace

************
*** 1991 ***
************
use temporary, clear
keep if wrkyr==1991

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1991, replace

************
*** 1992 ***
************
use temporary, clear
keep if wrkyr==1992

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1992, replace

************
*** 1993 ***
************
use temporary, clear
keep if wrkyr==1993

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1993, replace

************
*** 1994 ***
************
use temporary, clear
keep if wrkyr==1994

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1994, replace

************
*** 1995 ***
************
use temporary, clear
keep if wrkyr==1995

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1995, replace

************
*** 1996 ***
************
use temporary, clear
keep if wrkyr==1996

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1996, replace

************
*** 1997 ***
************
use temporary, clear
keep if wrkyr==1997

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1997, replace

************
*** 1998 ***
************
use temporary, clear
keep if wrkyr==1998

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1998, replace

************
*** 1999 ***
************
use temporary, clear
keep if wrkyr==1999

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1999, replace

************
*** 2000 ***
************
use temporary, clear
keep if wrkyr==2000

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2000, replace

************
*** 2001 ***
************
use temporary, clear
keep if wrkyr==2001

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2001, replace

************
*** 2002 ***
************
use temporary, clear
keep if wrkyr==2002

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2002, replace

************
*** 2003 ***
************
use temporary, clear
keep if wrkyr==2003

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2003, replace

************
*** 2004 ***
************
use temporary, clear
keep if wrkyr==2004

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2004, replace

************
*** 2005 ***
************
use temporary, clear
keep if wrkyr==2005

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2005, replace

************
*** 2006 ***
************
use temporary, clear
keep if wrkyr==2006

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2006, replace

**********************************
*** POOLING ALL YEARS TOGETHER ***
**********************************
#delimit;
use theil1976, clear;
append using theil1977;
append using theil1978;
append using theil1979;
append using theil1980;
append using theil1981;
append using theil1982;
append using theil1983;
append using theil1984;
append using theil1985;
append using theil1986;
append using theil1987;
append using theil1988;
append using theil1989;
append using theil1990;
append using theil1991;
append using theil1992;
append using theil1993;
append using theil1994;
append using theil1995;
append using theil1996;
append using theil1997;
append using theil1998;
append using theil1999;
append using theil2000;
append using theil2001;
append using theil2002;
append using theil2003;
append using theil2004;
append using theil2005;
append using theil2006;
sort statefip wrkyr;
save Appendix_TableIXpanelA, replace;
erase theil1976.dta;
erase theil1977.dta;
erase theil1978.dta;
erase theil1979.dta;
erase theil1980.dta;
erase theil1981.dta;
erase theil1982.dta;
erase theil1983.dta;
erase theil1984.dta;
erase theil1985.dta;
erase theil1986.dta;
erase theil1987.dta;
erase theil1988.dta;
erase theil1989.dta;
erase theil1990.dta;
erase theil1991.dta;
erase theil1992.dta;
erase theil1993.dta;
erase theil1994.dta;
erase theil1995.dta;
erase theil1996.dta;
erase theil1997.dta;
erase theil1998.dta;
erase theil1999.dta;
erase theil2000.dta;
erase theil2001.dta;
erase theil2002.dta;
erase theil2003.dta;
erase theil2004.dta;
erase theil2005.dta;
erase theil2006.dta;



*******************************************;
*** CALCULATING THEIL INDEX FOR PANEL B ***;
*******************************************;
muse micro_workfile.dta, s w c
keep if main_sample == 1;

generate ok=0;
replace  ok=1 if classwly==13 | classwly==14;
replace  ok=1 if classwly>=22 & classwly<=28;
keep if ok==1;

*** Group 1 -- men;
*** Group 2 -- women;
generate group=.;
replace  group=1 if _female==0;
replace  group=2 if _female==1;
drop if group==.;
tab group, missing;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial group;

generate Y = _inctot_cpi_tr0199;

#delimit cr
generate total    = .
generate between  = .
generate within   = .
generate within_1 = .
generate within_2 = .

save temporary, replace

************
*** 1976 ***
************
use temporary, clear
keep if wrkyr==1976

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1976, replace

************
*** 1977 ***
************
use temporary, clear
keep if wrkyr==1977

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1977, replace

************
*** 1978 ***
************
use temporary, clear
keep if wrkyr==1978

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1978, replace

************
*** 1979 ***
************
use temporary, clear
keep if wrkyr==1979

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1979, replace

************
*** 1980 ***
************
use temporary, clear
keep if wrkyr==1980

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1980, replace


************
*** 1981 ***
************
use temporary, clear
keep if wrkyr==1981

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1981, replace

************
*** 1982 ***
************
use temporary, clear
keep if wrkyr==1982

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1982, replace

************
*** 1983 ***
************
use temporary, clear
keep if wrkyr==1983

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1983, replace

************
*** 1984 ***
************
use temporary, clear
keep if wrkyr==1984

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1984, replace

************
*** 1985 ***
************
use temporary, clear
keep if wrkyr==1985

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1985, replace

************
*** 1986 ***
************
use temporary, clear
keep if wrkyr==1986

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1986, replace

************
*** 1987 ***
************
use temporary, clear
keep if wrkyr==1987

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1987, replace

************
*** 1988 ***
************
use temporary, clear
keep if wrkyr==1988

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1988, replace

************
*** 1989 ***
************
use temporary, clear
keep if wrkyr==1989

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1989, replace

************
*** 1990 ***
************
use temporary, clear
keep if wrkyr==1990

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1990, replace

************
*** 1991 ***
************
use temporary, clear
keep if wrkyr==1991

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1991, replace

************
*** 1992 ***
************
use temporary, clear
keep if wrkyr==1992

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1992, replace

************
*** 1993 ***
************
use temporary, clear
keep if wrkyr==1993

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1993, replace

************
*** 1994 ***
************
use temporary, clear
keep if wrkyr==1994

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1994, replace

************
*** 1995 ***
************
use temporary, clear
keep if wrkyr==1995

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1995, replace

************
*** 1996 ***
************
use temporary, clear
keep if wrkyr==1996

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1996, replace

************
*** 1997 ***
************
use temporary, clear
keep if wrkyr==1997

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1997, replace

************
*** 1998 ***
************
use temporary, clear
keep if wrkyr==1998

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1998, replace

************
*** 1999 ***
************
use temporary, clear
keep if wrkyr==1999

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1999, replace

************
*** 2000 ***
************
use temporary, clear
keep if wrkyr==2000

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2000, replace

************
*** 2001 ***
************
use temporary, clear
keep if wrkyr==2001

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2001, replace

************
*** 2002 ***
************
use temporary, clear
keep if wrkyr==2002

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2002, replace

************
*** 2003 ***
************
use temporary, clear
keep if wrkyr==2003

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2003, replace

************
*** 2004 ***
************
use temporary, clear
keep if wrkyr==2004

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2004, replace

************
*** 2005 ***
************
use temporary, clear
keep if wrkyr==2005

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2005, replace

************
*** 2006 ***
************
use temporary, clear
keep if wrkyr==2006

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2006, replace

**********************************
*** POOLING ALL YEARS TOGETHER ***
**********************************
#delimit;
use theil1976, clear;
append using theil1977;
append using theil1978;
append using theil1979;
append using theil1980;
append using theil1981;
append using theil1982;
append using theil1983;
append using theil1984;
append using theil1985;
append using theil1986;
append using theil1987;
append using theil1988;
append using theil1989;
append using theil1990;
append using theil1991;
append using theil1992;
append using theil1993;
append using theil1994;
append using theil1995;
append using theil1996;
append using theil1997;
append using theil1998;
append using theil1999;
append using theil2000;
append using theil2001;
append using theil2002;
append using theil2003;
append using theil2004;
append using theil2005;
append using theil2006;
sort statefip wrkyr;
save Appendix_TableIXpanelB, replace;
erase theil1976.dta;
erase theil1977.dta;
erase theil1978.dta;
erase theil1979.dta;
erase theil1980.dta;
erase theil1981.dta;
erase theil1982.dta;
erase theil1983.dta;
erase theil1984.dta;
erase theil1985.dta;
erase theil1986.dta;
erase theil1987.dta;
erase theil1988.dta;
erase theil1989.dta;
erase theil1990.dta;
erase theil1991.dta;
erase theil1992.dta;
erase theil1993.dta;
erase theil1994.dta;
erase theil1995.dta;
erase theil1996.dta;
erase theil1997.dta;
erase theil1998.dta;
erase theil1999.dta;
erase theil2000.dta;
erase theil2001.dta;
erase theil2002.dta;
erase theil2003.dta;
erase theil2004.dta;
erase theil2005.dta;
erase theil2006.dta;


*******************************************************;
*** DECOMPOSING THE IMPACT OF DEREGULATION, PANEL A ***;
*******************************************************;
muse macro_workfile.dta, s w c 
sort statefip wrkyr;
merge statefip wrkyr using Appendix_TableIXpanelA;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg total _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Total);

xtreg between _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Between Groups);

xtreg within _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Within Groups);

xtreg within_1 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Self Employed);

xtreg within_2 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Salaried);

estout m1 m2 m3 m4 m5 using Appendix_TableIX.txt, replace
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("Decomposing the Impact of Deregulation on Income Inequality to Between- and Within-Groups")
posthead("Panel A: Decomposition by Ethnicity") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;



*******************************************************;
*** DECOMPOSING THE IMPACT OF DEREGULATION, PANEL B ***;
*******************************************************;
muse macro_workfile.dta, s w c 
sort statefip wrkyr;
merge statefip wrkyr using Appendix_TableIXpanelB;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg total _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Total);

xtreg between _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Between Groups);

xtreg within _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Within Groups);

xtreg within_1 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(High School or Less);

xtreg within_2 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Some College or More);

estout m1 m2 m3 m4 m5 using Appendix_TableIX.txt, append
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("")
posthead("Panel B: Decomposition by Gender") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;

erase temporary.dta;
log close;





















************************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Tables XA and XB in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
************************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set matsize 10000;
set more off;



log using Appendix_TableX.log, replace;

muse macro_workfile.dta, s w c 
generate base=1;
sort statefip wrkyr;
save temp, replace;


*************************;
*** unemployment rate ***;
*************************;
muse bls.dta, s w c
rename year wrkyr;
keep statefip wrkyr unemploymentrate;
sort statefip wrkyr;
bysort statefip: generate unemploymentrate_1=unemploymentrate[_n-1];
bysort statefip: generate unemploymentrate_2=unemploymentrate[_n-2];
bysort statefip: generate unemploymentrate_3=unemploymentrate[_n-3];
bysort statefip: generate unemploymentrate_4=unemploymentrate[_n-4];
bysort statefip: generate unemploymentrate_5=unemploymentrate[_n-5];
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;
keep if base==1;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);


****************;
*** LOG GINI ***;
****************;
xtreg log_gini _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg log_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg log_gini _intra `Xs' unemploymentrate_1 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));


estout m1 m2 m3 m4 m5 m6 m7 using Appendix_TableXA.txt, replace
keep(_intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5)
cells(b(star fmt(3)) se(par)) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


*********************;
*** LOGISTIC GINI ***;
*********************;
xtreg logistic_gini _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

estout m1 m2 m3 m4 m5 m6 m7 using Appendix_TableXB.txt, replace
keep(_intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5)
cells(b(star fmt(3)) se(par)) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


erase temp.dta;
log close;












**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Figure 1 in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************


#delimit;
clear;
set more off;
set memory 100m;
set matsize 10000;



log using Appendix_Figure1.log, replace;

muse macro_workfile.dta, s w c 
tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate temporary=.;
replace  temporary=unemploymentrate if wrkyr==1976;
bysort statefip: egen u1976=mean(temporary);
drop temporary;
save stam, replace;


*********************;
*** LOGISTIC GINI ***;
*********************;
use stam, clear;
generate Y = log(gini/(1-gini));

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "Logistic(Gini)";
save measure1, replace;


*****************;
*** LOG THEIL ***;
*****************;
use stam, clear;
generate Y = log(theil);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "Log(Theil)";
save measure2, replace;


*************;
*** 90/10 ***;
*************;
use stam, clear;
generate Y = log(p90)-log(p10);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "90/10 ratio";
save measure3, replace;


*************;
*** 75/25 ***;
*************;
use stam, clear;
generate Y = log(p75)-log(p25);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "75/25 ratio";
save measure4, replace;

use measure1, clear;
append using measure2;

label var measure "measures of income inequality";
twoway (bar b u1976 if significant==0, sort fcolor(navy) lcolor(navy) barwidth(0.6) fintensity(30)) 
       (bar b u1976 if significant==1, sort fcolor(navy) lcolor(navy) barwidth(0.6)), 
       ytitle(Change in income inequality) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal)) 
       xtitle(Initial unemployment rate) xtitle(, size(small) margin(medsmall)) xlabel(1(1)4, valuelabel) 
       by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
       by(measure) 
       subtitle(, size(medsmall) nobox) 
       legend(order(1 "Not significant" 2 "Significant at 10%") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Appendix_Figure1A, asis replace;
       

use measure3, clear;
append using measure4;
label var measure "measures of income inequality";

twoway (bar b u1976 if significant==0, sort fcolor(navy) lcolor(navy) barwidth(0.6) fintensity(30)) 
       (bar b u1976 if significant==1, sort fcolor(navy) lcolor(navy) barwidth(0.6)), 
       ytitle(Change in income inequality) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal)) 
       xtitle(Initial unemployment rate) xtitle(, size(small) margin(medsmall)) xlabel(1(1)4, valuelabel) 
       by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
       by(measure) 
       subtitle(, size(medsmall) nobox) 
       legend(order(1 "Not significant" 2 "Significant at 10%") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Appendix_Figure1B, asis replace;

erase temporary.dta;
erase stam.dta;
erase betas.dta;
erase measure1.dta;
erase measure2.dta;
erase measure3.dta;
erase measure4.dta;

log close;





