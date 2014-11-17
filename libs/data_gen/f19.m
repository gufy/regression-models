function [ f ] = f19( D, x_opt, f_opt, R, Q )
%F19 Composite Griewank-Rosenbrock Function F8F2
%   

    function [res] = s(x) 
        z = max(1, sqrt(D) / 8) * R * x + 0.5;
        res = 100 * (z.^2 - [z(2:D); 0].^2) + (z - 1) .^ 2;
        res = res(1:D-1);
    end

    f = @(x) ((10 / (D - 1)) * sum ( s(x) / 4000 - cos(s(x)) ) + 10 + f_opt);

end

