function [ predict, err_tr ] = polyfitSim( X, T, params )

method = 'quadratic';
len = size(X,1);
mdl = fitlm(X,T,method);
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);
predict = @(x) (mdl.predict(x));

end

