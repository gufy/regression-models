function [ res ] = noisyDataSample( func, D, N, maxVal, minVal )

noisy = 1;
res = dataSample( func, D, N, maxVal, minVal, noisy );

end
