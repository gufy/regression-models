function [ ] = nnSim( X, T )
%NNSIM Summary of this function goes here
%   Detailed explanation goes here

D = size(X, 2)
eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X,T,eg,sc)

X = linspacem(-5,5,100,D); size(X)
Y = net(X); 
Y
size(Y)

plot(X, Y);

end

