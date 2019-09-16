# Time Series
follow the edX corse FA18: Time Series Analysis using R

  **Data:** ![Y_t](https://latex.codecogs.com/gif.latex?Y_t) where t indexes time (minute, hour, day...)

  **Model:** ![model](https://latex.codecogs.com/gif.latex?Y_t%3Dm_t&plus;s_t&plus;X_t)
    * ![mt](https://latex.codecogs.com/gif.latex?m_t) is a trend component
    * ![st](https://latex.codecogs.com/gif.latex?s_t) is a seasonality component with known periodicity d(![dforum](https://latex.codecogs.com/gif.latex?s_t%3Ds_%7Bt&plus;d%7D)) such that ![f](https://latex.codecogs.com/gif.latex?%5Csum_%7Bj%3D1%7D%5Eds_j%3D0)
    * [Xt](https://latex.codecogs.com/gif.latex?X_t) is a stationary component (its probability distribution does not change with shifted in time
  
  **Approach:** ![mt](https://latex.codecogs.com/gif.latex?m_t) and ![st](https://latex.codecogs.com/gif.latex?s_t) are first estimated and subtracted from ![Yt](https://latex.codecogs.com/gif.latex?Y_t) to have left the stationary process ![Xt](https://latex.codecogs.com/gif.latex?X_t) to be model using time series modeling approaches.


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
  * Parametric regression: quadratic polynomial ![X_1+X_2](https://latex.codecogs.com/gif.latex?x&plus;x%5E2) using built-in `lm()`
  * Non-Parametric Regression: **Local Polynomial trend estimation** with built-in `loess()` and **splines trend estimation** with `gam()` from `mgcv` library
  
