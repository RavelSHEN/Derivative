function Vol = getImpliedVol()

    days1 = wrkdydif('11/17/2016', '12/29/2016', 0);
    days2 = wrkdydif('12/30/2016', '1/19/2017', 0);
    days3 = wrkdydif('1/20/2017', '2/16/2017', 0);
    days4 = wrkdydif('2/17/2017', '3/30/2017', 0);
    days5 = wrkdydif('3/31/2017', '6/29/2017', 0);
    days6 = wrkdydif('6/30/2017', '9/28/2017', 0);
    days7 = wrkdydif('9/29/2017', '12/14/2017', 0);
    days = wrkdydif('11/17/2016', '11/16/2017', 0);

    % numOfDays = [ wrkdydif('11/17/2016', '12/30/2016', 1), wrkdydif('1/1/2017', '1/20/2016', 1), , 42, 91, 91, 48];
    numOfDays = [ days1, days2, days3, days4, days5, days6, days7 ];
    atmVol = [ 11.5, 11.9, 12.9, 13.6, 14.9, 15.7, 16];
    impliedVol = zeros( size( numOfDays ) );
    impliedVol(1) = sqrt( ( atmVol( 1 ) / 100 )^2 );
    for i = 1 : size( numOfDays,2 ) - 1
        impliedVol( i + 1 ) = sqrt ( ( sum(numOfDays( 1 : i + 1 )) * (atmVol(i+1)/100)^2 - sum(numOfDays(1 : i)) * (atmVol(i)/100)^2) / numOfDays( i + 1 ) );
    end
    Vol = [];
    for i = 1 : size(numOfDays,2)
        Vol = [ Vol, impliedVol( i ) * ones( 1, numOfDays( i ) ) ];
    end
    Vol = fliplr( Vol(1:days) );
