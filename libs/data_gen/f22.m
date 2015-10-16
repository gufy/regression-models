function [ f ] = f22( D, params, noisy )
%F22 Gallagher?s Gaussian 21-hi Peaks Function
% f22 function creator. Returns a function which calculate the function
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
    
    f_opt = params{2};
    R = params{3};
    
    if length(params) > 4
        rng(params{5});
    else
        rng(1);
    end

    y = zeros(21, D);
    y(1,:) = rand(1,D) * 8 - 4;
    y(2:21,:) = rand(20,D) * (2 * 4.9) -  4.9;
        
    w = [10 (1.1 + 8 * ((2:21) - 2) / 19)];
    alphas_ids = randperm(20) - 1;
    C(:,:,1) = lambda(1000^2, D, 1) / (1000 ^ (2/4));
    for k = 2:21
        alpha_i = 1000^(2*alphas_ids(k - 1)/19);
        lam = lambda(alpha_i, D, 1);
        C(:,:,k) = lam / alpha_i ^ (1/4);
    end
        
    function [ res ] = max_x(x) 
        
        max_x = -Inf;
        for i = 1:21
            curr = w(i) * exp( (-1/(2*D)) * (x - y(i,:)')' * R' * C(:,:,i) * R * (x - y(i,:)'));
            if curr > max_x
                max_x = curr;
            end
        end
        
        res = max_x;
    end

    function [res] = f22_compute(x)
        res = T_osz(10 - max_x(x))^2;
        
        if noisy
            res = res + 10 * randn();
        end
        
        res = res + f_pen(x) + f_opt;
    end

    f = @(x) f22_compute(x);

end

