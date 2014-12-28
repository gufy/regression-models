function [ model, err_tr ] = nnSim( X, T, params )
%NNSIM Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    params = {};
end

if length(params) > 2
    max = params{3}
else
    max = 0; % sum-squared error goal
end

if length(params) > 1
    eg = params{2}
else
    eg = 1.5; % sum-squared error goal
end

if ~isempty(params) 
    sc = params{1};
else
    sc = 1;    % spread constant
end

len = size(X,1);
D = size(X, 2);
if max
    net = newrb(X',T',eg,sc,max);
else
    net = newrb(X',T',eg,sc);
end

Y = net(X');
err_tr = (1/len) * sum((Y' - T).^2);
model = @(x) net(x')';

end

