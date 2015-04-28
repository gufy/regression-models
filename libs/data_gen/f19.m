function [ f ] = f19( D, params, noisy )
%F19 Composite Griewank-Rosenbrock Function F8F2
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
    
    f_opt = params{2};
    R = params{3};
    
    function [res] = s(x) 
        z = max(1, sqrt(D) / 8) * R * x + 0.5;
        res = 100 * (z.^2 - [z(2:D); 0]).^2 + (z - 1) .^ 2;
        res = res(1:D-1);
    end

    function [res] = f19_compute(x) 
        res = (10 / (D - 1)) * sum ( s(x) / 4000 - cos(s(x)) );
        
        if noisy
            res = res + 20 * randn();
        end
        
        res = res + 10 + f_opt;
    end

    f = @(x) f19_compute(x);

end

