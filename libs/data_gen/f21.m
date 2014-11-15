function [ f21_y ] = f21( x, x_opt, f_opt, R, Q )
%F21 Gallagher?s Gaussian 101-me Peaks Function
%   

D = length(x);

y = zeros(101, D);
y(1,:) = rand(1,D) * 8 - 4;
y(2:101,:) = rand(100,D) * (2 * 4.9) -  4.9;

w = [10 (1.1 + 8 * ((2:101) - 2) / 99)];

C(:,:,1) = lambda(1000, D) / (1000 ^ (1/4));
for i = 2:101
    j = round(rand() * 19);
    alpha_i = 1000^(2*j/19);
    lam = lambda(alpha_i, D);
    C(:,:,i) = lam / alpha_i ^ (1/4);
end

max_x = -Inf;
for i = 1:101 
    curr = w(i) * exp( (-1/(2*D)) * (x - y(i,:)')' * R' * C(:,:,i) * R * (x - y(i,:)'));
    if curr > max_x
        max_x = curr;
    end
end

f21_y = T_osz(10 - max_x)^2 + f_pen(x) + f_opt;

end

