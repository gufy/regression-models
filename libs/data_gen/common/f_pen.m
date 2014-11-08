function [ out ] = f_pen( x )

out = sum(max(0, max(abs(x) - 5)) .^ 2);

end

