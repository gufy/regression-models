function [ h ] = plot3d( func, range, randomize, noisy )
% plot3d( func, range, randomize, noisy )
%       Plots 3-dimensional graph of func using interval [-range, range]x[-range, range].
%       The output can be randomize by setting randomize to 1. A noise can
%       be added by setting noise to 1.
%
%   Parameters
%       func:       a function handler which is used to calculate function
%                   values
%       range:      defines interval [-range, range] from which the first two coordinates
%                   are uniformly randomly samples, default 5
%       randomize:  by default the parameters for function handler are kept
%                   the same, this can be changed by setting randomize to 1
%       noisy:      set to 1 to add a noise to output of func
%

format long
D = 2;

if nargin < 2
    range = 5;
end

if nargin < 3
    randomize = 0;
end

if nargin < 4
    noisy = 0;
end

xmin = -range; xmax = range;
ymin = -range; ymax = range;

if randomize
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

f = func(D, params, noisy);

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
h = mesh(XS, YS, ZS);

zmin = min(Y);
zmax = max(Y);
zmax = zmax + (zmax - zmin) * 0.3;

%if zmax - zmin > 1000
%    zmax = zmin + 1000;
%end

axis([xmin xmax ymin ymax zmin zmax]);
title(func2str(func));

end

