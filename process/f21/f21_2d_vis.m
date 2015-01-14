
clear;
[X, Y] = dataSample(@f21, 1, 45);

[X, Xfw, Xbw] = minmaxNorm(X);
[Y, Yfw, Ybw] = minmaxNorm(Y);

f = figure;
plotData(X, Y);
hold on;
h = plot2d(@f21, 100, 0, 0, Xfw, Yfw);
h(1).LineStyle = '--';
h(1).Color = 'k';

%%

model = gpSim(X, Y, {0.1});
%model = nnSim(X, Y, {1.2, 0.0001});
%model = forestsSim(X, Y, {100, 3});

%%

[~, h] = plotTrained1dModel(model, 100, 0, 1, 0, f);
h(1).Color = 'r';
h(1).LineWidth = 1;
