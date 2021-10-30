**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Table  in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


*** tabel 1

#delimit;
clear;
set mem 100m;
set more off;



log using TableI.log, replace;

muse macro_workfile.dta, clear;

keep if ks99==1;
drop if inter1 == . | inter2 == .;

replace gini = gini * 100;

label var gini "Gini coefficient of income inequality";

replace wrkyr = wrkyr - 1975;

local financialXs ass4_ass cap_dif4 inter1 ins_dum inter2 e_interp dem uniform lncon1 unit bankpow;
local laborXs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

stset wrkyr death, id(statefip);

streg gini, robust cluster(statefip) dist(weibull) time;
estimates store m1, title((1));

streg gini `laborXs', robust cluster(statefip) dist(weibull) time;
estimates store m2, title((2));

streg gini `financialXs', robust cluster(statefip) dist(weibull) time;
estimates store m3, title((3));

streg gini `laborXs' `financialXs', robust cluster(statefip) dist(weibull) time;
estimates store m4, title((4));

streg gini `laborXs' `financialXs' reg1-reg3, robust cluster(statefip) dist(weibull) time;
estimates store m5, title((5));

estout m1 m2 m3 m4 m5 using TableI.txt, replace
keep(gini)
cells(b(star fmt(2)) se(par)) stats(N, labels(Observations) fmt(0)) 
legend label collabel(none)  
prehead("Table I" "Timing of Bank Deregulation and Pre-Existing Income Inequality: The Duration Model") 
posthead("") prefoot("") 
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;


log close;




*** tabel 2

#delimit;
clear;
set mem 100m;
set more off;



log using TableII.log, replace;

muse macro_workfile.dta, clear;

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

xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);

xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);

xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);

xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableII.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("Table II" "The Impact of Deregulation on Income Inequality")
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


estout m1 m2 m3 m4 m5 using TableII.txt, append
keep(_intra `Xs')
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
posthead("Panel B: With controls")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

log close;



*** tabel 3

#delimit;
clear;
set mem 100m;
set more off;



log using TableIII.log, replace;

muse macro_workfile.dta", clear;

generate Y = log(gini/(1-gini));

tsset statefip wrkyr;

tabulate wrkyr, gen(year_dumm);


*** Column (1) ***;
generate _intra_unit = _intra*unit_banking;
label var _intra_unit "Deregulation x (unit banking)";
xtreg Y _intra unit_banking _intra_unit year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + _intra_unit; 


*** Column (2) ***;
generate _intra_dispersion = _intra*pop_dispersion;
label var _intra_dispersion "Deregulation x (initial population dispersion)";
sum pop_dispersion;
xtreg Y _intra pop_dispersion _intra_dispersion year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.0099*_intra_dispersion;
lincom _intra + 0.0148*_intra_dispersion;
lincom _intra + 0.0376*_intra_dispersion;


*** Column (3) ***;
generate _intra_smallbanks = _intra*small_banks;
label var _intra_smallbanks "Deregulation x (initial share of small banks)";
sum small_banks, detail;
xtreg Y _intra small_banks _intra_smallbanks year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.074*_intra_smallbanks;
lincom _intra + 0.109*_intra_smallbanks;
lincom _intra + 0.137*_intra_smallbanks;


*** Column (4) ***;
generate _intra_smallfirms = _intra*small_firms;
label var _intra_smallfirms "Deregulation x (initial share of small firms)";
sum small_firms, detail;
xtreg Y _intra small_firms _intra_smallfirms year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.877*_intra_smallfirms;
lincom _intra + 0.885*_intra_smallfirms;
lincom _intra + 0.894*_intra_smallfirms;

log close;






*** tabel 4

#delimit;
clear;
set mem 2g;
set more off;



log using TableIV.log, replace;

*******************************************;
*** CALCULATING THEIL INDEX FOR PANEL A ***;
*******************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;

*** Group 1 -- self-employed;
*** Group 2 -- wage and salary workers;
generate group=.;
replace  group=1 if classwly==13 | classwly==14;
replace  group=2 if classwly>=22 & classwly<=28;
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
save TableIVpanelA, replace;
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
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if classwly>=22 & classwly<=28;

*** Group 1 -- education 0-12;
*** Group 2 -- education 13+;
generate group=.;
replace  group=1 if _hsd08==1 | _hsd911==1 | _hsg==1;
replace  group=2 if _sc==1 | _cg==1 | _ad==1;
replace  group=2 if educrec==9;
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
save TableIVpanelB, replace;
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
muse macro_workfile.dta, clear;
sort statefip wrkyr;
merge statefip wrkyr using TableIVpanelA;
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

estout m1 m2 m3 m4 m5 using TableIV.txt, replace
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("Table 2" "Decomposing the Impact of Deregulation on Income Inequality to Between- and Within-Groups")
posthead("Panel A: All Workers") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;



*******************************************************;
*** DECOMPOSING THE IMPACT OF DEREGULATION, PANEL B ***;
*******************************************************;
muse macro_workfile.dta, clear;
sort statefip wrkyr;
merge statefip wrkyr using TableIVpanelB;
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

estout m1 m2 m3 m4 m5 using TableIV.txt, append
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("")
posthead("Panel B: Salaried Workers") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;

erase temporary.dta;
log close;













*** tabel 5

#delimit;
clear;
set more off;
set memory 4g;


log using TableV.log, replace;

******************************************;
*** AGES 25-35, UNCONDITIONAL EARNINGS ***;
******************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=25 & _agelyr<=35;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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
save ind_inequality_earnings2535, replace;


******************************************;
*** AGES 36-45, UNCONDITIONAL EARNINGS ***;
******************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=36 & _agelyr<=45;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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
save ind_inequality_earnings3645, replace;


******************************************;
*** AGES 46-54, UNCONDITIONAL EARNINGS ***;
******************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=46 & _agelyr<=54;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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

save ind_inequality_earnings4654, replace;


***********************;
*** ALL AGES POOLED ***;
***********************;
use ind_inequality_earnings2535.dta, clear;
generate ages = "25-35";
save temp2535, replace;

use ind_inequality_earnings3645.dta, clear;
generate ages = "36-45";
save temp3645, replace;

use ind_inequality_earnings4654.dta, clear;
generate ages = "46-54";
save temp4654, replace;

use temp2535, clear;
append using temp3645.dta;
append using temp4654.dta;
sort statefip wrkyr;
save temp, replace;

muse macro_workfile.dta, clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

generate age2535=0;
generate age3645=0;
generate age4654=0;

replace age2535=1 if ages=="25-35";
replace age3645=1 if ages=="36-45";
replace age4654=1 if ages=="46-54";

generate _intra2535 = _intra*age2535;
generate _intra3645 = _intra*age3645;
generate _intra4654 = _intra*age4654;

tostring wrkyr, generate(year_string);
tostring statefip, generate(statefip_string);
generate year_age = year_string + ages;
generate state_age = statefip_string + ages;
quietly tabulate year_age, gen(year_age_dumm);
quietly tabulate state_age, gen(state_age_dumm);


regress logistic_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m1, title(Logistic Gini);

regress log_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m2, title(Log Gini);

regress log_theil _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m3, title(Log Theil);

regress log_9010 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m4, title(Log 90/10);

regress log_7525 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableV.txt, replace
keep(_intra _intra3645 _intra4654)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Earnings Inequality")
posthead("Panel A: Unconditional Earnings")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);



*****************************************************;
*** AGES 25-35, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=25 & _agelyr<=35;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings2535, replace;


*****************************************************;
*** AGES 36-45, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=36 & _agelyr<=45;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings3645, replace;


*****************************************************;
*** AGES 46-54, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
muse micro_workfile.dta, clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=46 & _agelyr<=54;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings4654, replace;


***********************;
*** ALL AGES POOLED ***;
***********************;
use ind_inequality_earnings2535.dta, clear;
generate ages = "25-35";
save temp2535, replace;

use ind_inequality_earnings3645.dta, clear;
generate ages = "36-45";
save temp3645, replace;

use ind_inequality_earnings4654.dta, clear;
generate ages = "46-54";
save temp4654, replace;

use temp2535, clear;
append using temp3645.dta;
append using temp4654.dta;
sort statefip wrkyr;
save temp, replace;

muse macro_workfile.dta, clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

generate age2535=0;
generate age3645=0;
generate age4654=0;

replace age2535=1 if ages=="25-35";
replace age3645=1 if ages=="36-45";
replace age4654=1 if ages=="46-54";

generate _intra2535 = _intra*age2535;
generate _intra3645 = _intra*age3645;
generate _intra4654 = _intra*age4654;

tostring wrkyr, generate(year_string);
tostring statefip, generate(statefip_string);
generate year_age = year_string + ages;
generate state_age = statefip_string + ages;
quietly tabulate year_age, gen(year_age_dumm);
quietly tabulate state_age, gen(state_age_dumm);


regress logistic_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m1, title(Logistic Gini);

regress log_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m2, title(Log Gini);

regress log_theil _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m3, title(Log Theil);

regress log_9010 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m4, title(Log 90/10);

regress log_7525 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableV.txt, append
keep(_intra _intra3645 _intra4654)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("Panel B: Earnings Conditional on Education")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
erase temp2535.dta;
erase temp3645.dta;
erase temp4654.dta;
erase percentiles.dta;
erase ind_inequality_earnings2535.dta;
erase ind_inequality_earnings3645.dta;
erase ind_inequality_earnings4654.dta;
log close;

