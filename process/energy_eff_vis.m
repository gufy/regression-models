load('data/ENB2012.mat');

%%
labels = {
    'X1	Relative Compactness',
    'X2	Surface Area',
    'X3	Wall Area',
    'X4	Roof Area', 
    'X5	Overall Height', 
    'X6	Orientation',
    'X7	Glazing Area', 
    'X8	Glazing Area Distribution', 
    };

figure;
for I = 1:8
    subplot(4,2,I);
    scatter(data(:,I),data(:,10));
    title(labels{I});
end

%%

X = data(:, 1:2);
Y = data(:, 10);

%%

X = minmaxNorm(X);
Y = minmaxNorm(Y);

%%

model = forestsSim(X, Y, {300, 3});

%%

model = gpSim(X, Y, {0.01});

%%

params = {{0.1, 0.01, 0.001}};
[test_err, train_err, params_comb] = crossValidateModel(@gpSim, X, Y, params);

%%

params = {{100, 200, 300, 400}};
[test_err, train_err, params_comb] = crossValidateModel(@forestsSim, X, Y, params);

%%

params = {{2, 1, 0.1}, {0.1, 0.01, 0.001}, {100}};
[test_err, train_err, params_comb] = crossValidateModel(@nnSim, X, Y, params);

%%

model = nnSim(X, Y, {0.15, 0.001, 100});

%%

f = figure;
scatter3(X(:,1), X(:,2), Y);
hold on;
plotTrainedModel(model, 100, min(X(:,1:2)), max(X(:,1:2)), 0, f);
%axis([0 1 0 1 -2 2]);

