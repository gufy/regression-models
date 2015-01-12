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
[test_err, train_err, params_comb] = crossValidateModel(@forestsSim, X, Y, params);


%%

model = forestsSim(X, Y, {400, 5});
%Train error: 0.005579, test error: 0.013645

%% 1 4

XX = X(:, [1 4]);
[sX, Xfw, Xbw] = minmaxNorm(XX);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

params = {{100, 200, 300, 400}, {5}};
[test_err, train_err, params_comb] = crossValidateModel(@forestsSim, sX, sY, params);

%%

model = nnSim(sX, sY, {0.1, 0.014});
plotTrainedModel(model, 50, 0, 1, 0, 0, Xbw, Ybw);
xlabel(labels{1});
ylabel(labels{4});
zlabel('Quality [0-10]');
hold on;
scatter3(XX(:,1), XX(:,2), Y);


%%

crossValidateModel(@nnSim, sX, sY, {0.1, 0.014});