function [ y ] = f20( x, x_opt, f_opt, R, Q )
%F20 Schwefel Function
%   

D = length(x);
ones_pm = round(rand(D,1)) * 2 - 1;
x_hat = 2 * ones_pm .* x;
x_opt = 4.2096874633/2 * ones_pm;

z_hat = zeros(size(x));
z_hat(1) = x(1);
for I = 1:D-1
    z_hat(I+1) = x(I+1) + 0.25 * (x_hat(I) - x_opt(I));
end

z = 100 * (lambda(10, D) * (z_hat - x_opt) + x_opt);

y = (-1/D) * sum( z .* sin(sqrt(z))) + 4.189828872724339 + 100 * f_pen(z / 100) + f_opt;
y = real(y);

end

