# ARMA model

The process ![Process](https://latex.codecogs.com/gif.latex?X_t%2Ct%5Cin%5Cmathbb%7BZ%7D) is said to be an ARMA(p,q) process if ![x-t] (https://latex.codecogs.com/gif.latex?X_t) is stationary and if for every t,

![AR](https://latex.codecogs.com/gif.latex?X_t-%5Cphi_1X_%7Bt-1%7D-...-%5Cphi_qX_%7Bt-q%7D)(Auto Regression)

![MA](https://latex.codecogs.com/gif.latex?%3DZ_t&plus;%5Ctheta_1Z_%7Bt-1%7D&plus;...&plus;%5Ctheta_qZ_%7Bt-q%7D)(Moving Average)

Where ![z_WN](https://latex.codecogs.com/gif.latex?Z_t%20%5Csim%20%5Ctext%7BWN%7D%280%2C%5Csigma%5E2%29)

* AR order p and MA order q

Write the ARMA model in a more compact form

![compact](https://latex.codecogs.com/gif.latex?%5Cphi%28B%29X_t%3D%5Ctheta%28B%29Z_t)

