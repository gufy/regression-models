function [ res, err_tr ] = gpSim( X, T, params )

if nargin < 3 
    params = {};
end

if ~isempty(params)
    sn = params{1};
else
    sn = 0.1;
end
   
len = size(X,1);
covfunc = @covSEiso; 
likfunc = @likGauss; 

hyp2.cov = [0 ; 0];    
hyp2.lik = log(sn);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, T);
  
Y = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, X);
err_tr = (1/len) * sum((Y - T).^2);

function [m, cond] = predictFun(x)

    [m, cond] = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, x);
    cond = 2*sqrt(cond);

end

res.predict = @predictFun;
res.model.hyp = hyp2;

end

