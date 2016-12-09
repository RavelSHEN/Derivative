forwardRate = getForwardRateQ2;
impliedVol = getImpliedVolQ2;
dividendYield = 0.0208 * ones( size( forwardRate ) );
S = ( 218.78 + 218.79 ) / 2;
T = 129 / 261;
lBound = 210;
uBound = 230;
RangeAccrualOptionPrice = RangeAccrualOptionPricer( S, forwardRate, dividendYield, impliedVol, T, lBound, uBound );
