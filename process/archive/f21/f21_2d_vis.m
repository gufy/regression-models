
clear;
[X, Y] = dataSample(@f21, 1, 120);

[X, Xfw, Xbw] = minmaxNorm(X);
[Y, Yfw, Ybw] = minmaxNorm(Y);


%% 30

%model = gpSim(X, Y, {1.00E-03});
%model = forestsSim(X, Y, {100	1}};%150, 5});
%model = nnSim(X, Y, {1	1.00E-05	25});

% {1.2, 0.0001, 1000});


%% 120

model = gpSim(X, Y, {10});
%model = forestsSim(X, Y, {100, 1});
%model = nnSim(X, Y, {0.1	1.00E-05	150});

%%


f = figure;
plotData(X, Y);
hold on;
h = plot2d(@f21, 100, 0, 0, Xfw, Yfw);
h(1).LineStyle = '--';
h(1).Color = 'k';

%%

[~, h] = plotTrained1dModel(model, 1000, 0, 1, 0, f);
h(1).Color = 'r';
h(1).LineWidth = 1;

Y2 = model(X);
err = (1/length(Y))*sum((Y2 - Y).^2);
title(['GP [ err = ', num2str(err), ' ]']);

%%


