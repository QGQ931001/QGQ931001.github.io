**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Figure  in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


*** figure 1

#delimit;
clear;
set more off;
set memory 100m;


log using Figure1.log, replace;

**************;
*** LEVELS ***;
**************;
muse macro_workfile.dta, s w c
generate log_gini = log(gini);
xi: regress log_gini i.wrkyr;
predict r, residual;
keep if wrkyr<branch_reform;

bysort statefip: egen mean_gini = mean(r);
keep statefip state mean_gini branch_reform;
duplicates drop;

regress branch_reform mean_gini, robust;
twoway (scatter branch_reform mean_gini, msymbol(circle_hollow) mcolor(navy) mlabel(state) mlabcolor(navy)), 
       subtitle("(A)", size(small))
       ytitle("Year of bank deregulation") ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Average Gini coefficient prior to bank deregulation) xtitle(, size(small) margin(medsmall)) xlabel(, labsize(small)) 
       legend(off) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure1A, asis replace;

       
***************;       
*** CHANGES ***;
***************;
muse macro_workfile.dta, s w c
generate log_gini = log(gini);
sort statefip wrkyr;
bysort statefip: generate log_gini_lag = log_gini[_n-1]; 
generate d = log_gini - log_gini_lag;
xi: regress d i.wrkyr;
predict r, residual;
keep if wrkyr<branch_reform;

bysort statefip: egen growth = mean(r);
keep statefip state branch_reform growth;
duplicates drop;

regress branch_reform growth, robust;
twoway (scatter branch_reform growth, msymbol(circle_hollow) mcolor(navy) mlabel(state) mlabcolor(navy)), 
       subtitle("(B)", size(small))
       ytitle("Year of bank deregulation") ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Average change in the Gini coefficient prior to bank deregulation) xtitle(, size(small) margin(medsmall)) xlabel(, labsize(small)) 
       legend(off) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure1B, asis replace;
       
log close;





*** figure 2

#delimit;
clear;
set mem 100m;
set more off;



log using Figure2.log, replace;

muse macro_workfile.dta, s w c

replace p1=log(p1);
replace p2=log(p2);
replace p3=log(p3);
replace p4=log(p4);
replace p5=log(p5);
replace p6=log(p6);
replace p7=log(p7);
replace p8=log(p8);
replace p9=log(p9);
replace p10=log(p10);
replace p11=log(p11);
replace p12=log(p12);
replace p13=log(p13);
replace p14=log(p14);
replace p15=log(p15);
replace p16=log(p16);
replace p17=log(p17);
replace p18=log(p18);
replace p19=log(p19);
replace p20=log(p20);
replace p21=log(p21);
replace p22=log(p22);
replace p23=log(p23);
replace p24=log(p24);
replace p25=log(p25);
replace p26=log(p26);
replace p27=log(p27);
replace p28=log(p28);
replace p29=log(p29);
replace p30=log(p30);
replace p31=log(p31);
replace p32=log(p32);
replace p33=log(p33);
replace p34=log(p34);
replace p35=log(p35);
replace p36=log(p36);
replace p37=log(p37);
replace p38=log(p38);
replace p39=log(p39);
replace p40=log(p40);
replace p41=log(p41);
replace p42=log(p42);
replace p43=log(p43);
replace p44=log(p44);
replace p45=log(p45);
replace p46=log(p46);
replace p47=log(p47);
replace p48=log(p48);
replace p49=log(p49);
replace p50=log(p50);
replace p51=log(p51);
replace p52=log(p52);
replace p53=log(p53);
replace p54=log(p54);
replace p55=log(p55);
replace p56=log(p56);
replace p57=log(p57);
replace p58=log(p58);
replace p59=log(p59);
replace p60=log(p60);
replace p61=log(p61);
replace p62=log(p62);
replace p63=log(p63);
replace p64=log(p64);
replace p65=log(p65);
replace p66=log(p66);
replace p67=log(p67);
replace p68=log(p68);
replace p69=log(p69);
replace p70=log(p70);
replace p71=log(p71);
replace p72=log(p72);
replace p73=log(p73);
replace p74=log(p74);
replace p75=log(p75);
replace p76=log(p76);
replace p77=log(p77);
replace p78=log(p78);
replace p79=log(p79);
replace p80=log(p80);
replace p81=log(p81);
replace p82=log(p82);
replace p83=log(p83);
replace p84=log(p84);
replace p85=log(p85);
replace p86=log(p86);
replace p87=log(p87);
replace p88=log(p88);
replace p89=log(p89);
replace p90=log(p90);
replace p91=log(p91);
replace p92=log(p92);
replace p93=log(p93);
replace p94=log(p94);
replace p95=log(p95);
replace p96=log(p96);
replace p97=log(p97);
replace p98=log(p98);
replace p99=log(p99);

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg p1 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg p2 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg p3 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg p4 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

xtreg p5 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b5=_b[_intra];
gen   s5=_se[_intra];

xtreg p6 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b6=_b[_intra];
gen   s6=_se[_intra];

xtreg p7 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b7=_b[_intra];
gen   s7=_se[_intra];

xtreg p8 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b8=_b[_intra];
gen   s8=_se[_intra];

xtreg p9 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b9=_b[_intra];
gen   s9=_se[_intra];

xtreg p10 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b10=_b[_intra];
gen   s10=_se[_intra];

xtreg p11 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b11=_b[_intra];
gen   s11=_se[_intra];

xtreg p12 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b12=_b[_intra];
gen   s12=_se[_intra];

xtreg p13 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b13=_b[_intra];
gen   s13=_se[_intra];

xtreg p14 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b14=_b[_intra];
gen   s14=_se[_intra];

xtreg p15 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b15=_b[_intra];
gen   s15=_se[_intra];

xtreg p16 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b16=_b[_intra];
gen   s16=_se[_intra];

xtreg p17 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b17=_b[_intra];
gen   s17=_se[_intra];

xtreg p18 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b18=_b[_intra];
gen   s18=_se[_intra];

xtreg p19 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b19=_b[_intra];
gen   s19=_se[_intra];

xtreg p20 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b20=_b[_intra];
gen   s20=_se[_intra];

xtreg p21 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b21=_b[_intra];
gen   s21=_se[_intra];

xtreg p22 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b22=_b[_intra];
gen   s22=_se[_intra];

xtreg p23 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b23=_b[_intra];
gen   s23=_se[_intra];

xtreg p24 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b24=_b[_intra];
gen   s24=_se[_intra];

xtreg p25 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b25=_b[_intra];
gen   s25=_se[_intra];

xtreg p26 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b26=_b[_intra];
gen   s26=_se[_intra];

xtreg p27 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b27=_b[_intra];
gen   s27=_se[_intra];

xtreg p28 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b28=_b[_intra];
gen   s28=_se[_intra];

xtreg p29 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b29=_b[_intra];
gen   s29=_se[_intra];

xtreg p30 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b30=_b[_intra];
gen   s30=_se[_intra];

xtreg p31 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b31=_b[_intra];
gen   s31=_se[_intra];

xtreg p32 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b32=_b[_intra];
gen   s32=_se[_intra];

xtreg p33 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b33=_b[_intra];
gen   s33=_se[_intra];

xtreg p34 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b34=_b[_intra];
gen   s34=_se[_intra];

xtreg p35 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b35=_b[_intra];
gen   s35=_se[_intra];

xtreg p36 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b36=_b[_intra];
gen   s36=_se[_intra];

xtreg p37 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b37=_b[_intra];
gen   s37=_se[_intra];

xtreg p38 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b38=_b[_intra];
gen   s38=_se[_intra];

xtreg p39 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b39=_b[_intra];
gen   s39=_se[_intra];

xtreg p40 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b40=_b[_intra];
gen   s40=_se[_intra];

xtreg p41 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b41=_b[_intra];
gen   s41=_se[_intra];

xtreg p42 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b42=_b[_intra];
gen   s42=_se[_intra];

xtreg p43 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b43=_b[_intra];
gen   s43=_se[_intra];

xtreg p44 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b44=_b[_intra];
gen   s44=_se[_intra];

xtreg p45 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b45=_b[_intra];
gen   s45=_se[_intra];

xtreg p46 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b46=_b[_intra];
gen   s46=_se[_intra];

xtreg p47 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b47=_b[_intra];
gen   s47=_se[_intra];

xtreg p48 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b48=_b[_intra];
gen   s48=_se[_intra];

xtreg p49 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b49=_b[_intra];
gen   s49=_se[_intra];

xtreg p50 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b50=_b[_intra];
gen   s50=_se[_intra];

xtreg p51 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b51=_b[_intra];
gen   s51=_se[_intra];

xtreg p52 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b52=_b[_intra];
gen   s52=_se[_intra];

xtreg p53 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b53=_b[_intra];
gen   s53=_se[_intra];

xtreg p54 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b54=_b[_intra];
gen   s54=_se[_intra];

xtreg p55 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b55=_b[_intra];
gen   s55=_se[_intra];

xtreg p56 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b56=_b[_intra];
gen   s56=_se[_intra];

xtreg p57 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b57=_b[_intra];
gen   s57=_se[_intra];

xtreg p58 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b58=_b[_intra];
gen   s58=_se[_intra];

xtreg p59 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b59=_b[_intra];
gen   s59=_se[_intra];

xtreg p60 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b60=_b[_intra];
gen   s60=_se[_intra];

xtreg p61 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b61=_b[_intra];
gen   s61=_se[_intra];

xtreg p62 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b62=_b[_intra];
gen   s62=_se[_intra];

xtreg p63 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b63=_b[_intra];
gen   s63=_se[_intra];

xtreg p64 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b64=_b[_intra];
gen   s64=_se[_intra];

xtreg p65 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b65=_b[_intra];
gen   s65=_se[_intra];

xtreg p66 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b66=_b[_intra];
gen   s66=_se[_intra];

xtreg p67 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b67=_b[_intra];
gen   s67=_se[_intra];

xtreg p68 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b68=_b[_intra];
gen   s68=_se[_intra];

xtreg p69 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b69=_b[_intra];
gen   s69=_se[_intra];

xtreg p70 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b70=_b[_intra];
gen   s70=_se[_intra];

xtreg p71 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b71=_b[_intra];
gen   s71=_se[_intra];

xtreg p72 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b72=_b[_intra];
gen   s72=_se[_intra];

xtreg p73 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b73=_b[_intra];
gen   s73=_se[_intra];

xtreg p74 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b74=_b[_intra];
gen   s74=_se[_intra];

xtreg p75 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b75=_b[_intra];
gen   s75=_se[_intra];

xtreg p76 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b76=_b[_intra];
gen   s76=_se[_intra];

xtreg p77 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b77=_b[_intra];
gen   s77=_se[_intra];

xtreg p78 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b78=_b[_intra];
gen   s78=_se[_intra];

xtreg p79 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b79=_b[_intra];
gen   s79=_se[_intra];

xtreg p80 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b80=_b[_intra];
gen   s80=_se[_intra];

xtreg p81 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b81=_b[_intra];
gen   s81=_se[_intra];

xtreg p82 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b82=_b[_intra];
gen   s82=_se[_intra];

xtreg p83 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b83=_b[_intra];
gen   s83=_se[_intra];

xtreg p84 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b84=_b[_intra];
gen   s84=_se[_intra];

xtreg p85 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b85=_b[_intra];
gen   s85=_se[_intra];

xtreg p86 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b86=_b[_intra];
gen   s86=_se[_intra];

xtreg p87 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b87=_b[_intra];
gen   s87=_se[_intra];

xtreg p88 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b88=_b[_intra];
gen   s88=_se[_intra];

xtreg p89 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b89=_b[_intra];
gen   s89=_se[_intra];

xtreg p90 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b90=_b[_intra];
gen   s90=_se[_intra];

xtreg p91 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b91=_b[_intra];
gen   s91=_se[_intra];

xtreg p92 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b92=_b[_intra];
gen   s92=_se[_intra];

xtreg p93 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b93=_b[_intra];
gen   s93=_se[_intra];

xtreg p94 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b94=_b[_intra];
gen   s94=_se[_intra];

xtreg p95 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b95=_b[_intra];
gen   s95=_se[_intra];

xtreg p96 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b96=_b[_intra];
gen   s96=_se[_intra];

xtreg p97 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b97=_b[_intra];
gen   s97=_se[_intra];

xtreg p98 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b98=_b[_intra];
gen   s98=_se[_intra];

xtreg p99 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b99=_b[_intra];
gen   s99=_se[_intra];

keep b1-b99 s1-s99;
duplicates drop;
save temp, replace;

use temp, clear;
keep b1  b2  b3  b4  b5  b6  b7  b8  b9  b10
     b11 b12 b13 b14 b15 b16 b17 b18 b19 b20
     b21 b22 b23 b24 b25 b26 b27 b28 b29 b30
     b31 b32 b33 b34 b35 b36 b37 b38 b39 b40
     b41 b42 b43 b44 b45 b46 b47 b48 b49 b50
     b51 b52 b53 b54 b55 b56 b57 b58 b59 b60
     b61 b62 b63 b64 b65 b66 b67 b68 b69 b70
     b71 b72 b73 b74 b75 b76 b77 b78 b79 b80
     b81 b82 b83 b84 b85 b86 b87 b88 b89 b90
     b91 b92 b93 b94 b95 b96 b97 b98 b99;
xpose, clear;
rename v1 b;
gen percentile=_n;
sort percentile;
save betas, replace;

use temp, clear;
keep s1  s2  s3  s4  s5  s6  s7  s8  s9  s10
     s11 s12 s13 s14 s15 s16 s17 s18 s19 s20
     s21 s22 s23 s24 s25 s26 s27 s28 s29 s30
     s31 s32 s33 s34 s35 s36 s37 s38 s39 s40
     s41 s42 s43 s44 s45 s46 s47 s48 s49 s50
     s51 s52 s53 s54 s55 s56 s57 s58 s59 s60
     s61 s62 s63 s64 s65 s66 s67 s68 s69 s70
     s71 s72 s73 s74 s75 s76 s77 s78 s79 s80
     s81 s82 s83 s84 s85 s86 s87 s88 s89 s90
     s91 s92 s93 s94 s95 s96 s97 s98 s99;
xpose, clear;
rename v1 se;
gen percentile=_n;
sort percentile;
merge percentile using betas;
drop _merge*;

gen ci_lb = b-1.96*se;
gen ci_ub = b+1.96*se;

drop if percentile<=4;
drop if percentile>=6  & percentile<10;
drop if percentile>=11 & percentile<15;
drop if percentile>=16 & percentile<20;
drop if percentile>=21 & percentile<25;
drop if percentile>=26 & percentile<30;
drop if percentile>=31 & percentile<35;
drop if percentile>=36 & percentile<40;
drop if percentile>=41 & percentile<45;
drop if percentile>=46 & percentile<50;
drop if percentile>=51 & percentile<55;
drop if percentile>=56 & percentile<60;
drop if percentile>=61 & percentile<65;
drop if percentile>=66 & percentile<70;
drop if percentile>=71 & percentile<75;
drop if percentile>=76 & percentile<80;
drop if percentile>=81 & percentile<85;
drop if percentile>=86 & percentile<90;
drop if percentile>=91 & percentile<95;
drop if percentile>=96;


twoway (bar b percentile if percentile<=35, sort fcolor(navy) lcolor(navy) barwidth(3))
       (bar b percentile if percentile>=40, sort fcolor(navy) lcolor(navy) barwidth(3) fintensity(30)), 
       ytitle(Percentage change) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Percentile of income distribution) xtitle(, size(small)) xlabel(5(5)95, labsize(small)) 
       legend(order(1 "Significant at 5%" 2 "Not significant") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure2, asis replace;

erase temp.dta;
erase betas.dta;
     
log close;





*** figure 3

#delimit;
clear;
set mem 100m;
set more off;



log using Figure3.log, replace;

muse macro_workfile.dta, s w c

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

generate _tintra = wrkyr - branch_reform;

replace _tintra = -10 if _tintra <-10;
replace _tintra =  15 if _tintra > 15;

tab _tintra, missing;

generate d_10 = 0; replace d_10 = 1 if _tintra == -10;
generate d_9  = 0; replace d_9  = 1 if _tintra == -9;
generate d_8  = 0; replace d_8  = 1 if _tintra == -8;
generate d_7  = 0; replace d_7  = 1 if _tintra == -7;
generate d_6  = 0; replace d_6  = 1 if _tintra == -6;
generate d_5  = 0; replace d_5  = 1 if _tintra == -5;
generate d_4  = 0; replace d_4  = 1 if _tintra == -4;
generate d_3  = 0; replace d_3  = 1 if _tintra == -3;
generate d_2  = 0; replace d_2  = 1 if _tintra == -2;
generate d_1  = 0; replace d_1  = 1 if _tintra == -1;

generate d1  = 0; replace d1  = 1 if _tintra == 1;
generate d2  = 0; replace d2  = 1 if _tintra == 2;
generate d3  = 0; replace d3  = 1 if _tintra == 3;
generate d4  = 0; replace d4  = 1 if _tintra == 4;
generate d5  = 0; replace d5  = 1 if _tintra == 5;
generate d6  = 0; replace d6  = 1 if _tintra == 6;
generate d7  = 0; replace d7  = 1 if _tintra == 7;
generate d8  = 0; replace d8  = 1 if _tintra == 8;
generate d9  = 0; replace d9  = 1 if _tintra == 9;
generate d10 = 0; replace d10 = 1 if _tintra == 10;
generate d11 = 0; replace d11 = 1 if _tintra == 11;
generate d12 = 0; replace d12 = 1 if _tintra == 12;
generate d13 = 0; replace d13 = 1 if _tintra == 13;
generate d14 = 0; replace d14 = 1 if _tintra == 14;
generate d15 = 0; replace d15 = 1 if _tintra == 15;

generate t5 = invttail(48,0.025);

generate y=log(gini);

xtreg y d_10-d15 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

generate b_10 = _b[d_10]; generate se_b_10 = _se[d_10];
generate b_10LB = b_10 - t5*se_b_10;
generate b_10UB = b_10 + t5*se_b_10;

generate b_9 = _b[d_9]; generate se_b_9 = _se[d_9];
generate b_9LB = b_9 - t5*se_b_9;
generate b_9UB = b_9 + t5*se_b_9;

generate b_8 = _b[d_8]; generate se_b_8 = _se[d_8];
generate b_8LB = b_8 - t5*se_b_8;
generate b_8UB = b_8 + t5*se_b_8;

generate b_7 = _b[d_7]; generate se_b_7 = _se[d_7];
generate b_7LB = b_7 - t5*se_b_7;
generate b_7UB = b_7 + t5*se_b_7;

generate b_6 = _b[d_6]; generate se_b_6 = _se[d_6];
generate b_6LB = b_6 - t5*se_b_6;
generate b_6UB = b_6 + t5*se_b_6;

generate b_5 = _b[d_5]; generate se_b_5 = _se[d_5];
generate b_5LB = b_5 - t5*se_b_5;
generate b_5UB = b_5 + t5*se_b_5;

generate b_4 = _b[d_4]; generate se_b_4 = _se[d_4];
generate b_4LB = b_4 - t5*se_b_4;
generate b_4UB = b_4 + t5*se_b_4;

generate b_3 = _b[d_3]; generate se_b_3 = _se[d_3];
generate b_3LB = b_3 - t5*se_b_3;
generate b_3UB = b_3 + t5*se_b_3;

generate b_2 = _b[d_2]; generate se_b_2 = _se[d_2];
generate b_2LB = b_2 - t5*se_b_2;
generate b_2UB = b_2 + t5*se_b_2;

generate b_1 = _b[d_1]; generate se_b_1 = _se[d_1];
generate b_1LB = b_1 - t5*se_b_1;
generate b_1UB = b_1 + t5*se_b_1;

generate b1 = _b[d1]; generate se_b1 = _se[d1];
generate b1LB = b1 - t5*se_b1;
generate b1UB = b1 + t5*se_b1;

generate b2 = _b[d2]; generate se_b2 = _se[d2];
generate b2LB = b2 - t5*se_b2;
generate b2UB = b2 + t5*se_b2;

generate b3 = _b[d3]; generate se_b3 = _se[d3];
generate b3LB = b3 - t5*se_b3;
generate b3UB = b3 + t5*se_b3;

generate b4 = _b[d4]; generate se_b4 = _se[d4];
generate b4LB = b4 - t5*se_b4;
generate b4UB = b4 + t5*se_b4;

generate b5 = _b[d5]; generate se_b5 = _se[d5];
generate b5LB = b5 - t5*se_b5;
generate b5UB = b5 + t5*se_b5;

generate b6 = _b[d6]; generate se_b6 = _se[d6];
generate b6LB = b6 - t5*se_b6;
generate b6UB = b6 + t5*se_b6;

generate b7 = _b[d7]; generate se_b7 = _se[d7];
generate b7LB = b7 - t5*se_b7;
generate b7UB = b7 + t5*se_b7;

generate b8 = _b[d8]; generate se_b8 = _se[d8];
generate b8LB = b8 - t5*se_b8;
generate b8UB = b8 + t5*se_b8;

generate b9 = _b[d9]; generate se_b9 = _se[d9];
generate b9LB = b9 - t5*se_b9;
generate b9UB = b9 + t5*se_b9;

generate b10 = _b[d10]; generate se_b10 = _se[d10];
generate b10LB = b10 - t5*se_b10;
generate b10UB = b10 + t5*se_b10;

generate b11 = _b[d11]; generate se_b11 = _se[d11];
generate b11LB = b11 - t5*se_b11;
generate b11UB = b11 + t5*se_b11;

generate b12 = _b[d12]; generate se_b12 = _se[d12];
generate b12LB = b12 - t5*se_b12;
generate b12UB = b12 + t5*se_b12;

generate b13 = _b[d13]; generate se_b13 = _se[d13];
generate b13LB = b13 - t5*se_b13;
generate b13UB = b13 + t5*se_b13;

generate b14 = _b[d14]; generate se_b14 = _se[d14];
generate b14LB = b14 - t5*se_b14;
generate b14UB = b14 + t5*se_b14;

generate b15 = _b[d15]; generate se_b15 = _se[d15];
generate b15LB = b15 - t5*se_b15;
generate b15UB = b15 + t5*se_b15;

generate x=(b_10+b_9+b_8+b_7+b_6+b_5+b_4+b_3+b_2+b_1)/10;

generate b = .;
generate LB = .;
generate UB = .;

replace b = b_10  if _tintra == -10;
replace b = b_9  if _tintra == -9;
replace b = b_8  if _tintra == -8;
replace b = b_7  if _tintra == -7;
replace b = b_6  if _tintra == -6;
replace b = b_5  if _tintra == -5;
replace b = b_4  if _tintra == -4;
replace b = b_3  if _tintra == -3;
replace b = b_2  if _tintra == -2;
replace b = b_1  if _tintra == -1;
replace b = b1   if _tintra == 1;
replace b = b2   if _tintra == 2;
replace b = b3   if _tintra == 3;
replace b = b4   if _tintra == 4;
replace b = b5   if _tintra == 5;
replace b = b6   if _tintra == 6;
replace b = b7   if _tintra == 7;
replace b = b8   if _tintra == 8;
replace b = b9   if _tintra == 9;
replace b = b10  if _tintra == 10;
replace b = b11  if _tintra == 11;
replace b = b12  if _tintra == 12;
replace b = b13  if _tintra == 13;
replace b = b14  if _tintra == 14;
replace b = b15  if _tintra == 15;

replace LB = b_10LB if _tintra == -10;
replace LB = b_9LB if _tintra == -9;
replace LB = b_8LB if _tintra == -8;
replace LB = b_7LB if _tintra == -7;
replace LB = b_6LB if _tintra == -6;
replace LB = b_5LB if _tintra == -5;
replace LB = b_4LB if _tintra == -4;
replace LB = b_3LB if _tintra == -3;
replace LB = b_2LB if _tintra == -2;
replace LB = b_1LB if _tintra == -1;
replace LB = b1LB  if _tintra == 1;
replace LB = b2LB  if _tintra == 2;
replace LB = b3LB  if _tintra == 3;
replace LB = b4LB  if _tintra == 4;
replace LB = b5LB  if _tintra == 5;
replace LB = b6LB  if _tintra == 6;
replace LB = b7LB  if _tintra == 7;
replace LB = b8LB  if _tintra == 8;
replace LB = b9LB  if _tintra == 9;
replace LB = b10LB  if _tintra == 10;
replace LB = b11LB  if _tintra == 11;
replace LB = b12LB  if _tintra == 12;
replace LB = b13LB  if _tintra == 13;
replace LB = b14LB  if _tintra == 14;
replace LB = b15LB  if _tintra == 15;

replace UB = b_10UB if _tintra == -10;
replace UB = b_9UB if _tintra == -9;
replace UB = b_8UB if _tintra == -8;
replace UB = b_7UB if _tintra == -7;
replace UB = b_6UB if _tintra == -6;
replace UB = b_5UB if _tintra == -5;
replace UB = b_4UB if _tintra == -4;
replace UB = b_3UB if _tintra == -3;
replace UB = b_2UB if _tintra == -2;
replace UB = b_1UB if _tintra == -1;
replace UB = b1UB  if _tintra == 1;
replace UB = b2UB  if _tintra == 2;
replace UB = b3UB  if _tintra == 3;
replace UB = b4UB  if _tintra == 4;
replace UB = b5UB  if _tintra == 5;
replace UB = b6UB  if _tintra == 6;
replace UB = b7UB  if _tintra == 7;
replace UB = b8UB  if _tintra == 8;
replace UB = b9UB  if _tintra == 9;
replace UB = b10UB if _tintra == 10;
replace UB = b11UB if _tintra == 11;
replace UB = b12UB if _tintra == 12;
replace UB = b13UB if _tintra == 13;
replace UB = b14UB if _tintra == 14;
replace UB = b15UB if _tintra == 15;

replace b=b-x;
replace LB=LB-x;
replace UB=UB-x;

keep _tintra b LB UB;
duplicates drop;

sort _tintra;

twoway (connected b _tintra, sort lcolor(navy) mcolor(navy) msymbol(circle_hollow) cmissing(n))
       (rcap LB UB _tintra, lcolor(navy) lpattern(dash) msize(medium)),
       ytitle(Percentage change) ytitle(, size(small)) 
       yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Years relative to branch deregulation) xtitle(, size(small)) 
       xline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) xlabel(-10(5)15, labsize(small)) xmtick(-10(1)15, nolabels ticks) 
       legend(off)
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure3, asis replace;
log close;








*** figure 4



#delimit;
clear;
set mem 2g;
set more off;

log using Figure4.log, replace;

muse wage_workfile.dta, s w c 

generate Y=log(_hourly_earnings_cpi);
drop if Y==.;

tab year, gen(year_dumm);
tab statefip, gen(state_dumm);

generate skilled=0;
replace  skilled=1 if educ1315==1;
replace  skilled=1 if educ16plus==1;

generate male_exp=male*exp;
generate male_exp2=male*exp2;
generate male_exp3=male*exp3;
generate male_exp4=male*exp4;

generate white_male=white*male;

generate white_exp=white*exp;
generate white_exp2=white*exp2;
generate white_exp3=white*exp3;
generate white_exp4=white*exp4;

local Xs male white exp exp2 exp3 exp4 
         male_* white_*;

#delimit cr
generate RY=.

levels year, local(time)
  foreach t of local time {
  regress Y `Xs' [pw=weight] if year==`t' & skilled==1
  quietly predict R if year==`t', residual
  quietly replace RY = R if year==`t'
  quietly drop R
  display "Finished year `t'..."
}

#delimit;
replace RY=. if Y==.;
bysort skilled: sum RY;

replace weight=0 if skilled==1;
egen weightt = sum(weight), by(year);
gen weight_new = weight / weightt;
drop weightt weight;
rename weight_new weight;

keep if skilled==0;

generate clusters = statefip*year;

drop _tintra;
generate _tintra = year - branch_reform;

replace _tintra = -10 if _tintra <-10;
replace _tintra =  15 if _tintra > 15;

tab _tintra, missing;

generate d_10 = 0; replace d_10 = 1 if _tintra == -10;
generate d_9  = 0; replace d_9  = 1 if _tintra == -9;
generate d_8  = 0; replace d_8  = 1 if _tintra == -8;
generate d_7  = 0; replace d_7  = 1 if _tintra == -7;
generate d_6  = 0; replace d_6  = 1 if _tintra == -6;
generate d_5  = 0; replace d_5  = 1 if _tintra == -5;
generate d_4  = 0; replace d_4  = 1 if _tintra == -4;
generate d_3  = 0; replace d_3  = 1 if _tintra == -3;
generate d_2  = 0; replace d_2  = 1 if _tintra == -2;
generate d_1  = 0; replace d_1  = 1 if _tintra == -1;

generate d1  = 0; replace d1  = 1 if _tintra == 1;
generate d2  = 0; replace d2  = 1 if _tintra == 2;
generate d3  = 0; replace d3  = 1 if _tintra == 3;
generate d4  = 0; replace d4  = 1 if _tintra == 4;
generate d5  = 0; replace d5  = 1 if _tintra == 5;
generate d6  = 0; replace d6  = 1 if _tintra == 6;
generate d7  = 0; replace d7  = 1 if _tintra == 7;
generate d8  = 0; replace d8  = 1 if _tintra == 8;
generate d9  = 0; replace d9  = 1 if _tintra == 9;
generate d10 = 0; replace d10 = 1 if _tintra == 10;
generate d11 = 0; replace d11 = 1 if _tintra == 11;
generate d12 = 0; replace d12 = 1 if _tintra == 12;
generate d13 = 0; replace d13 = 1 if _tintra == 13;
generate d14 = 0; replace d14 = 1 if _tintra == 14;
generate d15 = 0; replace d15 = 1 if _tintra == 15;

generate t5=1.96;

reg RY d_10-d15 year_dumm* state_dumm* [pw=weight], robust cluster(clusters);

generate b_10 = _b[d_10]; generate se_b_10 = _se[d_10];
generate b_10LB = b_10 - t5*se_b_10;
generate b_10UB = b_10 + t5*se_b_10;

generate b_9 = _b[d_9]; generate se_b_9 = _se[d_9];
generate b_9LB = b_9 - t5*se_b_9;
generate b_9UB = b_9 + t5*se_b_9;

generate b_8 = _b[d_8]; generate se_b_8 = _se[d_8];
generate b_8LB = b_8 - t5*se_b_8;
generate b_8UB = b_8 + t5*se_b_8;

generate b_7 = _b[d_7]; generate se_b_7 = _se[d_7];
generate b_7LB = b_7 - t5*se_b_7;
generate b_7UB = b_7 + t5*se_b_7;

generate b_6 = _b[d_6]; generate se_b_6 = _se[d_6];
generate b_6LB = b_6 - t5*se_b_6;
generate b_6UB = b_6 + t5*se_b_6;

generate b_5 = _b[d_5]; generate se_b_5 = _se[d_5];
generate b_5LB = b_5 - t5*se_b_5;
generate b_5UB = b_5 + t5*se_b_5;

generate b_4 = _b[d_4]; generate se_b_4 = _se[d_4];
generate b_4LB = b_4 - t5*se_b_4;
generate b_4UB = b_4 + t5*se_b_4;

generate b_3 = _b[d_3]; generate se_b_3 = _se[d_3];
generate b_3LB = b_3 - t5*se_b_3;
generate b_3UB = b_3 + t5*se_b_3;

generate b_2 = _b[d_2]; generate se_b_2 = _se[d_2];
generate b_2LB = b_2 - t5*se_b_2;
generate b_2UB = b_2 + t5*se_b_2;

generate b_1 = _b[d_1]; generate se_b_1 = _se[d_1];
generate b_1LB = b_1 - t5*se_b_1;
generate b_1UB = b_1 + t5*se_b_1;

generate b1 = _b[d1]; generate se_b1 = _se[d1];
generate b1LB = b1 - t5*se_b1;
generate b1UB = b1 + t5*se_b1;

generate b2 = _b[d2]; generate se_b2 = _se[d2];
generate b2LB = b2 - t5*se_b2;
generate b2UB = b2 + t5*se_b2;

generate b3 = _b[d3]; generate se_b3 = _se[d3];
generate b3LB = b3 - t5*se_b3;
generate b3UB = b3 + t5*se_b3;

generate b4 = _b[d4]; generate se_b4 = _se[d4];
generate b4LB = b4 - t5*se_b4;
generate b4UB = b4 + t5*se_b4;

generate b5 = _b[d5]; generate se_b5 = _se[d5];
generate b5LB = b5 - t5*se_b5;
generate b5UB = b5 + t5*se_b5;

generate b6 = _b[d6]; generate se_b6 = _se[d6];
generate b6LB = b6 - t5*se_b6;
generate b6UB = b6 + t5*se_b6;

generate b7 = _b[d7]; generate se_b7 = _se[d7];
generate b7LB = b7 - t5*se_b7;
generate b7UB = b7 + t5*se_b7;

generate b8 = _b[d8]; generate se_b8 = _se[d8];
generate b8LB = b8 - t5*se_b8;
generate b8UB = b8 + t5*se_b8;

generate b9 = _b[d9]; generate se_b9 = _se[d9];
generate b9LB = b9 - t5*se_b9;
generate b9UB = b9 + t5*se_b9;

generate b10 = _b[d10]; generate se_b10 = _se[d10];
generate b10LB = b10 - t5*se_b10;
generate b10UB = b10 + t5*se_b10;

generate b11 = _b[d11]; generate se_b11 = _se[d11];
generate b11LB = b11 - t5*se_b11;
generate b11UB = b11 + t5*se_b11;

generate b12 = _b[d12]; generate se_b12 = _se[d12];
generate b12LB = b12 - t5*se_b12;
generate b12UB = b12 + t5*se_b12;

generate b13 = _b[d13]; generate se_b13 = _se[d13];
generate b13LB = b13 - t5*se_b13;
generate b13UB = b13 + t5*se_b13;

generate b14 = _b[d14]; generate se_b14 = _se[d14];
generate b14LB = b14 - t5*se_b14;
generate b14UB = b14 + t5*se_b14;

generate b15 = _b[d15]; generate se_b15 = _se[d15];
generate b15LB = b15 - t5*se_b15;
generate b15UB = b15 + t5*se_b15;

generate trend=(b_1-b_10)/9;

generate b = .;
generate LB = .;
generate UB = .;

replace b = b_10  if _tintra == -10;
replace b = b_9  if _tintra == -9;
replace b = b_8  if _tintra == -8;
replace b = b_7  if _tintra == -7;
replace b = b_6  if _tintra == -6;
replace b = b_5  if _tintra == -5;
replace b = b_4  if _tintra == -4;
replace b = b_3  if _tintra == -3;
replace b = b_2  if _tintra == -2;
replace b = b_1  if _tintra == -1;
replace b = b1   if _tintra == 1;
replace b = b2   if _tintra == 2;
replace b = b3   if _tintra == 3;
replace b = b4   if _tintra == 4;
replace b = b5   if _tintra == 5;
replace b = b6   if _tintra == 6;
replace b = b7   if _tintra == 7;
replace b = b8   if _tintra == 8;
replace b = b9   if _tintra == 9;
replace b = b10  if _tintra == 10;
replace b = b11  if _tintra == 11;
replace b = b12  if _tintra == 12;
replace b = b13  if _tintra == 13;
replace b = b14  if _tintra == 14;
replace b = b15  if _tintra == 15;

replace LB = b_10LB if _tintra == -10;
replace LB = b_9LB if _tintra == -9;
replace LB = b_8LB if _tintra == -8;
replace LB = b_7LB if _tintra == -7;
replace LB = b_6LB if _tintra == -6;
replace LB = b_5LB if _tintra == -5;
replace LB = b_4LB if _tintra == -4;
replace LB = b_3LB if _tintra == -3;
replace LB = b_2LB if _tintra == -2;
replace LB = b_1LB if _tintra == -1;
replace LB = b1LB  if _tintra == 1;
replace LB = b2LB  if _tintra == 2;
replace LB = b3LB  if _tintra == 3;
replace LB = b4LB  if _tintra == 4;
replace LB = b5LB  if _tintra == 5;
replace LB = b6LB  if _tintra == 6;
replace LB = b7LB  if _tintra == 7;
replace LB = b8LB  if _tintra == 8;
replace LB = b9LB  if _tintra == 9;
replace LB = b10LB  if _tintra == 10;
replace LB = b11LB  if _tintra == 11;
replace LB = b12LB  if _tintra == 12;
replace LB = b13LB  if _tintra == 13;
replace LB = b14LB  if _tintra == 14;
replace LB = b15LB  if _tintra == 15;

replace UB = b_10UB if _tintra == -10;
replace UB = b_9UB if _tintra == -9;
replace UB = b_8UB if _tintra == -8;
replace UB = b_7UB if _tintra == -7;
replace UB = b_6UB if _tintra == -6;
replace UB = b_5UB if _tintra == -5;
replace UB = b_4UB if _tintra == -4;
replace UB = b_3UB if _tintra == -3;
replace UB = b_2UB if _tintra == -2;
replace UB = b_1UB if _tintra == -1;
replace UB = b1UB  if _tintra == 1;
replace UB = b2UB  if _tintra == 2;
replace UB = b3UB  if _tintra == 3;
replace UB = b4UB  if _tintra == 4;
replace UB = b5UB  if _tintra == 5;
replace UB = b6UB  if _tintra == 6;
replace UB = b7UB  if _tintra == 7;
replace UB = b8UB  if _tintra == 8;
replace UB = b9UB  if _tintra == 9;
replace UB = b10UB if _tintra == 10;
replace UB = b11UB if _tintra == 11;
replace UB = b12UB if _tintra == 12;
replace UB = b13UB if _tintra == 13;
replace UB = b14UB if _tintra == 14;
replace UB = b15UB if _tintra == 15;

replace b=b+trend*(-_tintra) if _tintra<0;
replace b=b-trend*_tintra    if _tintra>0;

replace LB=LB+trend*(-_tintra) if _tintra<0;
replace LB=LB-trend*_tintra    if _tintra>0;

replace UB=UB+trend*(-_tintra) if _tintra<0;
replace UB=UB-trend*_tintra    if _tintra>0;

keep _tintra b LB UB;
duplicates drop;
sort _tintra;

egen x1=mean(b) if _tintra<0;
egen x2=mean(x1);
replace b=b-x2;
replace LB=LB-x2;
replace UB=UB-x2;
drop x1 x2;


twoway (connected b _tintra, sort lcolor(navy) mcolor(navy) msymbol(circle_hollow) cmissing(n))
       (rcap UB LB _tintra, lcolor(navy) lpattern(dash) msize(medium)),
       ytitle(Percentage change in relative real wages) ytitle(, size(small)) 
       yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(-0.06(0.03)0.12, labsize(small) angle(horizontal) nogrid) 
       xtitle(Years relative to branch deregulation) xtitle(, size(small)) 
       xline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) xlabel(-10(5)15, labsize(small)) xmtick(-10(1)15, nolabels ticks) 
       legend(off)
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure4, asis replace;


log close;













*** figure 5

#delimit;
clear;
set mem 2g;
set more off;

log using Figure5.log, replace;

muse wage_workfile.dta, s w c 

generate Y=_hours;
drop if Y==.;

tab year, gen(year_dumm);
tab statefip, gen(state_dumm);

generate skilled=0;
replace  skilled=1 if educ1315==1;
replace  skilled=1 if educ16plus==1;

generate male_exp=male*exp;
generate male_exp2=male*exp2;
generate male_exp3=male*exp3;
generate male_exp4=male*exp4;

generate white_male=white*male;

generate white_exp=white*exp;
generate white_exp2=white*exp2;
generate white_exp3=white*exp3;
generate white_exp4=white*exp4;

local Xs male white exp exp2 exp3 exp4 
         male_* white_*;

#delimit cr
generate RY=.

levels year, local(time)
  foreach t of local time {
  regress Y `Xs' [pw=weight] if year==`t' & skilled==1
  quietly predict R if year==`t', residual
  quietly replace RY = R if year==`t'
  quietly drop R
  display "Finished year `t'..."
}

#delimit;
replace RY=. if Y==.;
bysort skilled: sum RY;

replace weight=0 if skilled==1;
egen weightt = sum(weight), by(year);
gen weight_new = weight / weightt;
drop weightt weight;
rename weight_new weight;

keep if skilled==0;

generate clusters = statefip*year;

drop _tintra;
generate _tintra = year - branch_reform;

replace _tintra = -10 if _tintra <-10;
replace _tintra =  15 if _tintra > 15;

tab _tintra, missing;

generate d_10 = 0; replace d_10 = 1 if _tintra == -10;
generate d_9  = 0; replace d_9  = 1 if _tintra == -9;
generate d_8  = 0; replace d_8  = 1 if _tintra == -8;
generate d_7  = 0; replace d_7  = 1 if _tintra == -7;
generate d_6  = 0; replace d_6  = 1 if _tintra == -6;
generate d_5  = 0; replace d_5  = 1 if _tintra == -5;
generate d_4  = 0; replace d_4  = 1 if _tintra == -4;
generate d_3  = 0; replace d_3  = 1 if _tintra == -3;
generate d_2  = 0; replace d_2  = 1 if _tintra == -2;
generate d_1  = 0; replace d_1  = 1 if _tintra == -1;

generate d1  = 0; replace d1  = 1 if _tintra == 1;
generate d2  = 0; replace d2  = 1 if _tintra == 2;
generate d3  = 0; replace d3  = 1 if _tintra == 3;
generate d4  = 0; replace d4  = 1 if _tintra == 4;
generate d5  = 0; replace d5  = 1 if _tintra == 5;
generate d6  = 0; replace d6  = 1 if _tintra == 6;
generate d7  = 0; replace d7  = 1 if _tintra == 7;
generate d8  = 0; replace d8  = 1 if _tintra == 8;
generate d9  = 0; replace d9  = 1 if _tintra == 9;
generate d10 = 0; replace d10 = 1 if _tintra == 10;
generate d11 = 0; replace d11 = 1 if _tintra == 11;
generate d12 = 0; replace d12 = 1 if _tintra == 12;
generate d13 = 0; replace d13 = 1 if _tintra == 13;
generate d14 = 0; replace d14 = 1 if _tintra == 14;
generate d15 = 0; replace d15 = 1 if _tintra == 15;

generate t5=1.96;

reg RY d_10-d15 year_dumm* state_dumm* [pw=weight], robust cluster(clusters);

generate b_10 = _b[d_10]; generate se_b_10 = _se[d_10];
generate b_10LB = b_10 - t5*se_b_10;
generate b_10UB = b_10 + t5*se_b_10;

generate b_9 = _b[d_9]; generate se_b_9 = _se[d_9];
generate b_9LB = b_9 - t5*se_b_9;
generate b_9UB = b_9 + t5*se_b_9;

generate b_8 = _b[d_8]; generate se_b_8 = _se[d_8];
generate b_8LB = b_8 - t5*se_b_8;
generate b_8UB = b_8 + t5*se_b_8;

generate b_7 = _b[d_7]; generate se_b_7 = _se[d_7];
generate b_7LB = b_7 - t5*se_b_7;
generate b_7UB = b_7 + t5*se_b_7;

generate b_6 = _b[d_6]; generate se_b_6 = _se[d_6];
generate b_6LB = b_6 - t5*se_b_6;
generate b_6UB = b_6 + t5*se_b_6;

generate b_5 = _b[d_5]; generate se_b_5 = _se[d_5];
generate b_5LB = b_5 - t5*se_b_5;
generate b_5UB = b_5 + t5*se_b_5;

generate b_4 = _b[d_4]; generate se_b_4 = _se[d_4];
generate b_4LB = b_4 - t5*se_b_4;
generate b_4UB = b_4 + t5*se_b_4;

generate b_3 = _b[d_3]; generate se_b_3 = _se[d_3];
generate b_3LB = b_3 - t5*se_b_3;
generate b_3UB = b_3 + t5*se_b_3;

generate b_2 = _b[d_2]; generate se_b_2 = _se[d_2];
generate b_2LB = b_2 - t5*se_b_2;
generate b_2UB = b_2 + t5*se_b_2;

generate b_1 = _b[d_1]; generate se_b_1 = _se[d_1];
generate b_1LB = b_1 - t5*se_b_1;
generate b_1UB = b_1 + t5*se_b_1;

generate b1 = _b[d1]; generate se_b1 = _se[d1];
generate b1LB = b1 - t5*se_b1;
generate b1UB = b1 + t5*se_b1;

generate b2 = _b[d2]; generate se_b2 = _se[d2];
generate b2LB = b2 - t5*se_b2;
generate b2UB = b2 + t5*se_b2;

generate b3 = _b[d3]; generate se_b3 = _se[d3];
generate b3LB = b3 - t5*se_b3;
generate b3UB = b3 + t5*se_b3;

generate b4 = _b[d4]; generate se_b4 = _se[d4];
generate b4LB = b4 - t5*se_b4;
generate b4UB = b4 + t5*se_b4;

generate b5 = _b[d5]; generate se_b5 = _se[d5];
generate b5LB = b5 - t5*se_b5;
generate b5UB = b5 + t5*se_b5;

generate b6 = _b[d6]; generate se_b6 = _se[d6];
generate b6LB = b6 - t5*se_b6;
generate b6UB = b6 + t5*se_b6;

generate b7 = _b[d7]; generate se_b7 = _se[d7];
generate b7LB = b7 - t5*se_b7;
generate b7UB = b7 + t5*se_b7;

generate b8 = _b[d8]; generate se_b8 = _se[d8];
generate b8LB = b8 - t5*se_b8;
generate b8UB = b8 + t5*se_b8;

generate b9 = _b[d9]; generate se_b9 = _se[d9];
generate b9LB = b9 - t5*se_b9;
generate b9UB = b9 + t5*se_b9;

generate b10 = _b[d10]; generate se_b10 = _se[d10];
generate b10LB = b10 - t5*se_b10;
generate b10UB = b10 + t5*se_b10;

generate b11 = _b[d11]; generate se_b11 = _se[d11];
generate b11LB = b11 - t5*se_b11;
generate b11UB = b11 + t5*se_b11;

generate b12 = _b[d12]; generate se_b12 = _se[d12];
generate b12LB = b12 - t5*se_b12;
generate b12UB = b12 + t5*se_b12;

generate b13 = _b[d13]; generate se_b13 = _se[d13];
generate b13LB = b13 - t5*se_b13;
generate b13UB = b13 + t5*se_b13;

generate b14 = _b[d14]; generate se_b14 = _se[d14];
generate b14LB = b14 - t5*se_b14;
generate b14UB = b14 + t5*se_b14;

generate b15 = _b[d15]; generate se_b15 = _se[d15];
generate b15LB = b15 - t5*se_b15;
generate b15UB = b15 + t5*se_b15;

generate trend=(b_1-b_10)/9;

generate b = .;
generate LB = .;
generate UB = .;

replace b = b_10  if _tintra == -10;
replace b = b_9  if _tintra == -9;
replace b = b_8  if _tintra == -8;
replace b = b_7  if _tintra == -7;
replace b = b_6  if _tintra == -6;
replace b = b_5  if _tintra == -5;
replace b = b_4  if _tintra == -4;
replace b = b_3  if _tintra == -3;
replace b = b_2  if _tintra == -2;
replace b = b_1  if _tintra == -1;
replace b = b1   if _tintra == 1;
replace b = b2   if _tintra == 2;
replace b = b3   if _tintra == 3;
replace b = b4   if _tintra == 4;
replace b = b5   if _tintra == 5;
replace b = b6   if _tintra == 6;
replace b = b7   if _tintra == 7;
replace b = b8   if _tintra == 8;
replace b = b9   if _tintra == 9;
replace b = b10  if _tintra == 10;
replace b = b11  if _tintra == 11;
replace b = b12  if _tintra == 12;
replace b = b13  if _tintra == 13;
replace b = b14  if _tintra == 14;
replace b = b15  if _tintra == 15;

replace LB = b_10LB if _tintra == -10;
replace LB = b_9LB if _tintra == -9;
replace LB = b_8LB if _tintra == -8;
replace LB = b_7LB if _tintra == -7;
replace LB = b_6LB if _tintra == -6;
replace LB = b_5LB if _tintra == -5;
replace LB = b_4LB if _tintra == -4;
replace LB = b_3LB if _tintra == -3;
replace LB = b_2LB if _tintra == -2;
replace LB = b_1LB if _tintra == -1;
replace LB = b1LB  if _tintra == 1;
replace LB = b2LB  if _tintra == 2;
replace LB = b3LB  if _tintra == 3;
replace LB = b4LB  if _tintra == 4;
replace LB = b5LB  if _tintra == 5;
replace LB = b6LB  if _tintra == 6;
replace LB = b7LB  if _tintra == 7;
replace LB = b8LB  if _tintra == 8;
replace LB = b9LB  if _tintra == 9;
replace LB = b10LB  if _tintra == 10;
replace LB = b11LB  if _tintra == 11;
replace LB = b12LB  if _tintra == 12;
replace LB = b13LB  if _tintra == 13;
replace LB = b14LB  if _tintra == 14;
replace LB = b15LB  if _tintra == 15;

replace UB = b_10UB if _tintra == -10;
replace UB = b_9UB if _tintra == -9;
replace UB = b_8UB if _tintra == -8;
replace UB = b_7UB if _tintra == -7;
replace UB = b_6UB if _tintra == -6;
replace UB = b_5UB if _tintra == -5;
replace UB = b_4UB if _tintra == -4;
replace UB = b_3UB if _tintra == -3;
replace UB = b_2UB if _tintra == -2;
replace UB = b_1UB if _tintra == -1;
replace UB = b1UB  if _tintra == 1;
replace UB = b2UB  if _tintra == 2;
replace UB = b3UB  if _tintra == 3;
replace UB = b4UB  if _tintra == 4;
replace UB = b5UB  if _tintra == 5;
replace UB = b6UB  if _tintra == 6;
replace UB = b7UB  if _tintra == 7;
replace UB = b8UB  if _tintra == 8;
replace UB = b9UB  if _tintra == 9;
replace UB = b10UB if _tintra == 10;
replace UB = b11UB if _tintra == 11;
replace UB = b12UB if _tintra == 12;
replace UB = b13UB if _tintra == 13;
replace UB = b14UB if _tintra == 14;
replace UB = b15UB if _tintra == 15;

replace b=b+trend*(-_tintra) if _tintra<0;
replace b=b-trend*_tintra    if _tintra>0;

replace LB=LB+trend*(-_tintra) if _tintra<0;
replace LB=LB-trend*_tintra    if _tintra>0;

replace UB=UB+trend*(-_tintra) if _tintra<0;
replace UB=UB-trend*_tintra    if _tintra>0;

keep _tintra b LB UB;
duplicates drop;
sort _tintra;

egen x1=mean(b) if _tintra<0;
egen x2=mean(x1);
replace b=b-x2;
replace LB=LB-x2;
replace UB=UB-x2;
drop x1 x2;


twoway (connected b _tintra, sort lcolor(navy) mcolor(navy) msymbol(circle_hollow) cmissing(n))
       (rcap UB LB _tintra, lcolor(navy) lpattern(dash) msize(medium)),
       ytitle(Change in relative weekly working hours) ytitle(, size(small)) 
       yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(-1.5(0.5)2, labsize(small) angle(horizontal) nogrid) 
       xtitle(Years relative to branch deregulation) xtitle(, size(small)) 
       xline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) xlabel(-10(5)15, labsize(small)) xmtick(-10(1)15, nolabels ticks) 
       legend(off)
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure5, asis replace;


log close;






*** figure 6

#delimit;
clear;
set more off;
set memory 100m;



log using Figure6.log, replace;

muse macro_workfile.dta, s w c

generate _tintra = wrkyr - branch_reform;
replace  _tintra = -10 if _tintra <-10;
replace  _tintra =  15 if _tintra > 15;

tab _tintra, missing;

generate d_10 = 0; replace d_10 = 1 if _tintra == -10;
generate d_9  = 0; replace d_9  = 1 if _tintra == -9;
generate d_8  = 0; replace d_8  = 1 if _tintra == -8;
generate d_7  = 0; replace d_7  = 1 if _tintra == -7;
generate d_6  = 0; replace d_6  = 1 if _tintra == -6;
generate d_5  = 0; replace d_5  = 1 if _tintra == -5;
generate d_4  = 0; replace d_4  = 1 if _tintra == -4;
generate d_3  = 0; replace d_3  = 1 if _tintra == -3;
generate d_2  = 0; replace d_2  = 1 if _tintra == -2;
generate d_1  = 0; replace d_1  = 1 if _tintra == -1;

generate d1  = 0; replace d1  = 1 if _tintra == 1;
generate d2  = 0; replace d2  = 1 if _tintra == 2;
generate d3  = 0; replace d3  = 1 if _tintra == 3;
generate d4  = 0; replace d4  = 1 if _tintra == 4;
generate d5  = 0; replace d5  = 1 if _tintra == 5;
generate d6  = 0; replace d6  = 1 if _tintra == 6;
generate d7  = 0; replace d7  = 1 if _tintra == 7;
generate d8  = 0; replace d8  = 1 if _tintra == 8;
generate d9  = 0; replace d9  = 1 if _tintra == 9;
generate d10 = 0; replace d10 = 1 if _tintra == 10;
generate d11 = 0; replace d11 = 1 if _tintra == 11;
generate d12 = 0; replace d12 = 1 if _tintra == 12;
generate d13 = 0; replace d13 = 1 if _tintra == 13;
generate d14 = 0; replace d14 = 1 if _tintra == 14;
generate d15 = 0; replace d15 = 1 if _tintra == 15;

generate t5 = invttail(48,0.025);

tabulate wrkyr, gen(wrkyr_dumm);

replace unemploymentrate=unemploymentrate/100;

xtreg unemploymentrate d_10-d15 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

generate b_10 = _b[d_10]; generate se_b_10 = _se[d_10];
generate b_10LB = b_10 - t5*se_b_10;
generate b_10UB = b_10 + t5*se_b_10;

generate b_9 = _b[d_9]; generate se_b_9 = _se[d_9];
generate b_9LB = b_9 - t5*se_b_9;
generate b_9UB = b_9 + t5*se_b_9;

generate b_8 = _b[d_8]; generate se_b_8 = _se[d_8];
generate b_8LB = b_8 - t5*se_b_8;
generate b_8UB = b_8 + t5*se_b_8;

generate b_7 = _b[d_7]; generate se_b_7 = _se[d_7];
generate b_7LB = b_7 - t5*se_b_7;
generate b_7UB = b_7 + t5*se_b_7;

generate b_6 = _b[d_6]; generate se_b_6 = _se[d_6];
generate b_6LB = b_6 - t5*se_b_6;
generate b_6UB = b_6 + t5*se_b_6;

generate b_5 = _b[d_5]; generate se_b_5 = _se[d_5];
generate b_5LB = b_5 - t5*se_b_5;
generate b_5UB = b_5 + t5*se_b_5;

generate b_4 = _b[d_4]; generate se_b_4 = _se[d_4];
generate b_4LB = b_4 - t5*se_b_4;
generate b_4UB = b_4 + t5*se_b_4;

generate b_3 = _b[d_3]; generate se_b_3 = _se[d_3];
generate b_3LB = b_3 - t5*se_b_3;
generate b_3UB = b_3 + t5*se_b_3;

generate b_2 = _b[d_2]; generate se_b_2 = _se[d_2];
generate b_2LB = b_2 - t5*se_b_2;
generate b_2UB = b_2 + t5*se_b_2;

generate b_1 = _b[d_1]; generate se_b_1 = _se[d_1];
generate b_1LB = b_1 - t5*se_b_1;
generate b_1UB = b_1 + t5*se_b_1;

generate b1 = _b[d1]; generate se_b1 = _se[d1];
generate b1LB = b1 - t5*se_b1;

generate b1UB = b1 + t5*se_b1;

generate b2 = _b[d2]; generate se_b2 = _se[d2];
generate b2LB = b2 - t5*se_b2;
generate b2UB = b2 + t5*se_b2;

generate b3 = _b[d3]; generate se_b3 = _se[d3];
generate b3LB = b3 - t5*se_b3;
generate b3UB = b3 + t5*se_b3;

generate b4 = _b[d4]; generate se_b4 = _se[d4];
generate b4LB = b4 - t5*se_b4;
generate b4UB = b4 + t5*se_b4;

generate b5 = _b[d5]; generate se_b5 = _se[d5];
generate b5LB = b5 - t5*se_b5;
generate b5UB = b5 + t5*se_b5;

generate b6 = _b[d6]; generate se_b6 = _se[d6];
generate b6LB = b6 - t5*se_b6;
generate b6UB = b6 + t5*se_b6;

generate b7 = _b[d7]; generate se_b7 = _se[d7];
generate b7LB = b7 - t5*se_b7;
generate b7UB = b7 + t5*se_b7;

generate b8 = _b[d8]; generate se_b8 = _se[d8];
generate b8LB = b8 - t5*se_b8;
generate b8UB = b8 + t5*se_b8;

generate b9 = _b[d9]; generate se_b9 = _se[d9];
generate b9LB = b9 - t5*se_b9;
generate b9UB = b9 + t5*se_b9;

generate b10 = _b[d10]; generate se_b10 = _se[d10];
generate b10LB = b10 - t5*se_b10;
generate b10UB = b10 + t5*se_b10;

generate b11 = _b[d11]; generate se_b11 = _se[d11];
generate b11LB = b11 - t5*se_b11;
generate b11UB = b11 + t5*se_b11;

generate b12 = _b[d12]; generate se_b12 = _se[d12];
generate b12LB = b12 - t5*se_b12;
generate b12UB = b12 + t5*se_b12;

generate b13 = _b[d13]; generate se_b13 = _se[d13];
generate b13LB = b13 - t5*se_b13;
generate b13UB = b13 + t5*se_b13;

generate b14 = _b[d14]; generate se_b14 = _se[d14];
generate b14LB = b14 - t5*se_b14;
generate b14UB = b14 + t5*se_b14;

generate b15 = _b[d15]; generate se_b15 = _se[d15];
generate b15LB = b15 - t5*se_b15;
generate b15UB = b15 + t5*se_b15;

generate x=(b_10+b_9+b_8+b_7+b_6+b_5+b_4+b_3+b_2+b_1)/10;

generate b = .;
generate LB = .;
generate UB = .;

replace b = b_10  if _tintra == -10;
replace b = b_9  if _tintra == -9;
replace b = b_8  if _tintra == -8;
replace b = b_7  if _tintra == -7;
replace b = b_6  if _tintra == -6;
replace b = b_5  if _tintra == -5;
replace b = b_4  if _tintra == -4;
replace b = b_3  if _tintra == -3;
replace b = b_2  if _tintra == -2;
replace b = b_1  if _tintra == -1;
replace b = b1   if _tintra == 1;
replace b = b2   if _tintra == 2;
replace b = b3   if _tintra == 3;
replace b = b4   if _tintra == 4;
replace b = b5   if _tintra == 5;
replace b = b6   if _tintra == 6;
replace b = b7   if _tintra == 7;
replace b = b8   if _tintra == 8;
replace b = b9   if _tintra == 9;
replace b = b10  if _tintra == 10;
replace b = b11  if _tintra == 11;
replace b = b12  if _tintra == 12;
replace b = b13  if _tintra == 13;
replace b = b14  if _tintra == 14;
replace b = b15  if _tintra == 15;

replace LB = b_10LB if _tintra == -10;
replace LB = b_9LB if _tintra == -9;
replace LB = b_8LB if _tintra == -8;
replace LB = b_7LB if _tintra == -7;
replace LB = b_6LB if _tintra == -6;
replace LB = b_5LB if _tintra == -5;
replace LB = b_4LB if _tintra == -4;
replace LB = b_3LB if _tintra == -3;
replace LB = b_2LB if _tintra == -2;
replace LB = b_1LB if _tintra == -1;
replace LB = b1LB  if _tintra == 1;
replace LB = b2LB  if _tintra == 2;
replace LB = b3LB  if _tintra == 3;
replace LB = b4LB  if _tintra == 4;
replace LB = b5LB  if _tintra == 5;
replace LB = b6LB  if _tintra == 6;
replace LB = b7LB  if _tintra == 7;
replace LB = b8LB  if _tintra == 8;
replace LB = b9LB  if _tintra == 9;
replace LB = b10LB  if _tintra == 10;
replace LB = b11LB  if _tintra == 11;
replace LB = b12LB  if _tintra == 12;
replace LB = b13LB  if _tintra == 13;
replace LB = b14LB  if _tintra == 14;
replace LB = b15LB  if _tintra == 15;

replace UB = b_10UB if _tintra == -10;
replace UB = b_9UB if _tintra == -9;
replace UB = b_8UB if _tintra == -8;
replace UB = b_7UB if _tintra == -7;
replace UB = b_6UB if _tintra == -6;
replace UB = b_5UB if _tintra == -5;
replace UB = b_4UB if _tintra == -4;
replace UB = b_3UB if _tintra == -3;
replace UB = b_2UB if _tintra == -2;
replace UB = b_1UB if _tintra == -1;
replace UB = b1UB  if _tintra == 1;
replace UB = b2UB  if _tintra == 2;
replace UB = b3UB  if _tintra == 3;
replace UB = b4UB  if _tintra == 4;
replace UB = b5UB  if _tintra == 5;
replace UB = b6UB  if _tintra == 6;
replace UB = b7UB  if _tintra == 7;
replace UB = b8UB  if _tintra == 8;
replace UB = b9UB  if _tintra == 9;
replace UB = b10UB if _tintra == 10;
replace UB = b11UB if _tintra == 11;
replace UB = b12UB if _tintra == 12;
replace UB = b13UB if _tintra == 13;
replace UB = b14UB if _tintra == 14;
replace UB = b15UB if _tintra == 15;

gen trend=(b_10-b_1)/9;

keep _tintra b LB UB trend;
duplicates drop;

replace b=b-trend*(-_tintra)   if _tintra<0;
replace LB=LB-trend*(-_tintra) if _tintra<0;
replace UB=UB-trend*(-_tintra) if _tintra<0;

replace b=b+trend*_tintra   if _tintra>0;
replace LB=LB+trend*_tintra if _tintra>0;
replace UB=UB+trend*_tintra if _tintra>0;

sort _tintra;


twoway (connected b  _tintra, sort lcolor(navy) mcolor(navy) msymbol(circle_hollow) cmissing(n))
       (rcap LB UB _tintra, lcolor(navy) lpattern(dash) msize(medium)),
       ytitle(Percentage change) ytitle(, size(small)) 
       yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Years relative to branch deregulation) xtitle(, size(small)) 
       xline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) xlabel(-10(5)15, labsize(small)) xmtick(-10(1)15, nolabels ticks) 
       legend(off)
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure6, asis replace;
       
log close;


