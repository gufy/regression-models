function [ results ] = crossValidateModelsWithParams( models, X, T, callback, ping )

for M_I = 1:length(models)
    
    name = models{M_I}.name;
    trainModel = models{M_I}.model;
    params = models{M_I}.params;
    
    fprintf('Model: %s\n', models{M_I}.name);
    
    [param_test_err, param_train_err, kendall, param_combs] = crossValidateModelWithParams( trainModel, X, T, params,... 
        @(dataset_name, datetime_started, models, results, time) callback(name, dataset_name, datetime_started, models, results, time),...
        ping... 
    );
    
    results{M_I}.train_err = param_train_err;
    results{M_I}.test_err = param_test_err;
    results{M_I}.kendall = kendall;
    results{M_I}.params = param_combs;
    
end

end

