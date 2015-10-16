function [ f ] = f18( D, params, noisy )
%F_18 Schaffers F7 Function moderately ill conditioned
%  instead of T_asy(..., 0.5) uses 0.1
% f18 function creator. Returns a function which calculate the function
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
    R = params{3};
    Q = params{4};
    
    function [ res ] = f18_compute(x)
        
        z = lambda(1000, D) * Q * T_asy(R*(x - x_opt), 0.12);
        %z = x;
        s = sqrt(z.^2 + [z(2:D); 0].^2);
        res = ((1/(D-1)) * sum(sqrt(s(1:D-1)) + sqrt(s(1:D-1)).*(sin(50 * s(1:D-1) .^ (1/5)))))^2;
        
        if noisy 
            res = res + 80 * randn();
        end
        
        res = res + 10 * f_pen(x) + f_opt;

    end

    f = @(x) f18_compute(x);

end

