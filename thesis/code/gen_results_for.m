function [ ] = gen_results_for( results, method, dataset )

labels = [];
keys_all = [];
vals_all = [];

c = 0;
for I = 1:size(results,1) 
    
    el = results(I,:);
    if strcmp(el.Method, method) && strcmp(el.Dataset, dataset)
       
        c = c + 1;
        pars_str = el.Parameters{1};
        pars = strsplit(pars_str, ',');
        
        keys = [];
        for J = 1:length(pars)
            par = strsplit(pars{J},'=');
            k = par{1};
            v = str2num(par{2});
            
            if isempty(labels) || ~strcmp(labels,k) || isempty(find(labels == k))
                labels = [labels k];
            end
            
            keys = [keys; v];
            
        end
        
        keys_all = [keys_all keys];
        
        val = el.Testerrormean;
        
        vals_all = [vals_all val];
        
    end
    
end

scatter3(keys_all(1,:), keys_all(2,:), vals_all, 64, vals_all, 'filled')
set(gca,'yscale','log')

end

