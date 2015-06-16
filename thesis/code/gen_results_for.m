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

% PLOT
colormap(jet)
[xq,yq] = meshgrid(linspace(minx, maxx, num_bins), linspace(miny, maxy, num_bins));
vq = griddata(Xs,Ys,Z,xq,yq, 'nearest');
surf(xq,yq,vq);
%set(gca,'zscale','log')
hold on;
scatter3(Xs,Ys,Z,'MarkerEdgeColor',[1 1 1],...
                      'MarkerFaceColor',[1 .2 .2])
set(gca,'linewidth',2)
set(gca, 'YDir', 'normal') % flip Y axis back to normal
az = 0;
el = 90;
view(az, el);
hold off;

%scatter3(keys_all(1,:), keys_all(2,:), vals_all, 64, vals_all, 'filled')
%set(gca,'yscale','log')

end

