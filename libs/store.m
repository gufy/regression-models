function [ ] = store( method, dataset_name, datetime_started, models, results )

    if nargin < 5
        save2db = 0;
    end

    results.method = method;
    results.dataset = dataset_name;
    results.parameters = ['"', struct2str(models), '"'];
    paramstr = struct2str(results, ' ');
    
    system(['php php/save.php ', paramstr]);

end

