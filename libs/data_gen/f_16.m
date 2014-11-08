function [ y ] = f_16( x, x_opt, f_opt, R, Q )
% Weierstrass Function

D = length(x);
z = R * lambda(1/100, D) * Q * T_osz(R*(x - x_opt));
y = 10 * (D - sum(cos(2*pi*z))) + sum(z.^2) + f_opt;

end

