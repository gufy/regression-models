setup;
setup_mail;

%% loading data

clear
load('data/wine.mat');
Y = y;
clear y;
inmodel = logical([ 1     0     0     0     0     0     0     0     0     0     0 ]);
X = X(:, inmodel);

%%

sX = X;
sY = Y;
%[sX, Xfw, Xbw] = minmaxNorm(X);
%[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

model_labels = {
        'Random Forests'
        'RBF NN'
        'GP'
        'Polynomial'
        'SVM'
        };
model_funs = { 
        @(x, y) forestsSim(x, y, {100, 10})
        @(x, y) nnSim(x, y, {1.2, 0.001, 25})
        @(x, y) gpSim(x, y, {1})
        @(x, y) polyfitSim(x, y)
        @(x, y) svmSim(x, y, {3, 2, 2})
        };
len = length(model_funs);
curr_labels = labels(inmodel);
f = figure;

for I = 1:len
    subplot(2, ceil(len/2), I);
    model = model_funs{I}(sX,sY);
    plotTrained1dModel(model, 50, min(sX), max(sX), 0, f);%, Xbw, Ybw);
    xlabel(curr_labels{1});
    ylabel('Quality [0-10]');
    title(model_labels{I});
    hold on;
    scatter(X, Y);
    hold off;
end