function [ param_test_err, param_train_err, param_combs ] = crossValidateModel( trainModel, X, T, params, drawCallback )

if nargin < 5 
    drawCallback = 0;
end

if nargin < 4
    params = {1};
end

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
            if ischar(params_i{J})
                val = params_i{J};
            elseif isnumeric(params_i{J})
                val = num2str(params_i{J});
            end
            
            fprintf('%s ', val);
        end
        fprintf('\n');
    else
        params_i = param_combs(I);
        fprintf('Running params (%d/%d): %g \n', I, length(param_combs), cell2mat( params_i ));
    end
    
    acc_train_err = 0;
    acc_test_err = 0;
    for K = 1:k
    
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
    
    param_train_err(I) = acc_train_err / k;
    param_test_err(I) = acc_test_err / k;
    
    fprintf('Train error: %f, test error: %f\n\n', param_train_err(I), param_test_err(I));
    
    if isa(drawCallback, 'function_handle') && I > 1
        drawCallback(param_test_err, param_train_err, param_combs);
        pause(0.1);
    end
    
end

end

