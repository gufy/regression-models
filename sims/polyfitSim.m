function [ mdl, err_tr ] = polyfitSim( X, T, params )

method = 'quadratic';

if nargin > 2 && isfield(params, 'method') 
    method = params.method;
end

len = size(X,1);
mdl = fitlm(X,T,method);
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);

end

