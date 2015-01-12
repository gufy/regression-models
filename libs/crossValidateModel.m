function [ test_err, train_err ] = crossValidateModel( trainModel, X, T, params, crossval_setting )

len = size(X, 1);

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
for K = 1:k

    test_X = X(indices == K, :);
    test_T = T(indices == K);
    train_X = X(indices ~= K, :); 
    train_T = T(indices ~= K);

    [Out, model, train_err] = evalc('trainModel(train_X, train_T, params)');
    acc_train_err = acc_train_err + train_err;
        
    [Out, test_Y] = evalc('model(test_X)');
    test_err = (1/length(test_T))*sum((test_Y - test_T).^2);
    acc_test_err = acc_test_err + test_err;

end

train_err = acc_train_err / k;
test_err = acc_test_err / k;

fprintf('Train error: %f, test error: %f\n\n', train_err, test_err);

end

