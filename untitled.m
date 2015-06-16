[X, T] = dataSample(@f15, 2, 1000, 5, -5);


scatter3(X(:,1), X(:,2), T);

%%

model = nnSim(X, T, struct('sc', 2, 'eg', 1, 'max', 1000));
%model = gpSim(X, T, struct('covfun', @covSEard, 'sn', 0.5, 'cov', log([ 0.1 ; 0.1 ; 1 ])))

%%

f = figure;
scatter3(X(:,1), X(:,2), T);
hold on;
plotTrained2dModel(model, 200, -4, 4, 0, f);
hold off;

%%

[Xtest, Ytest] = dataSample(@f15, 2, 1000, 5, -5);
[test_err, train_err] = computeModelErrors(@nnSim, struct('sc', 1, 'eg', 1, 'max', 1000), X, T, Xtest, Ytest)