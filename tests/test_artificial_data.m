D = 3;
N = 2000;
maxVal = 5;
minVal = -5;

for II = 15:24

    fprintf('Testing f%d', II);
    func = str2func(strcat('f', int2str(II)));
    [ X, T ] = dataSample( func, D, N, maxVal, minVal );
    fprintf(', sampled %d\n', length(T));

end