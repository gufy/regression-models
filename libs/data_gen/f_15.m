function [ y ] = f_15( x, x_opt, f_opt, R, Q )

D = length(x);
z = R * lambda(10, D) * Q * T_asy(T_osz(R*(x - x_opt)),0.2);
y = 10 * (D - sum(cos(2*pi*z))) + sum(z.^2) + f_opt;

end

