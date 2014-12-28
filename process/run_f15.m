
clear models;
models{1} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, {2, 5}};

models{2} = struct('name', 'GP', 'model', @gpSim);
models{2}.params = {{0.001, 0.1, 1}};

[X, T] = dataSample(@f15, 2, 2000);
[T, Tfw, Tbw] = minmaxNorm(T);

results = crossValidateModels(models, X, T);

%%

y = [0.001, 0.05, 0.1, 0.5, 1, 2, 5, 20, 40, 80];
plot(y, test_err);
set(gca, 'xscale', 'log');
set(gca, 'xtick', y);

hold on;
plot(y, train_err, '--');
legend('Test', 'Train');
hold off;

%%

model = svmSim(X, T, { 3, 2, 5 });
plotTrainedModel(model, 100);

