
clear;
[X, Y] = dataSample(@f21, 2, 900);

[X, Xfw, Xbw] = minmaxNorm(X);
[Y, Yfw, Ybw] = minmaxNorm(Y);


%% 30

%model = gpSim(X, Y, {1.00E-03});
%model = forestsSim(X, Y, {100	1}};%150, 5});
%model = nnSim(X, Y, {1	1.00E-05	25});

% {1.2, 0.0001, 1000});


%% 900

%model = gpSim(X, Y, {0.01});
%model = forestsSim(X, Y, {650	1});
model = nnSim(X, Y, {0.1	0.001	300});

%%


f = figure;
plotData(X, Y);
hold on;
h = plot2d(@f21, 100, 0, 0, Xfw, Yfw);
h(1).LineStyle = '--';
h(1).Color = 'k';

%%

f = figure;
plotTrained2dModel(model, 100, 0, 1, 0, f);

Y2 = model(X);
err = (1/length(Y))*sum((Y2 - Y).^2);
title(['RBF [ err = ', num2str(err), ' ]']);

%%


