function [ X, T ] = dataSample( func, D, N, maxVal, minVal, noisy )

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

f = func(D, params);

opt_val = f(x_opt_val)
display(opt_val)

X = zeros(size(N,1),D); 
T = zeros(size(N,1),1); 

for i = 1:N
    x = rand(D,1)*(maxVal - minVal) + minVal;
    X(i,:) = x;
    y = f(x);
    
    if noisy
        y = y + opt_val * 0.9 * randn(D,1);
    end
    
    T(i,1) = y;
end

end

