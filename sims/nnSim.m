function [ net ] = nnSim( X, T )
%NNSIM Summary of this function goes here
%   Detailed explanation goes here

D = size(X, 2);
eg = 1.5; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X',T',eg,sc);

end

