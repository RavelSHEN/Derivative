function [ BSCall ] = RangeAccrualOptionPricer( S0, r, q, sigma, T, lBound, uBound )
% function: Short description
%
% Extended description

% dt = 1 / size( r, 2 );
dt = 1 / 261;
N = round( T / dt );
mu = r - q - 0.5 * sigma .* sigma;

smax = max( 2 * abs( mu ) * sqrt( dt ) );

if smax < max( sigma ) * sqrt( 2 )
    smax = max( sigma ) * sqrt( 2 );
end
if smax == 0
    BSCall = -9999;
end

M = round( 5 * sqrt( N ) );

p = 0.5 * ( sigma .* sigma ) ./ ( smax * smax );

PU = p + 0.5 * mu * sqrt( dt ) / smax;
PM = 1 - 2 * p;
PD = p - 0.5 * mu * sqrt( dt ) / smax;

D = 1 ./ ( 1 + r * dt );
E = exp( smax * sqrt( dt ) );

S( 1, 1 ) = S0 * exp( - M * smax * sqrt( dt ) );

for j = 2 : 2 * M + 1
    S( 1, j ) = S( 1, j -1 ) * E;
end

for j = 2 : ( 2 * M + 1 )
    if S( 1, j ) > lBound && S( 1, j ) < uBound
        C( 1, j ) = 1000;
    else
        C( 1, j ) = 0;
    end
end

for k = 1 : N
    %
    % S( 1, 1 ) = S0 * exp( - M * smax( k ) * sqrt( dt ) );
    % for j = 2 : 2 * M + 1
    %     S( 1, j ) = S( 1, j -1 ) * E(1,k);
    % end

    for j = 2 : 2 * M
        pC( 1, j ) = PU( k ) * C( 1, j+1 ) + PM( k ) * C( 1, j ) + PD( k ) * C( 1, j - 1 );
        pC( 1, j ) = pC( 1, j ) * D( k );
    end

    pC( 1, 1 ) = 2 * pC( 1, 2 ) - pC( 1, 3 );
    pC( 1, 2 * M + 1 ) = 2 * pC( 1, 2 * M ) - pC( 1, 2 * M - 1 );

    for j = 1 : 2 * M + 1
        if S( 1, j ) > lBound && S( 1, j ) < uBound
            C( 1, j ) = pC( 1, j ) + 1000;
        else
            C( 1, j ) = 0;
        end
    end

end

BSCall = C( 1, M + 1 );

end  % function
