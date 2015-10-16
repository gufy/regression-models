function [ ] = store( method, dataset_name, datetime_started, models, results, time, noisy )
% store( method, dataset_name, datetime_started, models, results, time, noisy )
%       Sends a result from an experiment to a server where it can be
%       stored to database.
%
%   Parameters
%       method:             a method name
%       dataset_name:       a name of the data set
%       datetime_started:   a time string when the computation started
%       models:             a struct with parameters
%       results:            a struct with results
%       time:               a time to run the experiment
%       noisy:              whether the data set was with a noise or not
%

    results.method = method;
    results.dataset = dataset_name;
    results.parameters = struct2str(models);
    results.time = time;
    results.noisy = noisy;
    
    paramstr = struct2str(results, '&');
    urlread(['http://vojtechkopal.cz/regressions/save.php?', paramstr]);

end

