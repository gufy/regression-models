function [ ] = gen_times_for( results, method )

times_all = [];
dims_all = [];

c = 0;
for I = 1:size(results,1) 
    
    el = results(I,:);
    if strcmp(el.Method, method)
       
        c = c + 1;
        time = el.Comptimes;
        
        dim_str = el.Dataset{1};
        arr = strsplit(dim_str, '-');
        dim = str2num(strrep(arr{2}, 'd', ''));
        
        times_all = [times_all time];
        dims_all = [dims_all dim];
        
    end
    
end

scatter(dims_all, times_all);

%scatter3(keys_all(1,:), keys_all(2,:), vals_all, 64, vals_all, 'filled')
%set(gca,'yscale','log')

end

