function [ predict, err_tr ] = polySim( X, T )

len = size(X,1);
mdl = fitlm(X,T,'quadratic');
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);
predict = @(x) (mdl.predict(x));

end

