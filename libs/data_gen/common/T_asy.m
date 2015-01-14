function [ y ] = T_asy( x, beta )

y = x;
D = length(x);

if D > 1
    for i = 1:D
        if y(i) > 0
            y(i) = y(i) .^ (1 + beta*(i - 1)/(D - 1)*sqrt(y(i)));
        end
    end
end

end

