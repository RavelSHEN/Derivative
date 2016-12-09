function [ BSPrice ] = OptionPricer( S, r, q, sigma, T, K, optionType, optionStyle )
% function: Short description
%
% Extended description
dt = 1 / 252;
N = round( T / dt );
mu = r - q - 0.5 * sigma * sigma;
smax = 2 * abs( mu ) * sqrt( dt );
if ( smax < sigma * sqrt( 2 ) )
    smax = sigma * sqrt(2);
end
if smax == 0
    BSPrice = -9999;
end
M = round( 5 * sqrt( N ) );

p = 0.5 * sigma * sigma / ( smax * smax );

PU = p + 0.5 * mu * sqrt( dt ) / smax;
PM = 1 - 2 * p;
PD = p - 0.5 * mu * sqrt( dt ) / smax;

D = 1 / ( 1 + r * dt );
E = exp( smax * sqrt( dt ) );

S( 1, 1 ) = S * exp( - M * smax * sqrt( dt ) );
for j = 2 : 2 * M + 1
    S( 1, j ) = S( 1, j -1 ) * E;
end

if strcmp( optionType, 'call' )
    for j = 1 : 2 * M + 1
        C( 1, j ) = max( S( 1, j ) - K , 0 );
    end
elseif strcmp( optionType, 'put')
    for j = 1 : 2 * M + 1
        C( 1, j ) = max( K - S( 1, j ) , 0 );
    end
end

for k = 1 : N
    for j = 2 : 2 * M
        pC( 1, j ) = PU * C( 1, j+1 ) + PM * C( 1, j ) + PD * C( 1, j - 1 );
        pC( 1, j ) = pC( 1, j ) * D;
    end

    pC( 1, 1 ) = 2 * pC( 1, 2 ) - pC( 1, 3 );
    pC( 1, 2 * M + 1 ) = 2 * pC( 1, 2 * M ) - pC( 1, 2 * M - 1 );

    if strcmp( optionStyle, 'european')
        for j = 1 : 2 * M + 1
            C( 1, j ) = pC( 1, j );
        end
    elseif  strcmp( optionStyle, 'american')
        for j = 1 : 2 * M + 1
            C( 1, j ) = pC( 1, j );
            if strcmp( optionType, 'call' )
                if ( C( 1, j ) < max( S( 1, j ) - K, 0 ) )
                    C( 1, j ) = max( S( 1, j ) - K, 0 );
                end
            elseif strcmp( optionType, 'put' )
                if ( C( 1, j ) < max( K - S( 1, j ), 0 ) )
                    C( 1, j ) = max( K - S( 1, j ), 0 );
                end
            end
        end
    end
end

BSPrice = C( 1, M + 1 );

end  % function
