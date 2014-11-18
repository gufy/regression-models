function [ f ] = f24( D, x_opt, f_opt, R, Q )
%F24 Lunacek bi-Rastrigin Function
%   

    ones_pm = round(rand(D,1)) * 2 - 1;

    d = 1;
    s = 1 - 1 / (2 * sqrt(D + 20) - 8.2);

    mu_0 = 2.5;
    mu_1 = -sqrt((mu_0 ^ 2 - d)/s);

    x_opt = mu_0 * ones_pm;

    function [ res ] = f24_compute(x) 
        
        x_hat = 2*sign(x_opt) .* x;
        z = Q * lambda(100, D) * R * (x_hat - mu_0 * ones(D,1));
        res = min(sum((x_hat - mu_0) .^ 2), d*D + s*sum((x_hat - mu_1) .^ 2)) + 10 * (D - sum(cos(2*pi*z))) + 10^4 * f_pen(x);
        
    end

    f = @(x) f24_compute(x);

end

