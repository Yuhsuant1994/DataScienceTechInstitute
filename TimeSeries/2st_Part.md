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
 4. Causal: We can invert an AR model to MA model and MA model to AR model, under condition: causal process. Note that not all ARMA processes are causal.
 * For AR(1) process Xt is causal if |phi|<1
 * We see also if |phi| is 0.9 almost 1, the process is reaching non-causality and non-stationary
 5. Invertibility: to see if we can go from a ARMA process to an AR process where the order can be infinity meaning that the ARMA ininfinity meangining that the ARMA process is invertible

### [ACF and PACF: AR & MA Simulation](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_5_ARMA_simulation_with_ACF_and_PACF.ipynb)

* We see the **Moving Average** process for stationary and non-stationary: we can use **acf** plot to define the order
* For **Autoregressive** process for stationary and non-stationary: we can use **pacf** plot to define the order. *Note that if one solution to the equation is on unit circle (that is equal to 1) means that it is not stationary*
* As for **ARMA** process: we use `arima.sim` to stimulate ARMA process. Assuming the WN is Gaussian, otherwise we need to speify through an option of the function `rand.gen`. Note that `sd` here are the standard error for the white noise.
* For **ARMA** process we cannot use `ACF` and `PACF` plot to identify the p (pacf for AR) nor q (acf for MA).

**Summary:**

|   |AR |MA |
|---|---|---|
|ACF|→0|0 from h=q|
|PACF|0 from h=p|→0|

### [Parameter Estimation: simlutation example](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/TimeSeries/TS_6_ARMA_Parameter_Estimation_Linear_regression.ipynb)

Linear regression for AR model, even if we stimulate AR(1) and fit it to AR(2) lm model, we still see that it suggest us that the model is AR(1).

# Exponential Smoothing

The idea is to forcast future values using all previous values in the series.
 * Simple Exponential smoothing (SES)
 * Holt's (double) exponential smoothing
 * Winter's (Advanced) exponential smoothing
