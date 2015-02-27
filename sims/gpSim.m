function [ res, err_tr ] = gpSim( X, T, params )
%gpSim
%   params needs to be fully expanded. here it is an object with all params

if nargin < 3 
    params = {};
end

if isfield(params,'sn')
    sn = params.sn;
else
    sn = 0.1;
end

if isfield(params,'cov')
    hyp2.cov = params.cov;
else
    hyp2.cov = [0 ; 0];
end
   
len = size(X,1);

if isfield(params.covfun)
    covfunc = params.covfun;
    if ~isfield(params.cov)
        error('cov is not defined in params');
    end
else
    covfunc = @covSEiso; %covRQiso, covMaterniso
    hyp2.cov = [0 ; 0];
end

likfunc = @likGauss;     
hyp2.lik = log(sn);
[O, hyp2] = evalc('minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, T)');
  
fprintf('\ncov=');
fprintf('%f, ', hyp2.cov)
fprintf(' lik=%f\n', hyp2.lik)

Y = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, X);
err_tr = (1/len) * sum((Y - T).^2);

function [m, cond] = predictFun(x)

    [m, cond] = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, x);
    cond = 2*sqrt(cond);

end

res.predict = @predictFun;
res.model.hyp = hyp2;

end

