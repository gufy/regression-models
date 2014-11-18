function [ f ] = f20( D, x_opt, f_opt, R, Q )
%F20 Schwefel Function
% It's log-transformed, i.e. real(log(f(x) - f_opt) / log(10))

    ones_pm = round(rand(D,1)) * 2 - 1;
        
    function [res] = z(x)
        x_hat = 2 * ones_pm .* x;
        x_opt = (4.2096874633 ./ (2 * ones_pm));

        z_hat = zeros(size(x));
        z_hat(1) = x_hat(1);
        for I = 1:D-1
            z_hat(I+1) = x_hat(I+1) + 0.25 * (x_hat(I) - x_opt(I));
        end
    
        res = 100 * (lambda(10, D) * (z_hat - x_opt) + x_opt);
    end

    f = @(x) ((-1/D) * sum( z(x) .* sin(sqrt(abs(z(x))))) + 4.189828872724339 + 100 * f_pen(z(x) / 100) + f_opt);
    f = @(x) real(log(f(x) - f_opt) / log(10));
    
end

