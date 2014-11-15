function [ ] = plot3d( func, D, N, range )

if nargin < 2 || D == 0
    D = 2;
end

if nargin < 3 || N == 0
    N = 5000;
end

if nargin < 4
    range = 5;
end

xmin = -range; xmax = range;
ymin = -range; ymax = range;

x_opt_val = zeros(D,1);%x_opt(D);
f_opt_val = f_opt();
[Q, R] = qr(randn(D));

X = zeros(D, N);
Y = zeros(N, 1);
    
for i = 1:N
    
    x = rand(D,1)*(xmax - xmin) + xmin;
    X(:, i) = x;
    
    y = func(x, x_opt_val, f_opt_val, R, Q);
    Y(i) = y;
    
end

xscale = xmin:0.05:xmax + x_opt_val(1);
yscale = ymin:0.05:ymax + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = griddata(X(1,:),X(2,:),Y, XS, YS);
meshc(XS, YS, ZS);

zmin = min(Y);
zmax = max(Y);
zmax = zmax + (zmax - zmin) * 0.3;

axis([xmin xmax ymin ymax zmin zmax]);
title(func2str(func));

end

