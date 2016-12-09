%% Compare Q1.4
forwardRate = getForwardRate;
impliedVol = getImpliedVol;
dividendYield = 0.0208 * ones( size( forwardRate ) );
K = 225;
S = ( 218.78 + 218.79 ) / 2;
T = 1;

[Q4BSCallPrice, Q4BSPutPrice] = blsprice( 218.785, 225, 0.007, 1, 0.16, 0.0208);
% priceQ4Constant = OptionPricerConstant( 218.785, 0.007, 0.0208, 0.16, 1, 225, 'call', 'european');
Q4PriceForward = OptionPricerForward( S, forwardRate, dividendYield, impliedVol, T, K, 'call', 'european' );

%% Compare Q1.5, 1.6, 1.7
impliedVol = getImpliedVol;
constantVol = 0.16 * ones(size(impliedVol));

Q5PriceTermVol = OptionPricerForward( S, forwardRate, dividendYield, impliedVol, T, K, 'call', 'american' );
Q5PriceConstantVol = OptionPricerForward( S, forwardRate, dividendYield, constantVol, T, K, 'call', 'american' );
Q6PriceTermVol = ExoticOptionPricer( S, forwardRate, dividendYield, impliedVol, T, K, 'call', 'upandout', 235 );
Q6PriceConstantVol = ExoticOptionPricer( S, forwardRate, dividendYield, constantVol, T, K, 'call', 'upandout', 235 );
Q7PriceTermVol = ExoticOptionPricer( S, forwardRate, dividendYield, impliedVol, T, K, 'call', 'downandout', 210 );
Q7PriceConstantVol = ExoticOptionPricer( S, forwardRate, dividendYield, constantVol, T, K, 'call', 'downandout', 210 );

%% Compare with explicit formula
%Q1.6 explicit
lambda = ( 0.007 - 0.0208 + 0.16 * 0.16 / 2 ) / ( 0.16 * 0.16 );
g = 1 / 0.16 / sqrt( 1 ) * log( 235 / S ) + lambda * 0.16 * sqrt( 1 );
e1 = 1 / 0.16 / sqrt( 1 ) * log( 235 * 235 / S / K ) + lambda * 0.16 * sqrt( 1 );
f1 = 1 / 0.16 / sqrt( 1 ) * log( S / 235 ) + lambda * 0.16 * sqrt( 1 );
f2 = f1 - 0.16 * sqrt( 1 );
Cui = S * exp( -0.0208 * 1 ) * normcdf( f1 ) ...
                    - K * exp( -0.007 * 1 ) * normcdf( f2 ) ...
                    - S * exp( -0.0208 * 1 ) * ( ( 235 / S ) ^ ( 2 * lambda ) ) * ( normcdf( -e1 ) - normcdf( -g ) ) ...
                    + K * exp( -0.007 * 1 ) * ( ( 235 / S ) ^ ( 2 * lambda - 2 ) ) * ( normcdf( -e1 + 0.16 ) - normcdf( -g + 0.16 ) );
BSPrice = blsprice( S, K, 0.007, 1, 0.16, 0.0208);
Q6PriceExplicit = BSPrice(1) - Cui;

%Q1.7 explicit
lambda = ( 0.007 - 0.0208 + 0.16 * 0.16 / 2 ) / ( 0.16 * 0.16 );
e1 = 1 / ( 0.16 * 1 ) * log( 210 * 210 / 225 / S ) + lambda * 0.16 * 1;
e2 = e1 - 0.16 * 1;
d1 = 1 / ( 0.16 * 1 ) * log( S * exp( 0.007 - 0.0208 ) / 225 ) + 0.16 * 1 / 2;
d2 = d1 - 0.16 * 1;
Q7PriceExplicit = S * exp( -0.0208 * 1 ) * normcdf( d1 )...
                    - K * exp( -0.007 * 1 ) * normcdf( d2 ) ...
                    - S * exp( -0.0208 ) * ( ( 210 / S )^( 2 * lambda ) ) * normcdf( e1 ) ...
                    + K * exp( -0.007 ) * ( ( 210 / S ) ^ ( 2 * lambda - 2 ) ) * normcdf( e2 );
