# Time Series
follow the edX corse FA18: Time Series Analysis using R

  **Data:** ![Y_t](https://latex.codecogs.com/gif.latex?Y_t) where t indexes time (minute, hour, day...)

  **Model:** ![model](https://latex.codecogs.com/gif.latex?Y_t%3Dm_t&plus;s_t&plus;X_t)
   * ![mt](https://latex.codecogs.com/gif.latex?m_t) is a trend component
   * ![st](https://latex.codecogs.com/gif.latex?s_t) is a seasonality component with known periodicity d(![dforum](https://latex.codecogs.com/gif.latex?s_t%3Ds_%7Bt&plus;d%7D)) such that ![f](https://latex.codecogs.com/gif.latex?%5Csum_%7Bj%3D1%7D%5Eds_j%3D0)
   * ![Xt](https://latex.codecogs.com/gif.latex?X_t) is a stationary component (its probability distribution does not change with shifted in time
  
  **Approach:** ![mt](https://latex.codecogs.com/gif.latex?m_t) and ![st](https://latex.codecogs.com/gif.latex?s_t) are first estimated and subtracted from ![Yt](https://latex.codecogs.com/gif.latex?Y_t) to have left the stationary process ![Xt](https://latex.codecogs.com/gif.latex?X_t) to be model using time series modeling approaches.


## Topic 1: Analyzing trend

### Elimination of Trend
  1.	Estimate trend and remove it
  2.	Difference the data to remoe the trend directly
### Estimation Methods
  1.	Moving Average
  2.	Parametric Regression (Linear, Quadratic, etc…)
  3.	Non-Parametric Regression

### [Analyzing trend: R exercise](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_1_Analyzing_Trend.ipynb)

Comparing the trend with dataset `AvTempAtlanta.txt`, first to plot a time serie of the data using `ts()`, then to create the data point. Finally we use different methods to fit the trend of the data to see the comparison of different trend estimation method.
  * Moving average: built-in `ksmooth()`
  * Parametric regression: quadratic polynomial ![X_1+X_2](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_1_Analyzing_Trend.ipynb) using built-in `lm()`
  * Non-Parametric Regression: **Local Polynomial trend estimation** with built-in `loess()` and **splines trend estimation** with `gam()` from `mgcv` library
  
## Topic 2: Analyzing seasonality

### Elimination of Seasonality

 1. Estimate Seasonality and remove it
 2. Difference the data to remove the Seasonality directly

### Estimation Methods

 1. Seasonal average
 2. Parametric regression
 
 * Fit a mean for each seasonality group (e.g. month) using linear regression
 * Use a cosine-sin curve to fit the seasonal component

### [Elimilating both seasonality and trend: R exercise](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_2_Analyzing_Seasonality_plus_autocorrelation_function.ipynb)

**Part 1: For elimilating seasonality:**

 * **Seasonal means model:**: with `season` in `TSA` library alone with `lm` functions. This method we create 12 dummy variable (categories) as our frequency is 12. We also compare 2 different model with and without intercept. (note that if there is intercept the coefficient is interpreted as the difference between 2 months: n and n-1)
 
 * **Cos-Sin model:** with R built-in `harmonic` function alone with `lm` function. A matrix consist of ![sincos](https://latex.codecogs.com/gif.latex?%5Ccos%282k%5Cpi%20t%29%24%2C%20%24%5Csin%282k%5Cpi%20t%29%2C%5Cquad%20k%3D1%2C2%2C...%2Cm). Here we try with one and two cosine curves. (note that sometimes it would improve the fit) 
 
 * if 2 models are similar in fitting the seasonality. We would prefer the **Cos-Sin model** due to the fact that it has less variables.
 
**Part 2: Adding both seasonality and trend to the model**
 
 * Simplest parametric model and non parametric model for the trend
 * Cosine-sine model for seasonality
 * Adding both trend and seasonality we can see that it explain well the data (here Adjusted R-squared is more than 90%)
 * Plot the data eliminating both seasonality and trend gave us the plot of the residual.

**Part 3: check the stationary with autocorrelation functions**

Here we would use the built-in `ACF` functions in R to check if the trend and seasonality is correctly removed.
