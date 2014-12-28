
load('/Users/vojta/Documents/MATLAB/regression-models/data/ENB2012.mat')
X = data(:, 1:8);
Y = data(:, 10);

%%

X = minmaxNorm(X);
Y = minmaxNorm(Y);

%%

params = {{'-s'}, {3}, {'-t'}, {2}, {'-g'}, {20, 5, 1, 0.5, 0.1, 0.05}};
crossValidateModel(@svmSim,X,Y,params);

%%

model = svmSim(X, Y, {'-s', 3, '-t', 2, '-g', 20});

%%

[pred_Y, accuracy, prob_estimates] = svmpredict(Y, X, model);

%%

f = figure;
scatter3(X(:,1), X(:,2), Y);
hold on;
plotTrainedModel(model, 100, min(X(:,1:2)), max(X(:,1:2)), 0, f);

%%

