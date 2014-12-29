function [ results ] = crossValidateModels( models, X, T )

for M_I = 1:length(models)
    
    trainModel = models{M_I}.model;
    params = models{M_I}.params;
    
    fprintf('Model: %s\n', models{M_I}.name);
    
    param_combs = allcombs(params{:});
    param_train_err = zeros(1, length(params));
    param_test_err = zeros(1, length(params));

    len = size(X, 1);
    k = 10;
    perm = randperm(len);
    indices = mod(perm(1:len), 10) + 1;

    for I = 1:size(param_combs,1)
        params_i = 0;
        if size(param_combs, 2) > 1
            params_i = param_combs(I,:);
            fprintf('Running combination of params (%d/%d): ', I, size(param_combs, 1));
            for J = 1:length(params_i)
                val = num2str(params_i{J});
                fprintf('%s ', val);
            end
            fprintf('\n');
        else
            params_i = param_combs(I);
            fprintf('Running params (%d/%d): %g \n', I, length(param_combs), cell2mat( params_i ));
        end

        acc_train_err = 0;
        acc_test_err = 0;
        
        fprintf('Crossvalidating ');
        for K = 1:k
            fprintf('.');
            test_X = X(indices == K, :);
            test_T = T(indices == K);
            train_X = X(indices ~= K, :); 
            train_T = T(indices ~= K);

            [Out, model, train_err] = evalc('trainModel(train_X, train_T, params_i)');
            acc_train_err = acc_train_err + train_err;

            [Out, test_Y] = evalc('model(test_X)');
            test_err = (1/length(test_T))*sum((test_Y - test_T).^2);
            acc_test_err = acc_test_err + test_err;

        end
        fprintf('\n');

        param_train_err(I) = acc_train_err / k;
        param_test_err(I) = acc_test_err / k;

        fprintf('Train error: %f, test error: %f\n\n', param_train_err(I), param_test_err(I));

    end
    
    results{M_I}.train_err = param_train_err;
    results{M_I}.test_err = param_test_err;
    results{M_I}.params = param_combs;
    
end

end

