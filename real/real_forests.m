clear;
load('data.mat');

N = length(All.Composition);
%ids = randperm(N);
X = All.Composition;%(ids,:);
T1 = All.STYAcOH;%(ids,:);
T2 = All.STYC2H4;%(ids,:);

%% remove NaN rows

X = X(~isnan(X(:,1)),:);
T1 = T1(~isnan(X(:,1)));
T2 = T2(~isnan(X(:,1)));

%% normalize

X = minmaxNorm(X);

%% save

real.X = X;
real.T1 = T1;
real.T2 = T2;

save('real/real.mat', 'real');

%% split to training and testing sets

Y = T1;
N = length(Y);
ids = randperm(N);
X = X(ids,:);
Y = Y(ids);

test_N = floor(N / 4);

X_train = X(1:(N-test_N), :);
T_train = Y(1:(N-test_N), :);

X_test = X((N-test_N+1):N, :);
T_test = Y((N-test_N+1):N, :);

%%

params = struct('NTrees', 550, 'MinLeaf', 10 );
[test_err, train_err, kendall] = computeModelErrorsWithCorrelation(@forestsSim, params, X_train, T_train, X_test, T_test)

%%

params = struct('max', 400, 'eg', 1, 'sc', 1);
fun = @(X_train,Y_train,X_test,Y_test)(computeModelErrorsWithCorrelation(@nnSim, params, X_train, Y_train, X_test, Y_test));
idx = sequentialfs(fun, Xs, Ys)
