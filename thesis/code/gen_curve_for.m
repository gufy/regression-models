function [ ] = gen_results_for( results, method, dataset )

labels = [];
keys_all = [];
vals_all = [];
train_all = [];

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
        train = el.Trainerrormean;
        
        vals_all = [vals_all val];
        train_all = [train_all train];
        
    end
    
end

Xs = keys_all(1,:);
Ys = keys_all(2,:);

if method == 'RBF-NN'
    Ys = keys_all(3,:);
end

% create the bins
minx = min(Xs);
maxx = max(Xs);
miny = min(Ys);
maxy = max(Ys);

num_bins = 32;


% transform
max_v = max(vals_all);
min_v = min(vals_all);
Z = vals_all; %(vals_all - min_v) / max_v;
Z_train = train_all;

% PLOT
scatter(Xs, Z);
lin = linspace(minx, maxx, num_bins);
vq = griddata(Xs,Z,li,xq,yq)

hold on;
scatter(Xs, Z_train);
fit = polyfit(Xs, Z_train, 3);
h = refcurve(fit);


end

