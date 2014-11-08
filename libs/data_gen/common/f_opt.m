function [ y ] = f_opt( )
% drawn from Cauchy distribution 
% with zero median and with roughly 50% of the values between -100 and 100

y = trnd(1,1,1) * 100;

y = round(y * 100)/100;

if (abs(y) > 1000) 
    y = 1000 * sign(y);
end

end

