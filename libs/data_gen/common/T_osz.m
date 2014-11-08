function [ y ] = T_osz( x )

x_hat = log(abs(x));
x_hat(x == 0) = 0;

c_1 = ones(size(x)) * 10;
c_1(x <= 0) = 5.5;

c_2 = ones(size(x)) * 7.9;
c_2(x <= 0) = 3.1;

y = sign(x).*exp(x_hat + 0.049*(sin(c_1.*x_hat) + sin(c_2.*x_hat)));

end

