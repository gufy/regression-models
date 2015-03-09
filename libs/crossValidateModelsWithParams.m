function [ results ] = crossValidateModelsWithParams( models, X, T, progressCallback, ping )

for M_I = 1:length(models)
    
    trainModel = models{M_I}.model;
    params = models{M_I}.params;
    
    fprintf('Model: %s\n', models{M_I}.name);
    
    [param_train_err, param_test_err, kendall, param_combs] = crossValidateModelWithParams( trainModel, X, T, params, 0, ping );
    
    results{M_I}.train_err = param_train_err;
    results{M_I}.test_err = param_test_err;
    results{M_I}.kendall = kendall;
    results{M_I}.params = param_combs;
    
    if nargin > 3 && isa(progressCallback, 'function_handle') 
        progressCallback(results, models);
    end
    
end

end

