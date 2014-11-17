

D = 2;
range = 5;

xmin = -range; xmax = range;
ymin = -range; ymax = range;

x_opt_val = zeros(D,1);%x_opt(D);
f_opt_val = f_opt();
[Q, R] = qr(randn(D));

f = f19(D, x_opt_val, f_opt_val, R, Q);


ran = xmin:0.1:xmax;
N = length(ran)*length(ran);

X = zeros(D, N);
Y = zeros(N, 1);
    
i = 1;
for x_1 = ran
    for x_2 = ran

        x = [x_1 x_2]';
        X(:, i) = x;

        y = real(log(f(x) - f_opt_val) / log(10));
        if ~isreal(y)
            display(y)
        end
        Y(i) = y;

        i = i + 1;
    end
end

xscale = ran + x_opt_val(1);
yscale = ran + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = reshape(Y,[length(ran) length(ran)]);
meshc(XS, YS, ZS);

zmin = min(Y);
zmax = max(Y);
zmax = zmax + (zmax - zmin) * 0.3;

axis([xmin xmax ymin ymax zmin zmax]);
title(func2str(f));