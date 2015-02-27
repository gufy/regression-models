function [ res, err_tr ] = nnSim( X, T, params )
%NNSIM Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    params = {};
end

if isfield(params, 'max')
    max = params.max;
else
    max = 0; % sum-squared error goal
end

if isfield(params, 'eg')
    eg = params.eg;
else
    eg = 1.5; % sum-squared error goal
end

if isfield(params, 'sc')
    sc = params.sc;
else
    sc = 1; % spread of rbf
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
predict = @(x) net(x')';

res.predict = predict;
res.model = net;

end

