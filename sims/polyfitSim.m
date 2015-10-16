function [ mdl, err_tr ] = polyfitSim( X, T, params )
% polyfitSim( X, T, params )
%   From training data set X and T, it builds a model using params.
%
%   Parameters
%       X:      input training set
%       T:      target training set
%       params: model parameters and hyper-parameters
%
%   Returns
%       res:    an object with a predict method and a property model
%               containing the built model
%       err_tr: training error 
%

method = 'quadratic';

if nargin > 2 && isfield(params, 'method') 
    method = params.method;
end

len = size(X,1);
mdl = fitlm(X,T,method);
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);

end

