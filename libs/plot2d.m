function [ h ] = plot2d( func, num, range, rand, normX, normY )

format long
D = 1;

if nargin < 3 || (length(range) == 1 && range == 0)
    range = 5;
end

if nargin < 4
    rand = 0;
end

if nargin < 5
    normX = 0;
end

if nargin < 6
    normY = 0;
end

if length(range) == 2
    xmin = range(1); xmax = range(2);
else
    xmin = -range; xmax = range;
end

if rand
    x_opt_val = zeros(D,1);%x_opt(D);
    f_opt_val = f_opt();
    [Q, R] = qr(rand(D));
else
    x_opt_val = zeros(D,1);
    f_opt_val = 0;
    Q = eye(D);
    R = Q;
end

params = {x_opt_val, f_opt_val, R, Q};

f = func(D, params);

ran = linspace(xmin, xmax, num);
N = num;

X = ran';
Y = zeros(N,1);

for I = 1:N
    Y(I) = f(X(I));
end

if isa(normX,'function_handle')
    X = normX(X);
end

if isa(normY,'function_handle')
    Y = normY(Y);
end

h = plot(X, Y);
title(func2str(func));

end

