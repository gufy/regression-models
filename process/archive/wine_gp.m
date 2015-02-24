%%

clear
load('data/wine.mat');
Y = y;
clear y;

%%

figure;
for I = 1:11
    subplot(4,3,I);
    scatter(X(:,I),Y);
    title(labels{I});
end

%%

[sX, Xfw, Xbw] = minmaxNorm(X);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

params = {{100, 200, 300, 400}, {5}};
[test_err, train_err, params_comb] = crossValidateModel(@gpSim, X, Y, params);


%%

model = gpSim(X, Y, {0.1});

%% 1 4

XX = X(:, [1 4]);
[sX, Xfw, Xbw] = minmaxNorm(XX);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

params = {{1}};
[test_err, train_err, params_comb] = crossValidateModel(@gpSim, sX, sY, params);

%%

model = gpSim(sX, sY, {0.001});
plotTrainedModel(model, 50, 0, 1, 0, 0, Xbw, Ybw);
xlabel(labels{1});
ylabel(labels{4});
zlabel('Quality [0-10]');
hold on;
scatter3(XX(:,1), XX(:,2), Y);

%% nftool

model1 = @(x) sim(net, x');
plotTrainedModel(model1, 50, 0, 1, 0, 0, Xbw, Ybw);
hold on;
scatter3(XX(:,1), XX(:,2), Y);
