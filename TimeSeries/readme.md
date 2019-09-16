# Time Series
follow the edX corse FA18: Time Series Analysis using R

## Topic 1: Analyzing trend

### Elimination of Trend
  1.	Estimate trend and remove it
  2.	Difference the data to remoe the trend directly
### Estimation Methods
  1.	Moving Average
  2.	Parametric Regression (Linear, Quadratic, etc…)
  3.	Non-Parametric Regression
### [Analyzing trend: R exercise](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/1.%20Analyzing%20trend.R)

Comparing the trend with dataset `AvTempAtlanta.txt`, first to plot a time serie of the data using `ts()`, then to create the data point. Finally we use different methods to fit the trend of the data to see the comparison of different trend estimation method.
  * Moving average: built-in `ksmooth()`
  * Parametric regression: quadratic polynomial $X_1+X_2$ using built-in `lm()`
  * Non-Parametric Regression: **Local Polynomial trend estimation** with built-in `loess()` and **splines trend estimation** with `gam()` from `mgcv` library
  
