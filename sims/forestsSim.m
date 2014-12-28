function [ predict, err_tr ] = forestsSim( X, T, params )

if nargin < 3 
    params = {};
end

if ~isempty(params)
    NTrees = params{1};
else
    NTrees = 100;
end

if length(params) > 1
    MinLeaf = params{2};
else
    MinLeaf = 5;
end
    
len = size(X,1);
mdl = TreeBagger(NTrees,X,T,'Method','regression','MinLeaf',MinLeaf);
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);
predict = @(x) (mdl.predict(x));

end

