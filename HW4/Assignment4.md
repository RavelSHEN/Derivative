## Assignment4

#### Question 1

###### 1. 

The implied volatility is calculated using the formula:

​					$\sigma$ ~t~^2^  = ( T~i+1~ $\sigma$'~Ti+1~^2^ - T~i~ $\sigma$'~Ti~^2^ ) / ( T~i+1~ - T~i~ )

Only the work days is counted while calculating the implied volatility. The detailed code "getImpliedVol.m" is included in the package for your reference.

The result is plot below:

![ImpliedVol](/Users/RavelShen/Documents/NYU/Fall_2016/Derivative Securities/HW4/ImpliedVol.png)

###### 2.

The forward rate is calculated using the formula:

​								r~t,t+dt~ = ( ( t + dt ) R~t+dt~ - t R~t~ ) / dt

Only the work days is counted while calculating the forward rate. The detailed code "getForwardRate.m" is included in the package for your reference.

The result is plot below:

![forwardRate](/Users/RavelShen/Documents/NYU/Fall_2016/Derivative Securities/HW4/forwardRate.png)

###### 3.

The trinomial tree is built in MATLAB and the code "OptionPricerForward" is included for your reference. The forward rate and implied volatility vector is passed into the loop of iteration.

###### 4.

The European Call Option is calculated using the pricer developed in question 3. The code is included in "Q1_4.m". The price is 9.7735 according the pricer.

###### 5.

The American Call Option is calculated using the pricer developed in question 3. The code is included in "Q1_5.m". The price is 9.9229 according the pricer.

###### 6.

For knock-out option, a new pricer called "ExoticOptionPricer.m" is developed. The code is included for your reference. 

The up-and-out option is calculated using the exotic option pricer developed. The code is included in "Q1_6.m". The price is 0.0528 according the pricer.

###### 7. 

The down-and-out option is calculated using the exotic option pricer developed. The code is included in "Q1_7.m". The price is 5.5866 according the pricer.

###### Comparation:

Now, we compare the result with the constant rate and volatility case. We take the constant rate as 0.7% and constant volatility as 16%

For question 4, the option price with rate and volatility in term structure is 9.7735 while the price calculated using Black-Scholes using constant rate and volatility is 9.8529.

For question 5, the option price with rate and volatility in term structure is 9.9229 while the price with constant rate and volatility is 10.0345.

For question 6, the option price with rate and volatility in term structure is 0.0528 while the price with constant rate and volatility is 0.0818. If we use the explicit formula, the price is 0.0362.

For question 7, the option price with rate and volatility in term structure is 5.5866 while the price with constant rate and volatility is 5.3240. If we use the explicit formula, the price is 5.2546.



#### Question 2

In this question, the option will expire in May 2017, so the implied volatility and forward rate will be re-calculated. The code is included in "getImpliedVolQ2.m" and "getForwardRateQ2.m". 

Then, a new pricer is defined. The detailed code is included in "RangeAccrualOptionPricer.m". The price calculated by the pricer is 41356.

