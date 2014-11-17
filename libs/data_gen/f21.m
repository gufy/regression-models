function [ f ] = f21( D, x_opt, f_opt, R, Q )
%F21 Gallagher?s Gaussian 101-me Peaks Function
%   

    w = [10 (1.1 + 8 * ((2:101) - 2) / 99)];
    
    C(:,:,1) = lambda(1000, D, 1) / (1000 ^ (1/4));
    y = zeros(101,D);
    y(1,:) = rand(1,D) * 8 - 4;
    for k = 1:101
        j = round(rand() * 19);
        alpha_i = 1000^(2*j/19);
        lam = lambda(alpha_i, D, 1);
        C(:,:,k) = lam / alpha_i ^ (1/4);
        y(k,:) = rand(1,D) * (2 * 4.9) -  4.9;
    end
    
    function [ res ] = max_x(x)

        max_x = -Inf;
        for i = 1:101
            curr = w(i) * exp( (-1/(2*D)) * (x - y(i,:)')' * R' * C(:,:,i) * R * (x - y(i,:)'));
            if curr > max_x
                max_x = curr;
            end
        end

        res = max_x;
        
    end

    f = @(x) ( T_osz(10 - max_x(x))^2 + f_pen(x) + f_opt );

end

