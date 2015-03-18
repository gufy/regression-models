function [ ] = store( method, dataset_name, datetime_started, models, results, time )

    results.method = method;
    results.dataset = dataset_name;
    results.parameters = struct2str(models);
    results.time = time;
    
    paramstr = struct2str(results, '&');
    %system(['php php/save.php ', paramstr]);
    urlread(['http://vojtechkopal.cz/regressions/save.php?', paramstr]);

end

