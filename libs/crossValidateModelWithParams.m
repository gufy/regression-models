function [ param_test_err, param_train_err, param_kendall, params ] = crossValidateModelWithParams( trainModel, X, T, params, callback, ping )

if nargin < 5 
    callback = 0;
end

param_train_err = zeros(2, length(params));
param_test_err = zeros(2, length(params));
param_kendall = zeros(2, length(params));

len = size(X, 1);
crossval_setting.k = 10;
crossval_setting.perm = randperm(len);

for I = 1:length(params)
    if iscell(params)
        params_item = params{I};
    else
        params_item = params(I);
    end
    fields = fieldnames(params_item);
    
    fprintf('Running combination of params (%d/%d): ', I, length(params));
    for J = 1:numel(fields)
        key = fields{J};
        if ischar(params_item.(key))
            value = params_item.(key);
        else
            if isa(params_item.(key), 'function_handle')
                value = func2str(params_item.(key));
            else
                value = num2str(params_item.(key));
            end
        end
        fprintf('%s=%s, ', key, value);
    end
    
    fprintf('\n');
    
    [test_err, train_err, kendall, test_s, train_s, kendall_s, time] = crossValidateModel(trainModel, X, T, params_item, crossval_setting, ping);
    
    param_train_err(:,I) = [train_err, train_s];
    param_test_err(:,I) = [test_err, test_s];
    param_kendall(:,I) = [kendall, kendall_s];
    
    if isa(callback, 'function_handle')
        callback([test_err, test_s], [train_err, train_s], [kendall, kendall_s], params_item, time);
        pause(0.1);
    end
    
end

end

