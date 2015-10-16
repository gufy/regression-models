function [ results ] = crossValidateModelsWithParams( models, X, T, callback )
% crossValidateModelsWithParams( models, X, T, callback, ping )
%   For each parameter setup, we run a cross validation to get the data.
%
%   Use callback handler to perform any additional action after the cross
%   validation is finished. I.e. store the results to database.
%
%   Returns an array of struct, where for each model, there is test_err,
%   train_err, and kendall. It also contains the params.


for M_I = 1:length(models)
    
    name = models{M_I}.name;
    trainModel = models{M_I}.model;
    params = models{M_I}.params;
    
    fprintf('Model: %s\n', models{M_I}.name);
    
    [param_test_err, param_train_err, kendall, param_combs] = crossValidateModelWithParams( trainModel, X, T, params,... 
        @(dataset_name, datetime_started, models, results, time) callback(name, dataset_name, datetime_started, models, results, time)...
    );
    
    results{M_I}.train_err = param_train_err;
    results{M_I}.test_err = param_test_err;
    results{M_I}.kendall = kendall;
    results{M_I}.params = param_combs;
    
end

end

