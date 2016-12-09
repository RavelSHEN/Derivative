forwardRate = getForwardRate;
impliedVol = getImpliedVol;
dividendYield = 0.0208 * ones( size( forwardRate ) );
K = 225;
S = ( 218.78 + 218.79 ) / 2;
T = 1;
type = 'call';
style = 'upandout';
koLevel = 235;
ExoticOptionPrice = ExoticOptionPricer( S, forwardRate, dividendYield, impliedVol, T, K, type, style, koLevel )