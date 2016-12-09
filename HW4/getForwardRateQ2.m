function Rate = getForwardRateQ2()

    days1 = wrkdydif('11/17/2016', '12/16/2016', 0);
    days2 = wrkdydif('12/17/2016', '2/16/2017', 0);
    days3 = wrkdydif('2/17/2017', '5/16/2017', 0);

    numOfDays = [ days1, days2, days3 ];
    rates = [ 0.003, 0.005, 0.006 ];
    forwardRate = zeros( size( numOfDays ) );
    forwardRate( 1 ) = 0.003;
    for i = 1 : size( numOfDays, 2) - 1
        forwardRate( i + 1 ) = ( rates( i + 1 ) * sum( numOfDays(1 : i + 1) ) - rates( i ) * sum( numOfDays( 1 : i ) ) ) / numOfDays( i + 1 );
    end
    Rate = [];
    for i = 1 : size(numOfDays,2)
        Rate = [ Rate, forwardRate( i ) * ones( 1, numOfDays( i ) ) ];
    end
    Rate = fliplr( Rate );
