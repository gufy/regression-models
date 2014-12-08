function [ f ] = f15( D, params )
%
% Params:
%  x_opt = params{1};
%  f_opt = params{2};
%  R = params{3};
%  Q = params{4};

    if nargin < 1
        D = 2;
    end

    if nargin < 2
        params = default_params(D);
    end

    x_opt = params{1};
    f_opt = params{2};
    R = params{3};
    Q = params{4};

    function [res] = f15_compute(x)
        z = R * lambda(1.2, D) * Q * T_asy(T_osz(R*(x - x_opt)),0.2);
        %z = R * lambda(10, D) * Q * R*(x - x_opt);
        %z = R * lambda(10, D) * Q * R * (x - x_opt);
        z = R * Q * T_asy(T_osz(R * (x - x_opt)),0.2);
        res = 10 * (D - sum(cos(2*pi*z))) + sum(z.^2) + f_opt;
    end

    f = @(x) f15_compute(x);

end

