function [ X, T ] = dataSample( func, D, N, maxVal, minVal, noisy )
%   dataSample( func, D, N, maxVal, minVal, noisy )
%       Using function prescription func, dimension D, data set size
%       N and minimum and maximum value allowed.
%
%   Parameters
%       func    a function handler, required
%       D       a dimension of the data set
%       N       a size of the data set
%       maxVal  upper bound of the interval from which the input values
%       are randomly drawn, default 5
%       minVal  lower bound of the interval from which the input values
%       are randomly drawn, default -maxVal
%       noisy   whether to add noise or not, default 0
%
%   Returns
%       X       N samples uniformly drawn from D-dimensional interval [minVal, maxVal]^D
%       T       N target values computed from X using function func
%
%   Example
%       >> dataSample(@f15, 2, 300)
%

if nargin < 4
    maxVal = 5;
end

if nargin < 5
    minVal = -maxVal;
end

if nargin < 6
    noisy = 0;
end

if nargin < 3
    error('Incorrect number of parameter. 3 are mandatory. Example: dataSample( @f15, 2, 100 )');
end

R = eye(D);
Q = R;

x_opt_val = zeros(D,1);
f_opt_val = 0;

params = {x_opt_val, f_opt_val, R, Q};

f = func(D, params, noisy);

opt_val = f(x_opt_val);

X = zeros(size(N,1),D); 
T = zeros(size(N,1),1); 

for i = 1:N
    x = rand(D,1)*(maxVal - minVal) + minVal;
    X(i,:) = x;
    y = f(x);
    T(i,1) = y;
end

end

