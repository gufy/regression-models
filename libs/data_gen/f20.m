function [ f ] = f20( D, params, noisy )
%F20 Schwefel Function
% It's log-transformed, i.e. real(log(f(x) - f_opt) / log(10))
% f20 function creator. Returns a function which calculate the function
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
    f_opt = params{2};
    
    if length(params) > 4
        rng(params{5});
    else
        rng(1);
    end
    
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

    function [res] = f20_compute(x) 
        res = (-1/D) * sum( z(x) .* sin(sqrt(abs(z(x)))));
       
        if noisy
            res = res + 5*10^3 * randn();
        end
        
        res = res + 4.189828872724339 + 100 * f_pen(z(x) / 100) + f_opt;
    end
    
    f = @(x) f20_compute(x);
    f = @(x) real(log(f(x) - f_opt) / log(10));
    
end

