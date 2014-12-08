function [ predict, err_tr ] = forestsSim( X, T )

len = size(X,1);
NTrees = 100;
mdl = TreeBagger(NTrees,X,T,'Method','regression');
err_tr = (1/len) * sum((mdl.predict(X) - T).^2);
predict = @(x) (mdl.predict(x));

end

