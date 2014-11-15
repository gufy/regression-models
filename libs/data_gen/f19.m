function [ y ] = f19( x, x_opt, f_opt, R, Q )
%F19 Composite Griewank-Rosenbrock Function F8F2
%   

D = length(x);

z = max(1, sqrt(D) / 8) * R * x + 0.5;
s = 100 * (z.^2 - [z(2:D); 0].^2) + (z - 1) .^ 2;
z_opt = 1;

y = (10 / (D - 1)) * sum ( s(1:D-1) / 4000 - cos(s(1:D-1)) ) + 10 + f_opt;

end

