setup;
setup_mail;

%% loading data

clear
load('data/wine.mat');
Y = y;
clear y;
inmodel = logical([ 1     0     0     0     0     0     0     0     1     0     0 ]);
X = X(:, inmodel);

%%

[sX, Xfw, Xbw] = minmaxNorm(X);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

curr_labels = labels(inmodel);
model = gpSim(sX, sY, {0.5});
plotTrained2dModel(model, 50, 0, 1, 0, 0, Xbw, Ybw);
xlabel(curr_labels{1});
ylabel(curr_labels{2});
zlabel('Quality [0-10]');
hold on;
scatter3(X(:,1), X(:,2), Y);