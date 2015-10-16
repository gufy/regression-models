function [ f ] = f24( D, params, noisy )
%F24 Lunacek bi-Rastrigin Function
% f24 function creator. Returns a function which calculate the function
% values.
%
%   D - dimension
%   params - a cell with paramaters:
%               x_opt = params{1};
%               f_opt = params{2};
%               R = params{3};
%               Q = params{4};
%   noisy - if 1, then add noise 

    if nargin < 1
        D = 2;
    end

    if nargin < 2
        params = default_params(D);
    end
    
    if nargin < 3
        noisy = 0;
    end
    
    x_opt = params{1};
    R = params{3};
    Q = params{4};
    
    if length(params) > 4
        rng(params{5});
    else
        rng(1);
    end
    
    ones_pm = round(rand(D,1)) * 2 - 1;

    d = 1;
    s = 1 - 1 / (2 * sqrt(D + 20) - 8.2);

    mu_0 = 2.5;
    mu_1 = -sqrt((mu_0 ^ 2 - d)/s);

    x_opt = mu_0 * ones_pm;

    function [ res ] = f24_compute(x) 
        
        x_hat = 2*sign(x_opt) .* x;
        z = Q * lambda(100, D) * R * (x_hat - mu_0 * ones(D,1));
        res = min(sum((x_hat - mu_0) .^ 2), d*D + s*sum((x_hat - mu_1) .^ 2)) + 10 * (D - sum(cos(2*pi*z)));
        
        if noisy
            res = res + 10 * randn();
        end
        
        res = res + 10^4 * f_pen(x);
        
    end

    f = @(x) f24_compute(x);

end

