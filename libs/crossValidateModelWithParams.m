function [ param_test_err, param_train_err, param_combs ] = crossValidateModelWithParams( trainModel, X, T, params, drawCallback )

if nargin < 5 
    drawCallback = 0;
end

if nargin < 4
    params = {1};
end

if size(params,2) > 1
    param_combs = allcombs(params{:});
elseif size(params, 1) == 1
    param_combs = params{1};
else
    param_combs = {};
end

param_train_err = zeros(1, length(params));
param_test_err = zeros(1, length(params));

len = size(X, 1);
crossval_setting.k = 10;
crossval_setting.perm = randperm(len);

for I = 1:size(param_combs, 1)
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
        if iscell(param_combs)
            params_i = param_combs{I};
        else
            params_i = param_combs(I);
        end
        
        if ischar(params_i)
            fprintf('Running params (%d/%d): %s \n', I, length(param_combs), params_i);
        else
            fprintf('Running params (%d/%d): %g \n', I, length(param_combs), cell2mat( params_i ));
        end
    end
    
    [train_err, test_err] = crossValidateModel(trainModel, X, T, params_i, crossval_setting);
    
    param_train_err(I) = train_err;
    param_test_err(I) = test_err;
    
    if isa(drawCallback, 'function_handle') && I > 1
        drawCallback(param_test_err, param_train_err, param_combs);
        pause(0.1);
    end
    
end

end

