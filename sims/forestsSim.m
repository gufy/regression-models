function [ res, err_tr ] = forestsSim( X, T, params )

if nargin < 3 
    params = {};
end

if isfield(params, 'NTrees')
    NTrees = params.NTrees;
else
    NTrees = 100;
end

if isfield(params, 'MinLeaf')
    MinLeaf = params.MinLeaf;
else
    MinLeaf = 5;
end

if isfield(params, 'NVarToSample') 
    NVarToSample = params.NVarToSample;
else
    NVarToSample = 0;
end

len = size(X,1);
if NVarToSample
    mdl = TreeBagger(NTrees,X,T,'Method','regression','MinLeaf',MinLeaf,'NVarToSample',NVarToSample);
else
    mdl = TreeBagger(NTrees,X,T,'Method','regression','MinLeaf',MinLeaf);
end
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);
res.predict = @(x) (mdl.predict(x));
res.model = mdl;

end

