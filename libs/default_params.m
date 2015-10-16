function [ params ] = default_params( D )
% default_params( D ) - for dimension D, create default params setup which
% can be used for functions f15 to f24
%

if nargin < 1
    D = 2;
end

R = eye(D);
Q = R;

x_opt_val = zeros(D,1);
f_opt_val = 0;

params = {x_opt_val, f_opt_val, R, Q, 1};

end

