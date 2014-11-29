function [ ] = plot3d( func, range, rand )

format long
D = 2;

if nargin < 2
    range = 5;
end

if nargin < 3
    rand = 0;
end

xmin = -range; xmax = range;
ymin = -range; ymax = range;

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

f = func(D, x_opt_val, f_opt_val, R, Q);

ran = xmin:0.1:xmax;
N = length(ran)*length(ran);

X = zeros(D, N);
Y = zeros(N, 1);

i = 1;
for x_1 = ran
    for x_2 = ran

        x = [x_1 x_2]';
        X(:, i) = x;
        
        y = f(x);
        Y(i) = y;

        i = i + 1;
    end
end

xscale = ran + x_opt_val(1);
yscale = ran + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = reshape(Y,[length(ran) length(ran)]);
mesh(XS, YS, ZS);

zmin = min(Y);
zmax = max(Y);
zmax = zmax + (zmax - zmin) * 0.3;

%if zmax - zmin > 1000
%    zmax = zmin + 1000;
%end

axis([xmin xmax ymin ymax zmin zmax]);
title(func2str(func));

end

