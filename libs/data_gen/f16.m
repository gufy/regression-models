function [ f ] = f16( D, x_opt, f_opt, R, Q )
% Weierstrass Function
% One parameter version:
% a = 1/2;
% b = 3;
% x = 0:0.0001:1;
% y = zeros(1, length(x));
% for i = 1:length(x)
%     for k = 1:11
%         y(i) = y(i) + a^k * cos(b^k * pi * x(i));
%     end
% end
%
% plot(x,y);


    f_0 = 0;

    for j = 0:11
        f_0 = f_0 + (1/2)^j * cos(pi*3^j);
    end


    function [res] = f16_compute(x)
        
        z = R * lambda(1/100, D) * Q * T_osz(R*(x - x_opt));

        y = 0;

        for i = 1:D
            for k = 0:11
                y = y + (1/2)^k * cos(2*pi*3^k*(z(i) + 1/2));
            end
        end

        y = 10*(y/D - f_0)^3 + 10/D*f_pen(x) + f_opt;
        
        res = y;
    end

    f = @(x) f16_compute(x);

end

