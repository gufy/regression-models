function [ y ] = f_1( x, x_opt, f_opt )
% f_1 
% f_1(x) = \norm(z) ^ 2 + \f_opt
% z = x - x^{opt}

z = x - x_opt;
y = sum(z.^2) + f_opt;

end

