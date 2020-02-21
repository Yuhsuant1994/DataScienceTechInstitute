/*Part 1
exercise 1:*/
libname data 'C:\Users\VM\Desktop\sas share\SAS ETS Evaluation_cours - Data-20181025_part2';
proc sgplot data=data.e1;
series x=date y=y;
run;

proc arima data=data.e1;
identify var=y;
estimate q=2;
run;

/*exercise 2:*/
proc sgplot data=data.e2;
series x=date y=y;
run;

proc arima data=data.e2;
identify var=y esacf p=(0:12) q=(0:12);
run;
proc arima data=data.e2;
identify var=y minic p=(0:12) q=(0:12);
run;
proc arima data=data.e2;
identify var=y scan p=(0:12) q=(0:12);
run;

proc arima data=data.e2;
identify var=y;
estimate q=(1,2,4) ml;
estimate p=3 ml;
estimate p=2 q=1 ml;
estimate q=3 ml;
run;

/*exercise 3:*/
proc sgplot data=data.e3;
series x=date y=PercentUnemployed;
run;

proc arima data=data.e3;
identify var=PercentUnemployed;
run;

proc arima data=data.e3;
identify var=PercentUnemployed esacf p=(0:12) q=(0:12);
run;
proc arima data=data.e3;
identify var=PercentUnemployed minic p=(0:12) q=(0:12);
run;
proc arima data=data.e3;
identify var=PercentUnemployed scan p=(0:12) q=(0:12);
run;

proc arima data=data.e3;
identify var=PercentUnemployed;
estimate p=1 ml;
/*estimate p=4 ml;
estimate p=5 ml;*/
estimate q=2 ml;
run;

/*excercise 4:*/
proc sgplot data=data.e4;
series x=date y=Biscuits;
run;

proc esm data=data.e4 outstat=double lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=double;
run;
proc esm data=data.e4 outstat=simple lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=simple;
run;
proc esm data=data.e4 outstat=adds lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=addseasonal;
run;
proc esm data=data.e4 outstat=e4_esm_ms lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=multseasonal;
run;
proc esm data=data.e4 outstat=addhw lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=addwinters;
run;
proc esm data=data.e4 outstat=hw lead=12 plot=forecasts;
id date interval=week;
forecast Biscuits / model=winters;
run;

/*Part 2:*/
data product;
	infile 'C:\Users\VM\Desktop\sas share\SAS ETS Evaluation_cours - Data-20181025_part2\DSTI_SAS_ETS_Evaluation_Part2.csv'
	firstobs=2 dlm=";" dsd;
	informat Date monyy7.;
	format Date monyy7.;
	input Product_Reference $ Date $ Sales_Quantity;
run;

data product1;
set product (where=(Product_Reference='FR001'));
run;
data product2;
set product (where=(Product_Reference='ESA154'));
run;
data product3;
set product (where=(Product_Reference='WW01AA'));
run;
data product31;
input Date monyy7.  Product_Reference $ Sales_Quantity;
format Date monyy7.;
cards;
JAN2016 WW01AA 8.5
JUL2016 WW01AA 101
SEP2016 WW01AA 456
;
proc append base=product3 data=product31;
run;
proc sort data=product3;
     by Date ;run;


title 'FR001';
proc sgplot data=product1;
series x=date y=Sales_Quantity;
run;
title 'ESA154';
proc sgplot data=product2;
series x=date y=Sales_Quantity;
run;
title 'WW01AA';
proc sgplot data=product3;
series x=date y=Sales_Quantity;
run;
title;


/*FR001
Check trend and seasonality*/
proc timeseries data=product1
out=product1_out
outdecomp=p1_decomp
plot=(decomp tc sc)
seasonality=12;
id Date interval=month;
var Sales_Quantity;
decomp tcc sc; 
run;

/*first check if differencing is needed*/
proc arima data=product1;
identify var=Sales_Quantity;
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;
/*stochastic*/
proc arima data=product1;
identify var=Sales_Quantity stationarity=(adf=(0 1 2 3 12));
run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(3 12);run;
/*we should differenciate by 12 since there seems to be sation*/
proc arima data=product1 plots=all;
identify var=Sales_Quantity(1 12);
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(12);
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(3 12);
estimate q=1;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

proc arima data=product1 plots=all;
identify var=Sales_Quantity(3) scan p=(0:12) q=(0:12);run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(3) minic p=(0:12) q=(0:12);run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(3) esacf p=(0:12) q=(0:12);run;
proc arima data=product1 plots=all;
identify var=Sales_Quantity(3);
/*estimate p=4 q=1 ml;*/
estimate p=(1 3 4) ml;
/*estimate q=2 ml;
estimate p=2 q=3 ml;
estimate p=1 q=4 ml; 
estimate q=(12) ml;
estimate p=(12) q=3 ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;*/
forecast lead=16 id=date interval=month;
run;
/*deterministic*/
data product11;
set product1;
array seas(*)MON1-MON11;
retain MON1-MON11 .;
if (MON1=.) then do index= 1 to 11;
	seas[index]=0;
end;
if (month(date) lt 12) then do;
	seas[month(date)]=1;
	output;
	seas[month(date)]=0;
end;	
else output;
drop index;
run;
proc arima data=product11 plots=all;
identify var=Sales_Quantity cross=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11);
estimate input=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11)method=ml;
run;


data product1;
set product1 (where=(Date gt '01OCT2015'd));
run;
/*try esm models*/
title 'double';
proc esm data=product1 outstat=a_double lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=double;
run;
title 'simple';
proc esm data=product1 outstat=a_simple lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=simple;
run;
title 'addseasonal';
proc esm data=product1 outstat=a_adds lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addseasonal;
run;
title 'multseasonal';
proc esm data=product1 outstat=a_ms lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=multseasonal;
run;
title 'addwinters';
proc esm data=product1 outstat=a_addhw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addwinters;
run;
title 'winters';
proc esm data=product1 outstat=a_hw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=winters;
run;


/*ESA154
Check trend and seasonality*/
proc timeseries data=product2
out=product2_out
outdecomp=p2_decomp
plot=(decomp tc sc)
seasonality=12;
id Date interval=month;
var Sales_Quantity;
decomp tcc sc; 
run;

proc arima data=product2;
identify var=Sales_Quantity;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
estimate;run;


proc arima data=product2;
identify var=Sales_Quantity stationarity=(adf=(0 1 2 3 6 12));
run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity(12);
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity(12);
estimate p=2  ml;
estimate p=2 q=1 ml;
estimate p=2 q=(12) ml;
estimate p=1 q=2 ml;
estimate p=2 q=2 ml;
estimate p=1 q=(2) ml;
estimate q=1 ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity(12);run;
estimate p=1 q=(2);
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=1 ml;
/*estimate p=2 ml;
estimate p=2 q=(12) ml;
estimate p=1 q=2 ml;
estimate p=2 q=2 ml;
estimate p=1 q=(2) ml;/
estimate q=2 ml;*/
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity(3)scan p=(0:12) q=(0:12); 
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
proc arima data=product2 plots=all;
identify var=Sales_Quantity(3)ESACF p=(0:12) q=(0:12); 
outlier (ao ls) maxnum=3 id=date;
estimate;run;
proc arima data=product2 plots=all;
identify var=Sales_Quantity(3)minic p=(0:12) q=(0:12); 
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
estimate;run;
proc arima data=product2 plots=all;
identify var=Sales_Quantity scan p=(0:12) q=(0:12); run;
proc arima data=product2 plots=all;
identify var=Sales_Quantity ESACF p=(0:12) q=(0:12); run;
proc arima data=product2 plots=all;
identify var=Sales_Quantity minic p=(0:12) q=(0:12); run;

proc arima data=product2 plots=all;
identify var=Sales_Quantity;
estimate;
/*estimate p=1 q=1 ml;
estimate p=4 q=1 ml;
estimate p=3 q=2 ml;
estimate q=12 ml;
estimate p=12 ml;*/
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;


/*deterministic*/
data product21;
set product2;
array seas(*)MON1-MON11;
retain MON1-MON11 .;
if (MON1=.) then do index= 1 to 11;
	seas[index]=0;
end;
if (month(date) lt 12) then do;
	seas[month(date)]=1;
	output;
	seas[month(date)]=0;
end;	
else output;
drop index;
run;
proc arima data=product21 plots=all;
identify var=Sales_Quantity cross=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11);
estimate p=1 input=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11)method=ml;
run;

/*try esm models*/
title 'double';
proc esm data=product2 outstat=a_double lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=double;
run;
title 'simple';
proc esm data=product2 outstat=a_simple lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=simple;
run;
title 'addseasonal';
proc esm data=product2 outstat=a_adds lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addseasonal;
run;
title 'multseasonal';
proc esm data=product2 outstat=a_ms lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=multseasonal;
run;
title 'addwinters';
proc esm data=product2 outstat=a_addhw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addwinters;
run;
title 'winters';
proc esm data=product2 outstat=a_hw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=winters;
run;


/*WW01AA
Check trend and seasonality*/


proc timeseries data=product3
out=product3_out
outdecomp=p3_decomp
plot=(decomp tc sc)
seasonality=12;
id Date interval=month;
var Sales_Quantity;
decomp tcc sc; 
run;

data product3;
set product3 (where=(Date gt '01OCT2015'd));
run;

/*first check if differencing is needed*/
proc arima data=product3;
identify var=Sales_Quantity;
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

/*stochastic*/
proc arima data=product3;
identify var=Sales_Quantity stationarity=(adf=(0 1 2 3 12));
run;

proc arima data=product3;
identify var=Sales_Quantity(1);
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

proc arima data=product3 plots=all;
identify var=Sales_Quantity(1) scan p=(0:12) q=(0:12);run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(1) minic p=(0:12) q=(0:12);run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(1) esacf p=(0:12) q=(0:12);run;

proc arima data=product3;
identify var=Sales_Quantity(1);
estimate;
estimate p=1 ml;
estimate p=(2) ml;
/*estimate p=(2 3) ml;
estimate p=2 q=3 ml;
estimate p=(5) q=2 ml;*/
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

proc arima data=product3 plots =all;
identify var=Sales_Quantity(1);
estimate p=(2) q=(3) ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

proc arima data=product3;
identify var=Sales_Quantity(2);
estimate;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

proc arima data=product3 plots=all;
identify var=Sales_Quantity(2) scan p=(0:12) q=(0:12);run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2) minic p=(0:12) q=(0:12);run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2) esacf p=(0:12) q=(0:12);run;

proc arima data=product3;
identify var=Sales_Quantity(2);
estimate p=2 ml;
estimate p=3 ml;
estimate p=1 q=2 ml;
estimate p=3 q=1 ml;
estimate q=2 ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
run;

proc arima data=product3 plots=all;
identify var=Sales_Quantity(2);
estimate p=2 ml;
forecast lead=16 id=date interval=month;
run;

proc arima data=product3 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=(2) q=(3);
estimate p=2 ml;
estimate p=3 ml;
estimate p=1 q=2 ml;
estimate p=3 q=1 ml;
estimate q=2 ml;
estimate q=(12) ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
/*forecast lead=16 id=date interval=month;*/
run;

proc arima data=product3 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=(2) q=1;
estimate p=(2) q=2;
estimate p=(2) q=3;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
/*forecast lead=16 id=date interval=month;*/
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=(12) ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=(2) q=(3);
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(1 12);
estimate p=(2) q=(2);
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;

/*to try (2,12*/
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2 12);
estimate ;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2 12);
estimate p=(2) q=(3);
estimate p=2 ml;
estimate p=3 ml;
estimate p=1 q=2 ml;
estimate p=3 q=1 ml;
estimate q=2 ml;
estimate q=(12) ml;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
/*forecast lead=16 id=date interval=month;*/
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2 12);
estimate p=(2 12)q=1;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;
proc arima data=product3 plots=all;
identify var=Sales_Quantity(2 12);
estimate p=(2) q=1;
outlier type=(ao ls tc(6 12)) maxnum=5 id=date;
forecast lead=16 id=date interval=month;
run;


/*deterministic*/
data product31;
set product3;
array seas(*)MON1-MON11;
retain MON1-MON11 .;
if (MON1=.) then do index= 1 to 11;
	seas[index]=0;
end;
if (month(date) lt 12) then do;
	seas[month(date)]=1;
	output;
	seas[month(date)]=0;
end;	
else output;
drop index;
run;
proc arima data=product31 plots=all;
identify var=Sales_Quantity cross=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11);
estimate p=1 q=1 input=(MON1 MON2 MON3 MON4 MON5 MON6 MON7 MON8 MON9 MON10 MON11)method=ml;
run;


/*try esm models*/
title 'double';
proc esm data=product3 outstat=double lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=double;
run;
title 'simple';
proc esm data=product3 outstat=a_simple lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=simple;
run;
title 'addseasonal';
proc esm data=product3 outstat=a_adds lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addseasonal;
run;
title 'multseasonal';
proc esm data=product3 outstat=a_ms lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=multseasonal;
run;
title 'addwinters';
proc esm data=product3 outstat=a_addhw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=addwinters;
run;
title 'winters';
proc esm data=product3 outstat=a_hw lead=16 plot=forecasts;
id date interval=month;
forecast Sales_Quantity / model=winters;
run;
