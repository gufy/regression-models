function [ f ] = f23( D, params )
%F23 Katsuura Function
%   Properties Highly rugged and highly repetitive function with more than 10D global optima

if nargin < 1
    D = 2;
end

if nargin < 2
    params = default_params(D);
end

x_opt = params{1};
R = params{3};
Q = params{4};

function [s] = z_sum(x) 

    z = Q * lambda(100, D) * R * (x - x_opt);
    z = x;
    z_sum = 0;
    for i = 1:32
        z_sum = z_sum + abs( 2 ^ i * z - round( 2 ^ i * z ) ) / 2 ^ i;
    end
    
    s = z_sum;

end

f = @(x) ( 10 / (D ^ 2) * prod( 1 + (1:D) .* z_sum(x)' ) ^ (10 / D ^ 1.2) - 10 / D ^ 2 + f_pen(x) );

end

