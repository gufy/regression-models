function [ test_err, train_err, kendall, test_err_s, train_err_s, kendall_s, time ] = crossValidateModel( trainModel, X, T, params, crossval_setting )
% crossValidateModel( trainModel, X, T, params, crossval_setting, ping )
%   For a given trainModel, data set X with target values T, params for the
%   trainModel, crossvalidation settings and ping is called everytime the
%   the cross validation is over.
%
%   Parameters
%       trainModel:         a function to train a model
%       X:                  training input data set
%       T:                  training target data set
%       params:             model parameters
%       crossval_settings:  settings to set parameters to cross validation,
%                           default crossval_setting.k = 10, crossval_setting.perm = randperm(len)
%       
%
%   Returns:
%       test_err:           MSE on the testing data set, mean value from 10-fold
%                           cross validation.
%       train_err:          MSE on the training data set, mean value from 10-fold
%                           cross validation.
%       kendall:            Kendall's rank coefficient on the testing data
%                           set, mean value from 10-fold cross validation.
%       test_err_s:         Variance of the MSE on the testing data set
%                           from 10-fold cross validation.
%       train_err_s:        Variance of the MSE on the training data set
%                           from 10-fold cross validation.
%       kendal_s:           Variance of the Kendall on the testing data set
%                           from 10-fold cross validation.
%       time:               Total time to calculate the 10-fold cross
%                           validation


len = size(X, 1);

if nargin > 4
    k = crossval_setting.k;
    perm = crossval_setting.perm;
else
    k = 10;
    perm = randperm(len);
end

indices = mod(perm(1:len), k) + 1;

acc_train_err = zeros(1, k);
acc_test_err = zeros(1, k);
acc_kendall = zeros(1, k);

tic;
for K = 1:k

    test_X = X(indices == K, :);
    test_T = T(indices == K);
    train_X = X(indices ~= K, :); 
    train_T = T(indices ~= K);

    [test_err, train_err, kendall] = computeModelErrorsWithCorrelation(trainModel, params, train_X, train_T, test_X, test_T);
    acc_train_err(K) = train_err;
    acc_test_err(K) = test_err;
    acc_kendall(K) = kendall;
    fprintf('.');
    
end
fprintf('\n');
time = toc;
fprintf('Elapased time: %f\n', time);

train_err = sum(acc_train_err) / k;
train_err_s = sqrt((1/(k-1)) * sum((acc_train_err - train_err) .^ 2)); 

test_err = sum(acc_test_err) / k;
test_err_s = sqrt((1/(k-1)) * sum((acc_test_err - test_err) .^ 2)); 

kendall = sum(acc_kendall) / k;
kendall_s = sqrt((1/(k-1)) * sum((acc_kendall - kendall) .^ 2)); 

fprintf('Train error: %f, test error: %f, correlation: %f\n', train_err, test_err, kendall);
fprintf('Train sigma: %f, test sigma: %f, corr. sigma: %f\n\n', train_err_s, test_err_s, kendall_s);

end

