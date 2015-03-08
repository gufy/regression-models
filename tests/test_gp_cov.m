D = 2;
N = 400;
maxInt = 5;
minInt = -5;

[XTrain, TTrain] = dataSample(@f15, D, N, maxInt, minInt);
model = gpSim(XTrain, TTrain, struct('covfun', @covSEard, 'sn', 0.1, 'cov', [1, 1.005, 2])); % [ell, sf]

[XTest, TTest] = dataSample(@f15, D, N, maxInt, minInt);
Y = model.predict(XTest);

test_err = (1/length(TTest))*sum((Y - TTest).^2);
fprintf('MSE=%f\n', test_err);

kendall = corr(TTest, Y, 'type', 'Kendall');
fprintf('corr(Kendall)=%f\n', kendall);

%%

hold on
plot3d(@f15);

%%

plotTrained2dModel(model, 200, maxInt, minInt);

%%

D = 2;
N = 200;

I = 1;
models{I} = struct('name', 'GP (SEard)', 'model', @gpSim);
covParams = [repmat({[0; 1]}, 1, D) {[0; 1]}];
models{I}.params = explodeStruct(struct('fun', @covSEard), allcombs([0.001; 1e-4], covParams{:}), {'sn', 'cov'})

[X, Y] = dataSample(@f15, D, N);
results = crossValidateModelsWithParams(models, X, Y);