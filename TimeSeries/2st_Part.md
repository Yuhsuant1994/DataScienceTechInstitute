# ARMA model

The process ![Process](https://latex.codecogs.com/gif.latex?X_t%2Ct%5Cin%5Cmathbb%7BZ%7D) is said to be an ARMA(p,q) process if ![x-t](https://latex.codecogs.com/gif.latex?X_t) is stationary and if for every t,

![AR](https://latex.codecogs.com/gif.latex?X_t-%5Cphi_1X_%7Bt-1%7D-...-%5Cphi_qX_%7Bt-q%7D)  (Auto Regression)

![MA](https://latex.codecogs.com/gif.latex?%3DZ_t&plus;%5Ctheta_1Z_%7Bt-1%7D&plus;...&plus;%5Ctheta_qZ_%7Bt-q%7D)  (Moving Average)

Where ![z_WN](https://latex.codecogs.com/gif.latex?Z_t%20%5Csim%20%5Ctext%7BWN%7D%280%2C%5Csigma%5E2%29)

* AR order p and MA order q

Write the ARMA model in a more compact form

![compact](https://latex.codecogs.com/gif.latex?%5Cphi%28B%29X_t%3D%5Ctheta%28B%29Z_t)

We can then gerenerate

![Xt](https://latex.codecogs.com/gif.latex?X_t%3D%5Cfrac%7B%5Ctheta%28B%29%7D%7B%5Cphi%28B%29%7DZ_t)

![Zt](https://latex.codecogs.com/gif.latex?Z_t%3D%5Cfrac%7B%5Cphi%28B%29%7D%7B%5Ctheta%28B%29%7DX_t)

* Stationarity is determined by the AR process
* Invertibility is determined by the MA process

### [ARMA Basic: R](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_4_ARMA_Basic.ipynb)

 1. Simulate White noise: with `rnorm` and `rexp`
 2. Simulate moving average: with `filter` function and specify `side=1` 
  * here we compare MA(2) with normal and exponential distributed white noise with coefficient (1, 0.5, 0.2) vs (1, -0.5, 0.2)
  * then we try to see with non-stationary WN, that is Zt=WN(0,1)\*(2t+0.5)
  * We see that for MA, we cannot see the non-stationarity from  `ACF` graph
 3. Simulate Autoregressive process: with `filter` function and specify `method='recursive`
  * Compare stationary AR(1) and non-stationary AR(2)
  * For AR, the non-stationary can see clearly from the `ACF` graph


# Exponential Smoothing

The idea is to forcast future values using all previous values in the series.
 * Simple Exponential smoothing (SES)
 * Holt's (double) exponential smoothing
 * Winter's (Advanced) exponential smoothing
