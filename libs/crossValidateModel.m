function [ test_err, train_err, kendall ] = crossValidateModel( trainModel, X, T, params, crossval_setting, ping )

len = size(X, 1);

if nargin < 6
    ping = @() (1);
end

if nargin > 4
    k = crossval_setting.k;
    perm = crossval_setting.perm;
else
    k = 10;
    perm = randperm(len);
end

indices = mod(perm(1:len), k) + 1;

acc_train_err = 0;
acc_test_err = 0;
acc_kendall = 0;

tic;
for K = 1:k

    test_X = X(indices == K, :);
    test_T = T(indices == K);
    train_X = X(indices ~= K, :); 
    train_T = T(indices ~= K);

    [test_err, train_err, kendall] = computeModelErrorsWithCorrelation(trainModel, params, train_X, train_T, test_X, test_T);
    acc_train_err = acc_train_err + train_err;
    acc_test_err = acc_test_err + test_err;
    acc_kendall = acc_kendall + kendall;
    fprintf('.');
    
    ping();
end
fprintf('\n');
toc

train_err = acc_train_err / k;
test_err = acc_test_err / k;
kendall = acc_kendall / k;

fprintf('Train error: %f, test error: %f, correlation: %f\n\n', train_err, test_err, kendall);

end

