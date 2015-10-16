clear;
load('data.mat');

%%

N = length(All.Composition);
ids = randperm(N);
Xs = All.Composition(ids,:);
Ys = All.STYAcOH(ids,:);


test_N = floor(N / 4);

X_train = Xs(1:(N-test_N), :);
T_train = Ys(1:(N-test_N), :);

X_test = Xs((N-test_N+1):N, :);
T_test = Ys((N-test_N+1):N, :);

%%

params = struct('MinLeaf', 4, 'NTrees', 500);
[test_err, train_err, kendall] = computeModelErrorsWithCorrelation(@forestsSim, params, X_train, T_train, X_test, T_test)

%%

params = struct('max', 400, 'eg', 1, 'sc', 1);
[test_err, train_err, kendall] = computeModelErrorsWithCorrelation(@nnSim, params, X_train, T_train, X_test, T_test)

%%

params = struct('max', 400, 'eg', 1, 'sc', 1);
fun = @(X_train,Y_train,X_test,Y_test)(computeModelErrorsWithCorrelation(@forestsSim, params, X_train, Y_train, X_test, Y_test));
idx = sequentialfs(fun, Xs, Ys);

%%


N = length(All.Composition);
ids = randperm(N);
Xs = All.Composition(ids,idx);
Ys = All.STYAcOH(ids,:);


test_N = floor(N / 4);

X_train = Xs(1:(N-test_N), :);
T_train = Ys(1:(N-test_N), :);

X_test = Xs((N-test_N+1):N, :);
T_test = Ys((N-test_N+1):N, :);

%%

params = struct('MinLeaf', 4, 'NTrees', 500);
[test_err, train_err, kendall] = computeModelErrorsWithCorrelation(@forestsSim, params, X_train, T_train, X_test, T_test)
