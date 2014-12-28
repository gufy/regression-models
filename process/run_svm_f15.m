
[X, T] = dataSample(@f15, 2, 2000);
[T, Tfw, Tbw] = minmaxNorm(T);

params = {{'-s'}, {3}, {'-t'}, {2}, {'-g'}, {0.001, 0.05, 0.1, 0.5, 1, 2, 5, 20, 40, 80}};

[test_err, train_err, params_comb] = crossValidateModel(@svmSim, X, T, params);

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

model = svmSim(X, T, {'-s', 3, '-t', 2, '-g', 5});
plotTrainedModel(model, 100);

