function [ f ] = f15( D, params, noisy )
% f15 function creator. Returns a function which calculate the function
% values.
%
%   D - dimension
%   params - a cell with paramaters:
%               x_opt = params{1};
%               f_opt = params{2};
%               R = params{3};
%               Q = params{4};
%   noisy - if 1, then add noise 
%

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
    R = params{3};
    Q = params{4};

    function [res] = f15_compute(x)
        z = R * Q * T_asy(T_osz(R * (x - x_opt)),0.2);
        res = 10 * (D - sum(cos(2*pi*z))) + sum(z.^2);
        
        if noisy
            res = res + 10 * randn();
        end
        
        res = res + f_opt;
    end

    f = @(x) f15_compute(x);

end

