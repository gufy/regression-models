function [ f ] = f15( D, x_opt, f_opt, R, Q )

    function [res] = f15_compute(x)
        z = R * lambda(10, D) * Q * T_asy(T_osz(R*(x - x_opt)),0.2);
        %z = R * lambda(10, D) * Q * R*(x - x_opt);
        %z = R * lambda(10, D) * Q * R * (x - x_opt);
        %z = T_asy(T_osz((x - x_opt)),0.2);
        res = 10 * (D - sum(cos(2*pi*z))) + sum(z.^2) + f_opt;
    end

    f = @(x) f15_compute(x);

end

