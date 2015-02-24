%%

clear
load('data/wine.mat');
Y = y;
clear y;

%%

[sX, Xfw, Xbw] = minmaxNorm(X);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

f = @(X_tr,Y_tr,X_ts,Y_ts) computeModelErrors(@nnSim, {1.1, 0.01, 100}, X_tr, Y_tr, X_ts, Y_ts);

%% 1     0     0     0     0     0     0     0     1     0     0
% alcohol, sulphates

inmodel = sequentialfs(f, sX, sY);


