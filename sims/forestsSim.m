function [ res, err_tr ] = forestsSim( X, T, params )
% forestsSim( X, T, params )
%   From training data set X and T, it builds a model using params.
%
%   Parameters
%       X:      input training set
%       T:      target training set
%       params: model parameter
%
%   Returns
%       res:    an object with a predict method and a property model
%               containing the built model
%       err_tr: training error 
%

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

